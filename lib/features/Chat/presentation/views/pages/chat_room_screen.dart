import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:zoom_clone/core/resources/methods.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/core/widgets/empty_pic_widget.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_messages_cubit/get_chat_messages_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_messages_cubit/get_chat_messages_state.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/chat_message_bar.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/chat_room_appbar.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/messages/message_widget.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/user_image.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';

class ChatRoomScreen extends StatefulWidget {
  const ChatRoomScreen({super.key, required this.userData});
  final UserDataModel userData;

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FlutterSoundRecorder _audioRecorder = FlutterSoundRecorder();
  bool isRecording = false;
  bool isRecorderInitialized = false;

  Future<void> initRecorder() async {
    await _audioRecorder.openRecorder();
    isRecorderInitialized = true;
  }

  Future<bool> requestMicPermission() async {
    final status = await Permission.microphone.request();
    return status.isGranted;
  }

  Future<void> startVoiceRecording() async {
    bool hasPermission = await requestMicPermission();
    if (!hasPermission) {
      print("Microphone permission denied");
      return;
    }

    await _audioRecorder.openRecorder();

    final tempDir = await getTemporaryDirectory();
    final path =
        '${tempDir.path}/voice_${DateTime.now().millisecondsSinceEpoch}.aac';

    await _audioRecorder.startRecorder(
      toFile: path,
      codec: Codec.aacADTS,
    );

    setState(() {
      isRecording = true;
    });
  }

  Future<void> stopAndSendVoice() async {
    try {
      final path = await _audioRecorder.stopRecorder();

      setState(() {
        isRecording = false;
      });

      if (path == null || path.isEmpty) {
        print("No recording was made.");
        return;
      }

      final voiceFile = File(path);
      final voiceUrl = await Methods.uploadVoiceToCloudinary(voiceFile);

      if (voiceUrl != null) {
        final myUid = FirebaseAuth.instance.currentUser!.uid;
        final otherUid = widget.userData.uid ?? "";

        ChatMessage message = ChatMessage(
          message: '', // or you can omit this if nullable
          voiceUrl: voiceUrl,
          isFromMe: true,
          time: DateTime.now(),
        );

        await sendMessage(myUid, otherUid, message);
      } else {
        print("Failed to upload voice message.");
      }
    } catch (e) {
      print("Error while stopping or sending voice: $e");
      setState(() {
        isRecording = false;
      });
    }
  }

  Future<void> createChatRoomIfNotExists(String myUid, String otherUid) async {
    final chatRoomRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(myUid)
        .collection('chatrooms')
        .doc(otherUid);

    final chatRoomSnapshot = await chatRoomRef.get();

    if (!chatRoomSnapshot.exists) {
      final chatRoom = ChatRoom(
        imageUrl: widget.userData.photoUrl ?? "",
        userName: widget.userData.name ?? "",
        chatRoomId: chatRoomRef.id,
        otherUserId: otherUid,
        createdAt: DateTime.now(),
      );

      await chatRoomRef.set(chatRoom.toMap());
    }
  }

  Future<void> sendMessage(
      String myUid, String otherUid, ChatMessage message) async {
    await createChatRoomIfNotExists(myUid, otherUid);
    await createChatRoomIfNotExists(
        otherUid, myUid); // Create for the other user too

    final myChatRoomRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(myUid)
        .collection('chatrooms')
        .doc(otherUid);

    final otherChatRoomRef = FirebaseFirestore.instance
        .collection('chats')
        .doc(otherUid)
        .collection('chatrooms')
        .doc(myUid);

    // Update sender's chatroom
    await myChatRoomRef.update({
      'messages': FieldValue.arrayUnion([message.toMap()])
    });

    // Update receiver's chatroom
    await otherChatRoomRef.update({
      'messages':
          FieldValue.arrayUnion([message.copyWith(isFromMe: false).toMap()])
    });
    context.read<GetChatMessagesCubit>().addMessageLocally(message);
    setState(() {});
  }

  @override
  void dispose() {
    _audioRecorder.closeRecorder();
    _scrollController.dispose();
    _messageController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    context
        .read<GetChatMessagesCubit>()
        .fetchChatMessages(widget.userData.uid ?? "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: ChatRoomAppbar(
        automaticallyImplyLeading: false,
        titleChild: Row(
          children: [
            widget.userData.photoUrl == "none"
                ? EmptyPicWidget(
                    userFirstLetter:
                        widget.userData.name?.substring(0, 1).toUpperCase() ??
                            "")
                : UserImage(imageUrl: widget.userData.photoUrl ?? ""),
            SizedBox(width: 10.w),
            nameandActive(),
            const Spacer(),
            IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.phone, size: 20)),
            IconButton(
                onPressed: () {},
                icon: const Icon(FontAwesomeIcons.video, size: 20)),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
              child: BlocBuilder<GetChatMessagesCubit, GetChatMessagesState>(
            builder: (context, state) {
              if (state is GetChatMessagesSuccessState) {
                final chatMessages = state.chatMessages;
                return ListView.builder(
                  controller: _scrollController,
                  padding:
                      EdgeInsets.symmetric(vertical: 10.h, horizontal: 12.w),
                  itemCount: chatMessages.length,
                  itemBuilder: (context, index) {
                    final message = chatMessages[index];
                    return MessageWidget(message: message);
                  },
                );
              } else if (state is GetChatMessagesFailureState) {
                return const Center(
                    child: Text('Failed to load chat messages.'));
              } else {
                return const Center(child: Text("Loading messages"));
              }
            },
          )),
          ChatInputBar(
            controller: _messageController,
            onSend: () async {
              String myUid = FirebaseAuth.instance.currentUser!.uid;
              String otherUid = widget.userData.uid ?? "";

              if (_messageController.text.trim().isNotEmpty) {
                ChatMessage message = ChatMessage(
                  message: _messageController.text.trim(),
                  isFromMe: true,
                  time: DateTime.now(),
                );
                _messageController.clear();
                await sendMessage(myUid, otherUid, message);

                ;
              }
            },
            onRecord: () async {
              if (isRecording) {
                await stopAndSendVoice();
              } else {
                await startVoiceRecording();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget nameandActive() {
    String? active = widget.userData.active == true ? "Active Now" : "Inactive";
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(widget.userData.name?.split(' ')[0] ?? "",
            style: AppStyles.s18Bold),
        Text(active, style: AppStyles.s14Regular),
      ],
    );
  }
}

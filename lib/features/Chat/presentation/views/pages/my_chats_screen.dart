import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/firebase_methods.dart';
import 'package:zoom_clone/core/widgets/custom_body.dart';
import 'package:zoom_clone/core/widgets/screen_upper_part.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_room_model.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_rooms_cubit/get_chat_rooms_cubit.dart';
import 'package:zoom_clone/features/Chat/presentation/cubits/get_chat_rooms_cubit/get_chat_rooms_state.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/chat_room_widget.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/status_widget.dart';
import 'package:zoom_clone/features/Contacts/data/models/user_data_model.dart';

class MyChatsScreen extends StatelessWidget {
  const MyChatsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.blackColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const ScreenUpperPart(
                title: "Home",
                isHome: true,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                child: StatusWidget(),
              ),
              Padding(
                  padding: const EdgeInsets.only(top: 20.0),
                  child: BlocConsumer<GetChatRoomsCubit, GetChatRoomsState>(
                    listener: (context, state) {
                      if (state is GetChatRoomsFailureState) {
                        // Show error
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.message)),
                        );
                      }
                    },
                    builder: (context, state) {
                      print("BlocConsumer rebuild: $state");

                      if (state is GetChatRoomsLoadingState) {
                        return Center(child: CircularProgressIndicator());
                      } else if (state is GetChatRoomsSuccessState) {
                        final chatRooms = state.chatRooms;
                        return CustomBody(
                          itemCount: chatRooms.length,
                          itemBuilder: (context, index) {
                            return ChatRoomWidget(
                              messages: chatRooms[index].messages,
                              userData: UserDataModel(
                                  name: chatRooms[index].userName,
                                  photoUrl: chatRooms[index].imageUrl ?? "none",
                                  uid: chatRooms[index].otherUserId),
                            );
                          },
                        );
                      } else if (state is GetChatRoomsFailureState) {
                        return Center(
                            child: Text('Failed to load chat rooms.'));
                      } else {
                        return SizedBox.shrink();
                      }
                    },
                  )),
            ],
          ),
        ),
      ),
    );
  }
}

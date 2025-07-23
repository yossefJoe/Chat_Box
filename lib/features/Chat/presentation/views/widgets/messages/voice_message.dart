import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:just_audio/just_audio.dart';
import 'package:zoom_clone/core/resources/color_manager.dart';
import 'package:zoom_clone/core/resources/styles_manager.dart';
import 'package:zoom_clone/features/Chat/data/models/chat_message_model.dart';
import 'package:zoom_clone/features/Chat/presentation/views/widgets/messages/time_widget.dart';

class VoiceMessage extends StatefulWidget {
  final ChatMessage message;

  const VoiceMessage({super.key, required this.message});

  @override
  State<VoiceMessage> createState() => _VoiceMessageState();
}

class _VoiceMessageState extends State<VoiceMessage> {
  late AudioPlayer _audioPlayer;
  bool isPlaying = false;
  double speed = 1.0;
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void initState() {
    super.initState();
    _audioPlayer = AudioPlayer();
    _initAudio();
  }

  Future<void> _initAudio() async {
    await _audioPlayer.setUrl(widget.message.voiceUrl!);

    _audioPlayer.durationStream.listen((d) {
      if (d != null) {
        setState(() => duration = d);
      }
    });

    _audioPlayer.positionStream.listen((p) {
      setState(() => position = p);
    });

    _audioPlayer.playerStateStream.listen((state) {
      setState(() => isPlaying = state.playing);
    });
  }

  String _formatDuration(Duration d) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    return "${twoDigits(d.inMinutes)}:${twoDigits(d.inSeconds % 60)}";
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  void _changeSpeed() {
    setState(() {
      if (speed == 1.0) {
        speed = 1.5;
      } else if (speed == 1.5) {
        speed = 2.0;
      } else if (speed == 2.0) {
        speed = 0.5;
      } else {
        speed = 1.0;
      }
    });
    _audioPlayer.setSpeed(speed);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300.w,
      margin: EdgeInsets.symmetric(vertical: 6.h),
      padding: EdgeInsets.symmetric(horizontal: 14.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: widget.message.isFromMe
            ? ColorManager.chatMeColor.withOpacity(0.7)
            : ColorManager.greyColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              /// 🔁 Switch between profile image and speed control
              isPlaying
                  ? TextButton(
                      onPressed: _changeSpeed,
                      child: Text("${speed}x"),
                    )
                  : Container(
                      width: 50.w,
                      height: 50.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                          image:
                              NetworkImage(widget.message.senderImageUrl ?? ""),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),

              SizedBox(width: 8.w),

              IconButton(
                icon: Icon(
                  isPlaying ? Icons.pause : Icons.play_arrow,
                ),
                iconSize: 36,
                onPressed: () async {
                  if (isPlaying) {
                    await _audioPlayer.pause();
                  } else {
                    await _audioPlayer.play();
                  }
                },
              ),

              /// 🎚 Slider
              Expanded(
                child: Slider(
                  
                  activeColor: Colors.blue,
                  min: 0.0,
                  max: duration.inMilliseconds.toDouble(),
                  value: position.inMilliseconds
                      .toDouble()
                      .clamp(0.0, duration.inMilliseconds.toDouble()),
                  onChanged: (value) async {
                    await _audioPlayer
                        .seek(Duration(milliseconds: value.toInt()));
                  },
                ),
              ),
            ],
          ),

          /// 🕒 Duration
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Text(
                  "${_formatDuration(position)} / ${_formatDuration(duration)}",
                  style: AppStyles.s12Regular
                      .copyWith(color: ColorManager.whiteColor),
                ),
              ),
              TimeWidget(message: widget.message),
            ],
          ),
        ],
      ),
    );
  }
}

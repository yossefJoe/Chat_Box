import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class VoiceMessage extends StatefulWidget {
  final String audioUrl;
  const VoiceMessage({super.key, required this.audioUrl});

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
    await _audioPlayer.setUrl(widget.audioUrl);

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            IconButton(
              icon: Icon(isPlaying ? Icons.pause_circle : Icons.play_circle),
              iconSize: 36,
              onPressed: () async {
                if (isPlaying) {
                  await _audioPlayer.pause();
                } else {
                  await _audioPlayer.play();
                }
              },
            ),
            Icon(Icons.graphic_eq, size: 30),
            const SizedBox(width: 10),
            Text(
              "${_formatDuration(position)} / ${_formatDuration(duration)}",
              style: const TextStyle(fontSize: 14),
            ),
            const Spacer(),
            TextButton(
              onPressed: _changeSpeed,
              child: Text("${speed}x"),
            ),
          ],
        ),
        Slider(
          min: 0.0,
          max: duration.inMilliseconds.toDouble(),
          value: position.inMilliseconds
              .toDouble()
              .clamp(0.0, duration.inMilliseconds.toDouble()),
          onChanged: (value) async {
            await _audioPlayer.seek(Duration(milliseconds: value.toInt()));
          },
        ),
      ],
    );
  }
}

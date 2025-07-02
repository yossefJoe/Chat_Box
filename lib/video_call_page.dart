import 'package:flutter/material.dart';
import 'package:agora_rtc_engine/agora_rtc_engine.dart';
import 'package:permission_handler/permission_handler.dart';

class VideoCallPage extends StatefulWidget {
  final String channelName;
  final String currentUserId;
  final String otherUserId;

  const VideoCallPage({
    Key? key,
    required this.channelName,
    required this.currentUserId,
    required this.otherUserId,
  }) : super(key: key);

  @override
  State<VideoCallPage> createState() => _VideoCallPageState();
}

class _VideoCallPageState extends State<VideoCallPage> {
  static const String appId =
      'bda2b18334ec4ad1a92132a51bde874e'; // Your Agora App ID
  static const String token =
      '007eJxTYGi/u3dbp1q7zuKi6kJPWXlf7il3ur+FXhd/oOu8f+OxmwwKDEkpiUZJhhbGxiapySaJKYaJlkaGxkaJpoZJKakW5iap1y4nZzQEMjLk79rGysgAgSA+J4NjflFiSGpxiSEDAwAjcSJU'; // Empty if token disabled in console

  late final RtcEngine _engine;
  bool _localUserJoined = false;
  int? _remoteUid;

  @override
  void initState() {
    super.initState();
    _initAgora();
  }

  // Register event handlers
  void _setupEventHandlers() {
    _engine.registerEventHandler(
      RtcEngineEventHandler(
        onJoinChannelSuccess: (RtcConnection connection, int elapsed) {
          debugPrint(
              "Local user ${connection.localUid} joined channel ${connection.channelId}");
          setState(() => _localUserJoined = true);
        },
        onUserJoined: (RtcConnection connection, int remoteUid, int elapsed) {
          debugPrint("Remote user $remoteUid joined");
          setState(() => _remoteUid = remoteUid);
        },
        onUserOffline: (RtcConnection connection, int remoteUid,
            UserOfflineReasonType reason) {
          debugPrint("Remote user $remoteUid left, reason: $reason");
          setState(() => _remoteUid = null);
        },
        onError: (ErrorCodeType code, String msg) {
          debugPrint('Agora Error: $code, $msg');
        },
      ),
    );
  }

  Future<void> _initAgora() async {
    // Request permissions and verify
    final statuses = await [Permission.camera, Permission.microphone].request();
    if (statuses[Permission.camera] != PermissionStatus.granted ||
        statuses[Permission.microphone] != PermissionStatus.granted) {
      debugPrint('Permissions not granted!');
      return;
    }

    _engine = createAgoraRtcEngine();
    await _engine.initialize(RtcEngineContext(appId: appId));
    _setupEventHandlers();
    await _engine.setClientRole(role: ClientRoleType.clientRoleBroadcaster);

    await _engine.enableVideo();

    // Optional: startPreview before joining channel (comment out if issues)
    await _engine.startPreview();

    final localUid = widget.currentUserId.hashCode & 0x7fffffff;

    await _engine.joinChannel(
      token: token,
      channelId: widget.channelName,
      uid: localUid,
      options: const ChannelMediaOptions(),
    );
  }

  @override
  void dispose() {
    _engine.leaveChannel();
    _engine.release();
    super.dispose();
  }

  Widget _renderLocalVideo() {
    if (_localUserJoined) {
      final localUid = widget.currentUserId.hashCode & 0x7fffffff;
      return FittedBox(
        fit: BoxFit.contain,
        child: SizedBox(
          width: 120, // Match the size of your small container
          height: 160,
          child: AgoraVideoView(
            controller: VideoViewController(
              rtcEngine: _engine,
              canvas: const VideoCanvas(uid: 0), // <-- important
            ),
          ),
        ),
      );
    } else {
      return const Center(child: Text('Joining channel...'));
    }
  }

  Widget _renderRemoteVideo() {
    if (_remoteUid != null) {
      return AgoraVideoView(
        controller: VideoViewController.remote(
          rtcEngine: _engine,
          canvas: VideoCanvas(uid: _remoteUid!),
          connection: RtcConnection(channelId: widget.channelName),
        ),
      );
    } else {
      return const Center(child: Text('Waiting for other user...'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Agora Video Call')),
      body: Stack(
        children: [
          Positioned.fill(child: _renderRemoteVideo()),
          Positioned(
            top: 32,
            left: 16,
            width: 120,
            height: 160,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Container(
                color: Colors.black54,
                child: _renderLocalVideo(),
              ),
            ),
          ),
          Positioned(
            bottom: 32,
            left: 32,
            right: 32,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              onPressed: () => Navigator.pop(context),
              child: const Text('End Call'),
            ),
          ),
        ],
      ),
    );
  }
}

class ChatMessage {
  final String? message;
  final String? voiceUrl;
  final bool isFromMe;
  final bool? isMedia;
  final bool? isVoiceCall;
  final bool? isVideoCall;
  final bool? isLocation;
  final DateTime time;
  final bool isRead;

  ChatMessage({
    this.voiceUrl,
    this.message,
    required this.isFromMe,
    this.isMedia ,
    this.isVoiceCall ,
    this.isVideoCall,
    this.isLocation ,
     this.isRead = false,
    required this.time,
  });

  Map<String, dynamic> toMap() => {
        'voiceUrl': voiceUrl,
        'message': message,
        'isFromMe': isFromMe,
        'isMedia': isMedia,
        'isVoiceCall': isVoiceCall,
        'isVideoCall': isVideoCall,
        'time': time.toIso8601String(),
        'isLocation': isLocation,
        'isRead': isRead,
      };
  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      voiceUrl: map['voiceUrl'],
      message: map['message'] ?? '',
      isFromMe: map['isFromMe'] ?? false,
      isMedia: map['isMedia'] ?? false,
      isVoiceCall: map['isVoiceCall'] ?? false,
      isVideoCall: map['isVideoCall'] ?? false,
      time: DateTime.parse(map['time']),
      isLocation: map['isLocation'] ?? false,
      isRead: map['isRead'] ?? false,
    );
  }
  ChatMessage copyWith({
    String? message,
    bool? isFromMe,
    String? voiceUrl,
    DateTime? time,
    bool? isMedia,
    bool? isVoiceCall,
    bool? isVideoCall,
    bool? isLocation,
    bool? isRead,
  }) {
    return ChatMessage(
      message: message ?? this.message,
      isFromMe: isFromMe ?? this.isFromMe,
      voiceUrl: voiceUrl ?? this.voiceUrl,
      time: time ?? this.time,
      isMedia: isMedia ?? this.isMedia,
      isVoiceCall: isVoiceCall ?? this.isVoiceCall,
      isVideoCall: isVideoCall ?? this.isVideoCall,
      isLocation: isLocation ?? this.isLocation,
      isRead: isRead ?? this.isRead,
    );
  }
}

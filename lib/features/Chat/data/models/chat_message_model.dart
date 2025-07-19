class ChatMessage {
  final String? message;
  final String? voiceUrl;
  final bool isFromMe;
  final String? imageUrl;
  final bool? isVoiceCall;
  final bool? isVideoCall;
  final bool? isLocation;
  final DateTime time;
  final bool isRead;
  final Map<String, dynamic>? contact; // 👈 NEW FIELD

  ChatMessage({
    this.voiceUrl,
    this.message,
    required this.isFromMe,
    this.imageUrl,
    this.isVoiceCall,
    this.isVideoCall,
    this.isLocation,
    this.contact,
    this.isRead = false,
    required this.time,
  });

  Map<String, dynamic> toMap() => {
        'voiceUrl': voiceUrl,
        'message': message,
        'isFromMe': isFromMe,
        'imageUrl': imageUrl,
        'isVoiceCall': isVoiceCall,
        'isVideoCall': isVideoCall,
        'time': time.toIso8601String(),
        'isLocation': isLocation,
        'isRead': isRead,
        'contact': contact, // 👈 Save the contact map
      };

  factory ChatMessage.fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      voiceUrl: map['voiceUrl'],
      message: map['message'] ?? '',
      isFromMe: map['isFromMe'] ?? false,
      imageUrl: map['imageUrl'],
      isVoiceCall: map['isVoiceCall'] ?? false,
      isVideoCall: map['isVideoCall'] ?? false,
      time: DateTime.parse(map['time']),
      isLocation: map['isLocation'] ?? false,
      isRead: map['isRead'] ?? false,
      contact: map['contact'], // 👈 Load the contact map
    );
  }

  ChatMessage copyWith({
    String? message,
    bool? isFromMe,
    String? voiceUrl,
    DateTime? time,
    String? imageUrl,
    bool? isVoiceCall,
    bool? isVideoCall,
    bool? isLocation,
    bool? isRead,
    Map<String, dynamic>? contact, // 👈 Add to copyWith
  }) {
    return ChatMessage(
      message: message ?? this.message,
      isFromMe: isFromMe ?? this.isFromMe,
      voiceUrl: voiceUrl ?? this.voiceUrl,
      time: time ?? this.time,
      imageUrl: imageUrl ?? this.imageUrl,
      isVoiceCall: isVoiceCall ?? this.isVoiceCall,
      isVideoCall: isVideoCall ?? this.isVideoCall,
      isLocation: isLocation ?? this.isLocation,
      isRead: isRead ?? this.isRead,
      contact: contact ?? this.contact,
    );
  }
}

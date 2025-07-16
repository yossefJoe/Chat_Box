import 'package:intl/intl.dart';

class DateFormatter {
  /// Format: HH:mm:ss (24-hour format with seconds)
  static String formatTimeHMS(DateTime dateTime) {
    return DateFormat('HH:mm:ss').format(dateTime);
  }

  /// Format: HH:mm (24-hour format without seconds)
  static String formatTimeHM(DateTime dateTime) {
    return DateFormat('HH:mm').format(dateTime);
  }

  /// Format: hh:mm a (12-hour format with AM/PM)
  static String formatTime12Hour(DateTime dateTime) {
    return DateFormat('hh:mm a').format(dateTime);
  }

  /// Format: hh:mm:ss a (12-hour format with seconds and AM/PM)
  static String formatTime12HourWithSeconds(DateTime dateTime) {
    return DateFormat('hh:mm:ss a').format(dateTime);
  }

  /// Format: yyyy-MM-dd
  static String formatDateYMD(DateTime dateTime) {
    return DateFormat('yyyy-MM-dd').format(dateTime);
  }

  /// Format: dd/MM/yyyy
  static String formatDateDMY(DateTime dateTime) {
    return DateFormat('dd/MM/yyyy').format(dateTime);
  }

  /// Format: full date and time: dd MMM yyyy, hh:mm a
  static String formatFullDateTime(DateTime dateTime) {
    return DateFormat('dd MMM yyyy, hh:mm a').format(dateTime);
  }

  /// Format: custom format
  static String formatCustom(DateTime dateTime, String pattern) {
    return DateFormat(pattern).format(dateTime);
  }

  /// Parse a string to DateTime from a given pattern
  static DateTime parse(String dateString, String pattern) {
    return DateFormat(pattern).parse(dateString);
  }


static String formatWhatsAppTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);

  if (difference.inDays == 0) {
    return DateFormat('h:mm a').format(dateTime);
  } else if (difference.inDays == 1) {
    return 'Yesterday';
  } else if (difference.inDays < 7) {
    return DateFormat('EEEE').format(dateTime); // Day name
  } else {
    return DateFormat('dd/MM/yy').format(dateTime);
  }
}
static String formatTimeAgo(DateTime lastMessageTime) {
  final now = DateTime.now();
  final difference = now.difference(lastMessageTime);

  if (difference.inMinutes < 1) {
    return 'Just now';
  } else if (difference.inMinutes < 60) {
    return '${difference.inMinutes} min ago';
  } else if (difference.inHours < 24) {
    return '${difference.inHours} hr ago';
  } else if (difference.inDays < 7) {
    return '${difference.inDays} days ago';
  } else if (difference.inDays < 30) {
    final weeks = (difference.inDays / 7).floor();
    return '$weeks week${weeks > 1 ? 's' : ''} ago';
  } else {
    return '${lastMessageTime.day}/${lastMessageTime.month}/${lastMessageTime.year}';
  }
}

}

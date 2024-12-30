import 'package:intl/intl.dart';

class SFormatter {
  static String formatDate(DateTime? date) {
    date ??= DateTime.now();
    return DateFormat('MMM dd, yyyy').format(date);
  }

  static formatTime(DateTime time){
   return  DateFormat('h:mm a').format(time);
  }

  static String formatCurrency(double amount) {
    return NumberFormat.currency(locale: 'en_US', symbol: '\$').format(amount);
  }

  static String formatPhoneNumber(String phoneNumber) {
    if (phoneNumber.length == 10) {
      return '(${phoneNumber.substring(0, 3)}) ${phoneNumber.substring(3, 6)} ${phoneNumber.substring(6)}';
    } else if (phoneNumber.length == 11) {
      return '(${phoneNumber.substring(0, 4)}) ${phoneNumber.substring(4, 7)} ${phoneNumber.substring(7)}';
    }
    return phoneNumber;
  }

  static String formatSeconds(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '${minutes.toString().padLeft(1, '0')}:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  // static String timeAgoFormatter(DateTime time) {
  //   if (time.difference(DateTime.now()).inDays > -1) {
  //     if (time.difference(DateTime.now()).inHours > -1) {
  //       if (time.difference(DateTime.now()).inMinutes > -1) {
  //         return '0 min ago';
  //       } else {
  //         int rem = time.difference(DateTime.now()).inMinutes.removeNegative;
  //         return '$rem min${rem > 1 ? 's' : ''} ago';
  //       }
  //     } else {
  //       int rem = time.difference(DateTime.now()).inHours.removeNegative;
  //       return '$rem hour${rem > 1 ? 's' : ''} ago';
  //     }
  //   } else {
  //     int rem = time.difference(DateTime.now()).inDays.removeNegative;
  //     return '$rem day${rem > 1 ? 's' : ''} ago';
  //   }
  // }
}

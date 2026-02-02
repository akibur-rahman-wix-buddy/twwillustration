// import 'package:intl/intl.dart';

// class DateFormatter {
//   static String formatChatTime(String apiDate) {
//     try {
//       DateTime dateTime = DateTime.parse(apiDate).toLocal();
//       DateTime now = DateTime.now();
      
//       Duration difference = now.difference(dateTime);
      
//       if (difference.inMinutes < 60 && difference.inMinutes >= 0) {
//         if (difference.inMinutes < 1) {
//           return 'Just now';
//         }
//         return '${difference.inMinutes} min';
//       }
      
//       DateTime dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
//       DateTime today = DateTime(now.year, now.month, now.day);
//       DateTime yesterday = today.subtract(const Duration(days: 1));
      
//       if (dateOnly == today) {
//         return DateFormat('h:mm a').format(dateTime);
//       } else if (dateOnly == yesterday) {
//         // Yesterday
//         return 'Yesterday';
//       } else {
//         return DateFormat('dd/MM/yy').format(dateTime);
//       }
//     } catch (e) {
//       return apiDate;
//     }
//   }
// }


import 'package:intl/intl.dart';

class DateFormatter {
  static String formatChatTime(String apiDate) {
    try {
      DateTime dateTime;
      
      if (apiDate.contains('Z') || apiDate.contains('+') || apiDate.contains('T') && apiDate.split('T')[1].contains('-')) {
        dateTime = DateTime.parse(apiDate).toLocal();
      } else {
        dateTime = DateTime.parse(apiDate);
      }
      
      DateTime now = DateTime.now();
      
      Duration difference = now.difference(dateTime);
      
      if (difference.inMinutes < 60 && difference.inMinutes >= 0) {
        if (difference.inMinutes < 1) {
          return 'Just now';
        }
        return '${difference.inMinutes} min';
      }
      
      DateTime dateOnly = DateTime(dateTime.year, dateTime.month, dateTime.day);
      DateTime today = DateTime(now.year, now.month, now.day);
      DateTime yesterday = today.subtract(const Duration(days: 1));
      
      if (dateOnly == today) {
        return DateFormat('h:mm a').format(dateTime);
      } else if (dateOnly == yesterday) {
        return 'Yesterday';
      } else {
        return DateFormat('dd/MM/yy').format(dateTime);
      }
    } catch (e) {
      print('DateFormatter error: $e for date: $apiDate');
      return 'Invalid date';
    }
  }
  
  static String formatChatTimeFlexible(String apiDate) {
    try {
      String dateToProcess = apiDate;
      if (!apiDate.contains('Z') && 
          !apiDate.contains('+') && 
          apiDate.contains('T')) {
        dateToProcess = '${apiDate}Z';
      }
      
      return formatChatTime(dateToProcess);
    } catch (e) {
      return 'N/A';
    }
  }
}
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';

// void showSnackBarMessage(
//   BuildContext context,
//   String message, {
//   Color bgColor = Colors.black,
//   Duration duration = const Duration(seconds: 2),
// }) {
//   ScaffoldMessenger.of(context).showSnackBar(
//     SnackBar(
//       content: Text(
//         message,
//         style: TextStyle(
//           fontSize: 14.sp,
//           color: Colors.white,
//           fontWeight: FontWeight.bold,
//         ),
//         textAlign: TextAlign.center,
//       ),
//       backgroundColor: bgColor,
//       duration: duration,
//       behavior: SnackBarBehavior.floating,
//       margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
//     ),
//   );
// }


import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
    GlobalKey<ScaffoldMessengerState>();

void showSnackBarMessage(
  String message, String s, {
  Color bgColor = Colors.black,
  Duration duration = const Duration(seconds: 2),
}) {
  final messenger = scaffoldMessengerKey.currentState;
  if (messenger == null) return;

  messenger
    ..hideCurrentSnackBar()
    ..showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(
            fontSize: 14.sp,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
          textAlign: TextAlign.center,
        ),
        backgroundColor: bgColor,
        duration: duration,
        behavior: SnackBarBehavior.floating,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
      ),
    );
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../assets_helper/app_colors.dart';


class CustomSteper extends StatelessWidget {
  final dynamic circleColor1;
  final dynamic circleColor2;
  final dynamic circleColor3;
  final dynamic lineColor1;
  final dynamic lineColor2;
  const CustomSteper(
      {super.key,
      this.circleColor1,
      this.circleColor2,
      this.circleColor3,
      this.lineColor1,
      this.lineColor2});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircleAvatar(
          backgroundColor:circleColor1?? AppColor.primaryColor,
          radius: 11.r,
        ),
        Expanded(
            child: Container(
          height: 6.h,
          width: double.infinity,
          color:lineColor1?? AppColor.primaryColor,
        )),
        CircleAvatar(
          backgroundColor:circleColor2?? AppColor.primaryColor,
          radius: 11.r,
        ),
        Expanded(
            child: Container(
          height: 6.h,
          width: double.infinity,
          color: lineColor2??AppColor.primaryColor,
        )),
        CircleAvatar(
          backgroundColor:circleColor3?? AppColor.primaryColor,
          radius: 11.r,
        ),
      ],
    );
  }
}

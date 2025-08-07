// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import '../assets_helper/app_colors.dart';
// import '../assets_helper/app_fonts.dart';
//
// class CustomTextfield extends StatefulWidget {
//   final String? hintText;
//   final String? labelText;
//   final TextEditingController? controller;
//   final TextInputType? inputType;
//   final double? fieldHeight;
//   final double? minHeight;
//   final int? maxline;
//   final String? Function(String?)? validator;
//   final bool? validation;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final bool? isObsecure;
//   final bool? isPass;
//   final FocusNode? focusNode;
//   final TextInputAction? textInputAction;
//   final Function(String)? onFieldSubmitted;
//   final Function(String)? onChanged;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextStyle? labelStyle;
//   final TextStyle? style;
//   final bool? isEnabled;
//   final double? cursorHeight;
//   final Color? disableColor;
//   final bool? isRead;
//   final double? borderRadius;
//   final Color? fillColor;
//   final TextStyle? hintTextSyle;
//   final Color? borderColor;
//   final TextAlign? textAlign;
//   final VoidCallback? ontap;
//   final EdgeInsetsGeometry? contentPadding;
//
//
//   const CustomTextfield({
//     super.key,
//     this.hintText,
//     this.labelText,
//     this.controller,
//     this.inputType,
//     this.fieldHeight,
//     this.minHeight,
//     this.maxline,
//     this.validator,
//     this.validation,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.isObsecure = false,
//     this.isPass = false,
//     this.focusNode,
//     this.textInputAction = TextInputAction.next,
//     this.onFieldSubmitted,
//     this.onChanged,
//     this.inputFormatters,
//     this.labelStyle,
//     this.isEnabled,
//     this.style,
//     this.cursorHeight,
//     this.disableColor,
//     this.isRead = false,
//     this.borderRadius,
//     this.fillColor,
//     this.hintTextSyle,
//     this.borderColor,
//     this.textAlign = TextAlign.left,
//     this.ontap,
//     this.contentPadding,  TextInputType? keyboardType,
//   });
//
//   @override
//   State<CustomTextfield> createState() => _CustomTextfieldState();
// }
//
// class _CustomTextfieldState extends State<CustomTextfield> {
//   late bool _obscureText;
//
//   @override
//   void initState() {
//     _obscureText = widget.isObsecure ?? false;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     final height = widget.fieldHeight != null
//         ? (widget.minHeight != null
//         ? widget.fieldHeight!.clamp(widget.minHeight!, double.infinity)
//         : widget.fieldHeight)
//         : widget.minHeight;
//
//     return Container(
//       height: height ?? 55.h,
//       decoration: BoxDecoration(
//         color: const Color(0xFFFCF6ED),
//         border: Border.all(
//           color: Colors.red,
//           width: 1
//         ),// Cream background
//         borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
//       ),
//       padding: widget.contentPadding ??
//           EdgeInsets.symmetric(horizontal: 16.w, vertical: 0),
//       alignment: Alignment.center,
//       child: Row(
//         children: [
//           if (widget.prefixIcon != null) ...[
//             Padding(
//               padding: EdgeInsets.only(right: 8.w),
//               child: widget.prefixIcon!,
//             ),
//           ],
//           Expanded(
//             child: TextFormField(
//               textAlign: widget.textAlign!,
//               readOnly: widget.isRead ?? false,
//               cursorHeight: widget.cursorHeight ?? 20,
//               focusNode: widget.focusNode,
//               obscureText: _obscureText,
//               onTap: widget.ontap,
//               textInputAction: widget.textInputAction,
//               validator: widget.validator,
//               maxLines: widget.maxline ?? 1,
//               controller: widget.controller,
//               onFieldSubmitted: widget.onFieldSubmitted,
//               onChanged: widget.onChanged,
//               inputFormatters: widget.inputFormatters,
//               enabled: widget.isEnabled,
//               obscuringCharacter: "*",
//               keyboardType: widget.inputType,
//               style: widget.style ??
//                   TextFontStyle.textStyle16w400c5C5C5C.copyWith(
//                     color: AppColors.c333333,
//                   ),
//               decoration: InputDecoration(
// border: InputBorder.none,
//                 isCollapsed: true,
//
//                 hintText: widget.hintText,
//                 hintStyle: widget.hintTextSyle ??
//                     TextFontStyle.textStyle16w400c5C5C5C.copyWith(
//                       color: AppColors.cC0C0C0,
//                       fontWeight: FontWeight.w400,
//                     ),
//               ),
//             ),
//           ),
//           if (widget.isPass == true)
//             IconButton(
//               onPressed: () {
//                 setState(() {
//                   _obscureText = !_obscureText;
//                 });
//               },
//               icon: Icon(
//                 _obscureText ? Icons.visibility_off : Icons.visibility,
//                 color: AppColors.cC0C0C0,
//               ),
//               padding: EdgeInsets.zero,
//               constraints: const BoxConstraints(),
//             )
//           else if (widget.suffixIcon != null) ...[
//             Padding(
//               padding: EdgeInsets.only(left: 8.w),
//               child: widget.suffixIcon!,
//             ),
//           ],
//         ],
//       ),
//     );
//   }
// }





import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../assets_helper/app_colors.dart';
import '../assets_helper/app_fonts.dart';
//
// class CustomTextfield extends StatefulWidget {
//   final String? hintText;
//   final String? labelText;
//   final TextEditingController? controller;
//   final TextInputType? inputType;
//   final double? fieldHeight;
//   final int? maxline;
//   final String? Function(String?)? validator;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final bool? isObsecure;
//   final bool? isPass;
//   final FocusNode? focusNode;
//   final TextInputAction? textInputAction;
//   final Function(String)? onFieldSubmitted;
//   final Function(String)? onChanged;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextStyle? labelStyle;
//   final TextStyle? style;
//   final bool? isEnabled;
//   final double? cursorHeight;
//   final Color? disableColor;
//   final bool? isRead;
//   final double? borderRadius;
//   final Color? fillColor;
//   final TextStyle? hintTextSyle;
//   final Color? borderColor;
//   final TextAlign? textAlign;
//   final VoidCallback? ontap;
//   final EdgeInsetsGeometry? contentPadding;
//
//   const CustomTextfield({
//     super.key,
//     this.hintText,
//     this.labelText,
//     this.controller,
//     this.inputType,
//     this.fieldHeight,
//     this.maxline,
//     this.validator,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.isObsecure = false,
//     this.isPass = false,
//     this.focusNode,
//     this.textInputAction = TextInputAction.next,
//     this.onFieldSubmitted,
//     this.onChanged,
//     this.inputFormatters,
//     this.labelStyle,
//     this.isEnabled,
//     this.style,
//     this.cursorHeight,
//     this.disableColor,
//     this.isRead = false,
//     this.borderRadius,
//     this.fillColor,
//     this.hintTextSyle,
//     this.borderColor,
//     this.textAlign = TextAlign.left,
//     this.ontap,
//     this.contentPadding,
//   });
//
//   @override
//   State<CustomTextfield> createState() => _CustomTextfieldState();
// }
//
// class _CustomTextfieldState extends State<CustomTextfield> {
//   late bool _obscureText;
//
//   @override
//   void initState() {
//     _obscureText = widget.isObsecure ?? false;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       textAlign: widget.textAlign!,
//       readOnly: widget.isRead ?? false,
//       cursorHeight: widget.cursorHeight ?? 20,
//       focusNode: widget.focusNode,
//       obscureText: _obscureText,
//       onTap: widget.ontap,
//       textInputAction: widget.textInputAction,
//       validator: widget.validator,
//       maxLines: widget.maxline ?? 1,
//       controller: widget.controller,
//       onFieldSubmitted: widget.onFieldSubmitted,
//       onChanged: widget.onChanged,
//       inputFormatters: widget.inputFormatters,
//       enabled: widget.isEnabled,
//       obscuringCharacter: "*",
//       keyboardType: widget.inputType,
//       style: widget.style ??
//           TextFontStyle.textStyle16w400c5C5C5C.copyWith(
//             color: AppColors.c333333,
//           ),
//       decoration: InputDecoration(
//         filled: true,
//         fillColor: widget.fillColor ?? const Color(0xFFFCF6ED),
//         contentPadding: widget.contentPadding ??
//             EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
//         hintText: widget.hintText,
//         hintStyle: widget.hintTextSyle ??
//             TextFontStyle.textStyle16w400c5C5C5C.copyWith(
//               color: AppColors.cC0C0C0,
//               fontWeight: FontWeight.w400,
//             ),
//         prefixIcon: widget.prefixIcon,
//         suffixIcon: widget.isPass == true
//             ? IconButton(
//           onPressed: () {
//             setState(() {
//               _obscureText = !_obscureText;
//             });
//           },
//           icon: Icon(
//             _obscureText ? Icons.visibility_off : Icons.visibility,
//             color: AppColors.cC0C0C0,
//           ),
//         )
//             : widget.suffixIcon,
//         enabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
//           borderSide: BorderSide(
//             color: widget.borderColor ?? Colors.white24,
//             width: 1,
//           ),
//         ),
//         focusedBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
//           borderSide: BorderSide(
//             color: widget.borderColor ??AppColors.buttonColor,
//             width: 1.2,
//           ),
//         ),
//         disabledBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
//           borderSide: BorderSide(
//             color: widget.disableColor ?? Colors.grey.shade300,
//             width: 1,
//           ),
//         ),
//         errorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
//           borderSide: const BorderSide(
//             color: Colors.red,
//             width: 1,
//           ),
//         ),
//         focusedErrorBorder: OutlineInputBorder(
//           borderRadius: BorderRadius.circular(widget.borderRadius ?? 12.r),
//           borderSide: const BorderSide(
//             color: Colors.red,
//             width: 1.2,
//           ),
//         ),
//       ),
//     );
//   }
// }




class CustomTextField extends StatefulWidget {
  final String? hintText;
  final TextEditingController? controller;
  final String? leftIcon;
  final String? rightIcon;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final String? Function(String?)? validator;
  final Color? borderColor;
  final Color? fieldColor;
  final double? textSize;
  final TextAlign? textAlign;
  final double? height;
  final GestureTapCallback? onTap;

  const CustomTextField({
    Key? key,
    this.hintText,
    this.controller,
    this.leftIcon,
    this.rightIcon,
    this.isPassword = false,
    this.obscureText = false,
    this.toggleVisibility,
    this.validator,
    this.borderColor,
    this.fieldColor,
    this.textSize,
    this.textAlign = TextAlign.start,
    this.height = 65.0,
    this.onTap,
  }) : super(key: key);

  @override
  _CustomTextFieldState createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: widget.height?.h ?? 56.h, // Match LoginScreen
          decoration: BoxDecoration(
            color: widget.fieldColor ?? AppColor.cFFFFFF,
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(
              color: widget.borderColor ??
                  (_errorText != null ? Colors.red : const Color(0xffe8e8e8)),
              width: 1.w,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h), // Adjusted padding
          child: Row(
            children: [
              if (widget.leftIcon != null) ...[
                SvgPicture.asset(widget.leftIcon!, height: 20.h, width: 20.w),
                SizedBox(width: 10.w),
              ],
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: widget.isPassword && widget.obscureText,
                  validator: (value) {
                    final error = widget.validator?.call(value);
                    setState(() {
                      _errorText = error;
                    });
                    return null; // Prevent default error display
                  },
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: widget.textSize ?? 14.sp,
                    fontWeight: FontWeight.w400,
                  ),
                  cursorColor: AppColor.blackColor,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  onTap: widget.onTap,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: TextStyle(
                      color: AppColor.c979797, // Match LoginScreen style
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w400,
                    ),
                    border: InputBorder.none,
                    // Removed isCollapsed: true to ensure hintText displays
                    errorText: null, // Suppress default error
                    contentPadding: EdgeInsets.symmetric(vertical: 8.h), // Ensure proper alignment
                  ),
                ),
              ),
              if (widget.rightIcon != null) ...[
                SizedBox(width: 12.w),
                SvgPicture.asset(widget.rightIcon!, height: 20.h, width: 20.w),
              ],
              if (widget.isPassword)
                GestureDetector(
                  onTap: widget.toggleVisibility,
                  child: Icon(
                    widget.obscureText
                        ? Icons.visibility_off
                        : Icons.visibility,
                    color: AppColor.c979797,
                  ),
                ),
            ],
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 4.h, left: 8.w),
            child: Text(
              _errorText!,
              style: TextStyle(color: Colors.red, fontSize: 12.sp),
            ),
          ),
      ],
    );
  }
}
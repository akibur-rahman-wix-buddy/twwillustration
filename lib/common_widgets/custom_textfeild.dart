import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import '../assets_helper/app_colors.dart';
import '../assets_helper/app_fonts.dart';

class CustomTextField extends StatefulWidget {
  final String? title;
  final String? hintText;
  final TextEditingController controller;
  final String? leftIcon;
  final String? rightIcon;
  final int? maxline;
  final bool isPassword;
  final bool obscureText;
  final VoidCallback? toggleVisibility;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final Color? borderColor;
  final Color? fieldColor;
  final double? textSize;
  final TextAlign? textAlign;
  final double? height;
  final double? width;
  final GestureTapCallback? onTap;
  final bool? readOnly;
  final TextStyle? hintTextSyle;
  final ValueChanged<String>? onChanged;

  const CustomTextField({
    super.key,
    this.title,
    this.hintText,
    required this.controller,
    this.leftIcon,
    this.rightIcon,
    this.maxline,
    this.isPassword = false,
    this.obscureText = false,
    this.toggleVisibility,
    this.validator,
    this.borderColor,
    this.fieldColor,
    this.textSize,
    this.textAlign = TextAlign.start,
    this.height = 65.0,
    this.width,
    this.onTap, 
    this.readOnly, 
    this.hintTextSyle, 
    this.inputFormatters, 
    this.onChanged,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.title != null && widget.title!.isNotEmpty) ...[
            Text(widget.title!, style: TextFontStyle.textStyle14w400c333333.copyWith(color: Color(0xFF000000))
            ),
            const SizedBox(height: 8),
          ],
        Container(
          height: widget.height?.h ?? 56.h,
          width: widget.width?.w,
          decoration: BoxDecoration(
            color: widget.fieldColor ?? AppColor.cFFFFFF,
            borderRadius: BorderRadius.circular(28.r),
            border: Border.all(
              color: _errorText != null
                  ? Colors.red
                  : (widget.borderColor ?? const Color(0xffe8e8e8)),
              width: 1.w,
            ),
          ),
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Row(
            children: [
              if (widget.leftIcon != null) ...[
                SvgPicture.asset(widget.leftIcon!, height: 35.h, width: 35.w),
                SizedBox(width: 10.w),
              ],
              Expanded(
                child: TextFormField(
                  controller: widget.controller,
                  obscureText: widget.isPassword && widget.obscureText,
                  maxLines: widget.maxline ?? 1,
                  
                  /// ✅ VALIDATOR FIXED
                  validator: widget.validator,
                  inputFormatters: widget.inputFormatters,
                  readOnly: widget.readOnly ?? false,
                  onChanged: widget.onChanged,

                  style: TextFontStyle.textStyle12w400NunitoSans.copyWith(
                    color: Colors.black,
                    fontSize: widget.textSize ?? 14.sp,
                  ),
                  cursorColor: AppColor.blackColor,
                  textAlign: widget.textAlign ?? TextAlign.start,
                  onTap: widget.onTap,
                  decoration: InputDecoration(
                    hintText: widget.hintText,
                    hintStyle: widget.hintTextSyle ??
                        TextFontStyle.textStyle12w400NunitoSans.copyWith(
                      color: Color(0xFF757575),
                      fontSize: 14.sp,
                    ),
                    border: InputBorder.none,

                    /// ✅ hide default error
                    errorStyle: const TextStyle(height: 0),
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 14.h),
                  ),
                ),
              ),
              if (widget.rightIcon != null) ...[
                SizedBox(width: 12.w),
                SvgPicture.asset(widget.rightIcon!,
                    height: 20.h, width: 20.w),
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
      ],
    );
  }
}

// class CustomTextField extends StatefulWidget {
//   final String? hintText;
//   final String? labelText;
//   final TextEditingController? controller;
//   final TextInputType? inputType;
//   final int? maxline;
//   final int? minLine;
//   final int? maxLength;
//   final String? Function(String?)? validator;

//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final bool prefixIconTopLeft;

//   final bool isObsecure;
//   final bool isPass;
//   final FocusNode? focusNode;
//   final TextInputAction? textInputAction;
//   final Function(String)? onFieldSubmitted;
//   final Function(String)? onChanged;
//   final List<TextInputFormatter>? inputFormatters;

//   final TextStyle? labelStyle;
//   final TextStyle? style;
//   final TextStyle? hintTextSyle;

//   final bool? isEnabled;
//   final bool isRead;
//   final bool autoFocus;

//   final double? borderRadius;
//   final Color? fillColor;
//   final Color? borderColor;
//   final Color? cursorColor;

//   final TextAlign textAlign;
//   final VoidCallback? ontap;
//   final String? title;
//   final EdgeInsetsGeometry? margin;

//   const CustomTextField({
//     super.key,
//     this.hintText,
//     this.labelText,
//     this.controller,
//     this.inputType,
//     this.maxline = 1,
//     this.minLine,
//     this.validator,
//     this.suffixIcon,
//     this.prefixIcon,
//     this.prefixIconTopLeft = false,
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
//     this.isRead = false,
//     this.borderRadius,
//     this.fillColor,
//     this.hintTextSyle,
//     this.borderColor,
//     this.textAlign = TextAlign.left,
//     this.ontap,
//     this.title,
//     this.margin,
//     this.autoFocus = false,
//     this.maxLength,
//     this.cursorColor,
//   });

//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }

// class _CustomTextFieldState extends State<CustomTextField> {
//   late bool _obscureText;

//   @override
//   void initState() {
//     _obscureText = widget.isObsecure;
//     super.initState();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: widget.margin,
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           if (widget.title != null && widget.title!.isNotEmpty) ...[
//             Text(widget.title!, style: TextFontStyle.textStyle14w600c000000),
//             const SizedBox(height: 8),
//           ],
//           if (widget.prefixIconTopLeft && widget.prefixIcon != null)
//             Container(
//               height: 180.h,
//               padding: const EdgeInsets.all(12),
//               decoration: BoxDecoration(
//                 color: widget.fillColor ?? const Color(0xFFFCF6ED),
//                 borderRadius: BorderRadius.circular(widget.borderRadius ?? 20),
//                 border: Border.all(
//                   color: widget.borderColor ?? Colors.white24,
//                 ),
//               ),
//               child: Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Padding(
//                     padding: const EdgeInsets.only(top: 6),
//                     child: widget.prefixIcon!,
//                   ),
//                   const SizedBox(width: 10),
//                   Expanded(
//                     child: TextFormField(
//                       minLines: widget.minLine,
//                       maxLines: widget.maxline,
//                       controller: widget.controller,
//                       autofocus: widget.autoFocus,
//                       maxLength: widget.maxLength,
//                       readOnly: widget.isRead,
//                       validator: widget.validator,
//                       onChanged: widget.onChanged,
//                       onFieldSubmitted: widget.onFieldSubmitted,
//                       inputFormatters: widget.inputFormatters,
//                       keyboardType: widget.inputType,
//                       focusNode: widget.focusNode,
//                       enabled: widget.isEnabled ?? true,
//                       textAlign: widget.textAlign,
//                       onTap: widget.ontap,
//                       style: widget.style,
//                       decoration: InputDecoration(
//                         border: InputBorder.none,
//                         hintText: widget.hintText,
//                         hintStyle: widget.hintTextSyle,
//                         counterText: "",
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             )
//           else
//             SizedBox(
//               height: 56.h,
//               child: TextFormField(
//                 minLines: widget.minLine,
//                 autofocus: widget.autoFocus,
//                 maxLength: widget.maxLength,
//                 textAlign: widget.textAlign,
//                 readOnly: widget.isRead,
//                 focusNode: widget.focusNode,
//                 obscureText: _obscureText,
//                 onTap: widget.ontap,
//                 cursorColor: widget.cursorColor ?? Colors.black,
//                 textInputAction: widget.textInputAction,
//                 validator: widget.validator,
//                 maxLines: widget.maxline == 1 ? 1 : widget.maxline,
//                 controller: widget.controller,
//                 onFieldSubmitted: widget.onFieldSubmitted,
//                 onChanged: widget.onChanged,
//                 inputFormatters: widget.inputFormatters,
//                 enabled: widget.isEnabled ?? true,
//                 obscuringCharacter: "*",
//                 keyboardType: widget.inputType,
//                 style: widget.style ??
//                     TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                       color: Colors.black,
//                       fontSize: 14.sp,
//                     ),
//                 decoration: InputDecoration(
//                   isDense: true,
//                   filled: true,
//                   fillColor: widget.fillColor ?? const Color(0xFFFFFFFF),
//                   contentPadding:
//                       const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//                   hintText: widget.hintText,
//                   hintStyle: widget.hintTextSyle ??
//                       TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                         color: AppColor.c979797,
//                         fontSize: 14.sp,
//                       ),
//                   labelText: widget.labelText,
//                   labelStyle: widget.labelStyle ??
//                       TextFontStyle.textStyle12w400NunitoSans.copyWith(
//                         color: AppColor.c979797,
//                         fontSize: 14.sp,
//                       ),
              
//                   // OLD PREFIX ICON BEHAVIOR
              
//                   prefixIcon: widget.prefixIcon != null
//                       ? Padding(
//                           padding: const EdgeInsets.all(12),
//                           child: widget.prefixIcon,
//                         )
//                       : null,
              
//                   // PASSWORD
//                   suffixIcon: widget.isPass
//                       ? IconButton(
//                           onPressed: () {
//                             setState(() {
//                               _obscureText = !_obscureText;
//                             });
//                           },
//                           icon: Icon(
//                             _obscureText
//                                 ? Icons.visibility_off
//                                 : Icons.visibility,
//                             color: AppColor.cC0C0C0,
//                             size: 20,
//                           ),
//                         )
//                       : widget.suffixIcon,
              
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(widget.borderRadius ?? 12),
//                     borderSide: BorderSide(
//                       color: widget.borderColor ?? Colors.white24,
//                       width: 1,
//                     ),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(widget.borderRadius ?? 12),
//                     borderSide: BorderSide(
//                       color: widget.borderColor ?? AppColor.buttonColor,
//                       width: 1.2,
//                     ),
//                   ),
//                   errorBorder: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(widget.borderRadius ?? 12),
//                     borderSide: const BorderSide(color: Colors.red),
//                   ),
//                   focusedErrorBorder: OutlineInputBorder(
//                     borderRadius:
//                         BorderRadius.circular(widget.borderRadius ?? 12),
//                     borderSide: const BorderSide(color: Colors.red),
//                   ),
//                   counterText: "",
//                 ),
//               ),
//             ),
//         ],
//       ),
//     );
//   }
// }

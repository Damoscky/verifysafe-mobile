import 'package:verifysafe/core/constants/app_theme/custom_color_scheme.dart';
import 'package:verifysafe/core/utilities/extensions/color_extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../core/constants/color_path.dart';


class CustomTextField extends StatefulWidget {
  final String label;
  final double? height;
  final double? labelSize;
  final FontWeight labelFontWeight;
  final Color? labelColor;
  final TextEditingController? controller;
  final ValueChanged<String>? onChanged;
  final String? Function(String?)? validator;
  final List<TextInputFormatter>? inputFormatters;
  final TextInputType? keyboardType;
  final double? textSize;
  final Color textColor;
  final Color? fillColor;
  final bool obscure;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final String hintText;
  final String bottomHintText;
  final double? hintSize;
  final Color? hintColor;
  final Color? bottomHintColor;
  final bool enabled;
  final bool readOnly;
  final bool isCompulsory;
  final FocusNode? focusPointer;
  final int maxLines;
  final bool isOtp;
  final bool showLabel;
  final Color? borderColor;
  final double? borderWidth;
  final bool useDefaultHeight;

  const CustomTextField({
    super.key,
    this.height,
    this.showLabel = true,
    this.label = '',
    this.labelSize,
    this.labelFontWeight = FontWeight.w500,
    this.labelColor,
    this.controller,
    this.onChanged,
    this.validator,
    this.inputFormatters,
    this.keyboardType = TextInputType.text,
    this.textSize,
    this.textColor = Colors.black,
    this.fillColor,
    this.obscure = false,
    this.suffixIcon,
    this.hintText = '',
    this.hintSize,
    this.hintColor,
    this.bottomHintColor,
    this.enabled = true,
    this.readOnly = false,
    this.prefixIcon,
    this.bottomHintText = '',
    this.isCompulsory = false,
    this.focusPointer,
    this.maxLines = 1,
    this.isOtp = false,
    this.borderColor,
    this.borderWidth,
    this.useDefaultHeight = true
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  String? _errorText;
  bool _isFocused = false;
  late FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _focusNode = widget.focusPointer ?? FocusNode();
    _focusNode.addListener(() {
      setState(() {
        _isFocused = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    if (widget.focusPointer == null) {
      _focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.showLabel)
          Row(
            children: [
              Text(
                widget.label,
                style: textTheme.bodyMedium?.copyWith(
                  color: widget.labelColor ?? colorScheme.textFieldLabel,
                  fontWeight: widget.labelFontWeight,
                ),
              ),
              if (widget.isCompulsory) SizedBox(width: 5.w),
              if (widget.isCompulsory)
                Text(
                  '*',
                  style: textTheme.bodyMedium?.copyWith(
                    color: ColorPath.redOrange,
                    fontSize: widget.labelSize,
                    fontWeight: FontWeight.w500,
                  ),
                ),
            ],
          ),
        if (widget.showLabel) SizedBox(height: 8.h),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: widget.useDefaultHeight ? widget.height?.h ?? 56.h : null,
          width: double.infinity,
          decoration: BoxDecoration(
            color: colorScheme.textFieldFillColor,
            borderRadius: BorderRadius.all(Radius.circular(8.r)),
            border: Border.all(
              color: _errorText != null ? ColorPath.redOrange
              : _isFocused ? colorScheme.textFieldFocusedBorder
                : colorScheme.textFieldBorder,
              width: 1.w
            ),
            boxShadow: _isFocused
                ? [
              BoxShadow(
                color: _errorText != null ? ColorPath.redOrange.withCustomOpacity(0.4)
                    : _isFocused ? colorScheme.textFieldFocusedBorder.withCustomOpacity(0.4)
                    : colorScheme.textFieldBorder.withCustomOpacity(0.4),
                blurRadius: 8,
                offset: const Offset(0, 1),
              ),
            ]
                : [],
          ),
          child: Center(
            child: TextFormField(
              focusNode: _focusNode,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              enabled: widget.enabled,
              readOnly: widget.readOnly,
              validator: (value) {
                if (widget.validator != null) {
                  final error = widget.validator!(value);

                  SchedulerBinding.instance.addPostFrameCallback((_) {
                    if (mounted) {
                      setState(() {
                        _errorText = error;
                      });
                    }
                  });

                  return error == null ? null : '';
                }
                return null;
              },
              controller: widget.controller,
              obscureText: widget.obscure,
              autocorrect: false,
              textAlign: widget.isOtp ? TextAlign.center : TextAlign.start,
              style: widget.isOtp
                  ? Theme.of(context).textTheme.titleLarge?.copyWith(
                fontSize: widget.textSize?.sp,
                fontWeight: FontWeight.w600,
                color: Theme.of(
                  context,
                ).colorScheme.blackText.withCustomOpacity(0.85),
                letterSpacing: 24,
              )
                  : Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontSize: widget.textSize?.sp,
                fontWeight: FontWeight.w400,
                color: Theme.of(
                  context,
                ).colorScheme.blackText.withCustomOpacity(0.85),
              ),
              onChanged: widget.onChanged,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatters,
              maxLines: widget.maxLines,
              decoration: InputDecoration(
                filled: widget.fillColor != null,
                fillColor: widget.fillColor,
                errorText: null,
                errorMaxLines: 1,
                errorStyle: const TextStyle(height: 0, fontSize: 0),
                hintText: widget.hintText,
                hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w400,
                  color: Theme.of(context).colorScheme.textFieldHint,
                ),
                suffixIcon: widget.suffixIcon,
                suffixIconConstraints: BoxConstraints(
                  minWidth: 16.w,
                  minHeight: 16.h,
                ),
                prefixIcon: widget.prefixIcon,
                prefixIconConstraints: BoxConstraints(
                  minWidth: 16.w,
                  minHeight: 16.h,
                ),
                floatingLabelBehavior: FloatingLabelBehavior.auto,
                contentPadding: EdgeInsets.only(
                  left: 14.w,
                  right: 14.w,
                  top: 10.h,
                  bottom: 10.h,
                ),

                border: InputBorder.none,
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                focusedErrorBorder: InputBorder.none,


                // enabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8.r),
                //   borderSide: BorderSide(
                //     color: _errorText != null
                //         ? ColorPath.redOrange
                //         : widget.borderColor ?? colorScheme.textFieldBorder,
                //     width: 1.w,
                //   ),
                // ),
                // focusedBorder: OutlineInputBorder(
                //   borderSide: BorderSide(
                //     color: _errorText != null
                //         ? ColorPath.redOrange
                //         : colorScheme.textFieldFocusedBorder,
                //     width: 1.w,
                //   ),
                //   borderRadius: BorderRadius.circular(8.r),
                // ),
                // focusedErrorBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8.r),
                //   borderSide: BorderSide(
                //     color: _errorText != null
                //         ? ColorPath.redOrange
                //         : widget.borderColor ?? colorScheme.textFieldBorder,
                //     width: widget.borderWidth ?? 1.w,
                //   ),
                // ),
                // disabledBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8.r),
                //   borderSide: BorderSide(
                //     color: widget.borderColor ?? colorScheme.textFieldBorder,
                //     width: widget.borderWidth ?? 1.w,
                //   ),
                // ),
                // errorBorder: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8.r),
                //   borderSide: BorderSide(
                //     color: _errorText != null
                //         ? ColorPath.redOrange
                //         : widget.borderColor ?? colorScheme.textFieldBorder,
                //     width: widget.borderWidth ?? 1.w,
                //   ),
                // ),
                // border: OutlineInputBorder(
                //   borderRadius: BorderRadius.circular(8.r),
                //   borderSide: BorderSide(
                //     color: _errorText != null
                //         ? ColorPath.redOrange
                //         : widget.borderColor ?? colorScheme.textFieldBorder,
                //     width: widget.borderWidth ?? 1.w,
                //   ),
                // ),
              ),
            ),
          ),
        ),
        if (_errorText != null)
          Padding(
            padding: EdgeInsets.only(top: 5.h),
            child: Text(
              _errorText!,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                color: ColorPath.redOrange,
              ),
            ),
          ),
        if (widget.bottomHintText.isNotEmpty)
          Padding(
            padding: EdgeInsets.only(top: 6.h),
            child: Text(
              widget.bottomHintText,
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w400,
                color: widget.bottomHintColor ??
                    Theme.of(context).colorScheme.textFieldHint,
              ),
            ),
          ),
      ],
    );
  }
}


// class CustomTextField extends StatefulWidget {
//   final String label;
//   final double? height;
//   final double? labelSize;
//   final FontWeight labelFontWeight;
//   final Color? labelColor;
//   final TextEditingController? controller;
//   final ValueChanged<String>? onChanged;
//   final String? Function(String?)? validator;
//   final List<TextInputFormatter>? inputFormatters;
//   final TextInputType? keyboardType;
//   final double? textSize;
//   final Color textColor;
//   final Color? fillColor;
//   final bool obscure;
//   final Widget? suffixIcon;
//   final Widget? prefixIcon;
//   final String hintText;
//   final String bottomHintText;
//   final double? hintSize;
//   final Color? hintColor;
//   final Color? bottomHintColor;
//   final bool enabled;
//   final bool readOnly;
//   final bool isCompulsory;
//   final FocusNode? focusPointer;
//   final int maxLines;
//   final bool isOtp;
//   final bool showLabel;
//   final Color? borderColor;
//   final double? borderWidth;
//
//   const CustomTextField({
//     super.key,
//     this.height,
//     this.showLabel = true,
//     this.label = '',
//     this.labelSize,
//     this.labelFontWeight = FontWeight.w400,
//     this.labelColor,
//     this.controller,
//     this.onChanged,
//     this.validator,
//     this.inputFormatters,
//     this.keyboardType = TextInputType.text,
//     this.textSize,
//     this.textColor = Colors.black,
//     this.fillColor,
//     this.obscure = false,
//     this.suffixIcon,
//     this.hintText = '',
//     this.hintSize,
//     this.hintColor,
//     this.bottomHintColor,
//     this.enabled = true,
//     this.readOnly = false,
//     this.prefixIcon,
//     this.bottomHintText = '',
//     this.isCompulsory = false,
//     this.focusPointer,
//     this.maxLines = 1,
//     this.isOtp = false,
//     this.borderColor,
//     this.borderWidth,
//   });
//
//   @override
//   State<CustomTextField> createState() => _CustomTextFieldState();
// }
//
// class _CustomTextFieldState extends State<CustomTextField> {
//   String? _errorText;
//
//   @override
//   Widget build(BuildContext context) {
//     final colorScheme = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (widget.showLabel)
//           Row(
//             children: [
//               Text(
//                 widget.label,
//                 style: textTheme.bodyMedium?.copyWith(
//                   color: widget.labelColor ?? colorScheme.textFieldLabel,
//                   fontWeight: widget.labelFontWeight,
//                 ),
//               ),
//               if (widget.isCompulsory) SizedBox(width: 5.w),
//               if (widget.isCompulsory)
//                 Text(
//                   '*',
//                   style: textTheme.bodyMedium?.copyWith(
//                     color: ColorPath.redOrange,
//                     fontSize: widget.labelSize,
//                     fontWeight: FontWeight.w500,
//                   ),
//                 ),
//             ],
//           ),
//         if (widget.showLabel) SizedBox(height: 6.h),
//         Container(
//           height: widget.height,
//           width: double.infinity,
//           decoration: BoxDecoration(
//             color: colorScheme.textFieldFillColor,
//             borderRadius: BorderRadius.all(Radius.circular(8.r)),
//           ),
//           child: TextFormField(
//             autovalidateMode: AutovalidateMode.onUserInteraction,
//             enabled: widget.enabled,
//             readOnly: widget.readOnly,
//             validator: (value) {
//               // if(widget.validator != null){
//               //   final error = widget.validator!(value);
//               //   SchedulerBinding.instance.addPostFrameCallback((_) {
//               //     setState(() {
//               //       _errorText = error;
//               //     });
//               //   });
//               // }
//               // return null;
//
//               if (widget.validator != null) {
//                 final error = widget.validator!(value);
//
//                 SchedulerBinding.instance.addPostFrameCallback((_) {
//                   if (mounted) {
//                     setState(() {
//                       _errorText = error;
//                     });
//                   }
//                 });
//
//                 return error == null ? null : '';
//               }
//               return null;
//             },
//             controller: widget.controller,
//             obscureText: widget.obscure,
//             autocorrect: false,
//             textAlign: widget.isOtp ? TextAlign.center : TextAlign.start,
//             style: widget.isOtp
//                 ? Theme.of(context).textTheme.titleLarge?.copyWith(
//               fontSize: widget.textSize?.sp,
//               fontWeight: FontWeight.w600,
//               color: Theme.of(
//                 context,
//               ).colorScheme.blackText.withCustomOpacity(0.85),
//               letterSpacing: 24,
//             )
//                 : Theme.of(context).textTheme.bodyLarge?.copyWith(
//               fontSize: widget.textSize?.sp,
//               fontWeight: FontWeight.w400,
//               color: Theme.of(
//                 context,
//               ).colorScheme.blackText.withCustomOpacity(0.85),
//             ),
//             onChanged: widget.onChanged,
//             keyboardType: widget.keyboardType,
//             inputFormatters: widget.inputFormatters,
//             maxLines: widget.maxLines,
//             decoration: InputDecoration(
//               filled: widget.fillColor != null,
//               fillColor: widget.fillColor,
//               errorText: null,
//               errorMaxLines: 1,
//               errorStyle: const TextStyle(height: 0, fontSize: 0),
//               hintText: widget.hintText,
//               hintStyle: Theme.of(context).textTheme.bodyLarge?.copyWith(
//                 fontWeight: FontWeight.w400,
//                 color: Theme.of(context).colorScheme.textFieldHint,
//               ),
//               suffixIcon: widget.suffixIcon,
//               suffixIconConstraints: BoxConstraints(
//                 minWidth: 16.w,
//                 minHeight: 16.h,
//               ),
//               prefixIcon: widget.prefixIcon,
//               prefixIconConstraints: BoxConstraints(
//                 minWidth: 16.w,
//                 minHeight: 16.h,
//               ),
//               floatingLabelBehavior: FloatingLabelBehavior.auto,
//               contentPadding: EdgeInsets.only(
//                 left: 14.w,
//                 right: 14.w,
//                 top: 10.h,
//                 bottom: 10.h,
//               ),
//               enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.r),
//                 borderSide: BorderSide(
//                   color: _errorText != null
//                       ? ColorPath.redOrange
//                       : widget.borderColor ?? colorScheme.textFieldBorder,
//                   width: 1.w,
//                 ),
//               ),
//               focusedBorder: OutlineInputBorder(
//                 borderSide: BorderSide(
//                   color: _errorText != null
//                       ? ColorPath.redOrange
//                       : colorScheme.textFieldFocusedBorder,
//                   width: 1.w,
//                 ),
//                 borderRadius: BorderRadius.circular(8.r),
//               ),
//               focusedErrorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.r),
//                 borderSide: BorderSide(
//                   color: _errorText != null
//                       ? ColorPath.redOrange
//                       : widget.borderColor ?? colorScheme.textFieldBorder,
//                   width: widget.borderWidth ?? 1.w,
//                 ),
//               ),
//               disabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.r),
//                 borderSide: BorderSide(
//                   color: widget.borderColor ?? colorScheme.textFieldBorder,
//                   width: widget.borderWidth ?? 1.w,
//                 ),
//               ),
//               errorBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.r),
//                 borderSide: BorderSide(
//                   color: _errorText != null
//                       ? ColorPath.redOrange
//                       : widget.borderColor ?? colorScheme.textFieldBorder,
//                   width: widget.borderWidth ?? 1.w,
//                 ),
//               ),
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(8.r),
//                 borderSide: BorderSide(
//                   color: _errorText != null
//                       ? ColorPath.redOrange
//                       : widget.borderColor ?? colorScheme.textFieldBorder,
//                   width: widget.borderWidth ?? 1.w,
//                 ),
//               ),
//             ),
//           ),
//         ),
//         if (widget.bottomHintText.isNotEmpty)
//           Padding(
//             padding: EdgeInsets.only(top: 6.h),
//             child: Text(
//               widget.bottomHintText,
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color:
//                 widget.bottomHintColor ??
//                     Theme.of(context).colorScheme.textFieldHint,
//               ),
//             ),
//           ),
//         if (_errorText != null)
//           Padding(
//             padding: EdgeInsets.only(top: 2.h),
//             child: Text(
//               _errorText!,
//               style: Theme.of(context).textTheme.bodyMedium?.copyWith(
//                 fontWeight: FontWeight.w500,
//                 color: ColorPath.redOrange,
//               ),
//             ),
//           ),
//       ],
//     );
//   }
// }

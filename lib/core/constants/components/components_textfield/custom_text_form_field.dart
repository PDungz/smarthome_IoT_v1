import 'package:flutter/material.dart';
import '../../colors/app_colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String hintText;
  final String? labelText;
  final IconData? prefixIcon;
  final Color? iconColor;
  final EdgeInsetsGeometry? contentPadding;
  final TextEditingController controller; // Bắt buộc phải có controller
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Function(String?)? onSaved;
  final String? Function(String?)? validator;
  final Color? fillColor;
  final TextStyle? textStyle;
  final int? maxLines;
  final bool? enabled;
  final bool hasBorder;
  final InputBorder? customBorder;
  final Color? outlineColor;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;

  const CustomTextFormField({
    super.key,
    required this.hintText,
    this.labelText,
    this.prefixIcon,
    this.iconColor,
    // Chỉnh sửa contentPadding
    this.contentPadding,
    required this.controller, // Bắt buộc phải có controller
    this.keyboardType,
    this.onChanged,
    this.onSaved,
    this.validator,
    this.fillColor,
    this.textStyle,
    this.maxLines = 1,
    this.enabled = true,
    this.hasBorder = true,
    this.customBorder,
    this.outlineColor = Colors.grey,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller, // Sử dụng controller được truyền vào
      keyboardType: keyboardType,
      onChanged: onChanged,
      onSaved: onSaved,
      validator: validator,
      maxLines: maxLines,
      enabled: enabled,
      style: textStyle,
      decoration: InputDecoration(
        labelText: labelText,
        hintStyle: const TextStyle(
          color: Color.fromARGB(255, 211, 211, 211),
        ),
        hintText: hintText,
        prefixIcon: prefixIcon != null
            ? Icon(prefixIcon, color: iconColor ?? AppColors.iconPrimaryColor)
            : null,
        // Cập nhật contentPadding ở đây
        contentPadding: contentPadding ??
            const EdgeInsets.all(16.0), // Thay đổi giá trị cho padding all
        filled: fillColor != null,
        fillColor: fillColor ?? AppColors.backgroundColor,
        border: hasBorder
            ? (customBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ))
            : InputBorder.none,
        enabledBorder: hasBorder
            ? (enabledBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide(color: outlineColor!),
                ))
            : InputBorder.none,
        focusedBorder: hasBorder
            ? (focusedBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide:
                      const BorderSide(color: AppColors.primaryColor, width: 2),
                ))
            : InputBorder.none,
        errorBorder: hasBorder
            ? (errorBorder ??
                OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: const BorderSide(color: Colors.red, width: 2),
                ))
            : InputBorder.none,
      ),
    );
  }
}

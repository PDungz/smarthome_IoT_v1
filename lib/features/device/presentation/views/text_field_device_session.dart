import 'package:flutter/material.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/components/components_textfield/custom_text_form_field.dart';

class TextFieldDeviceSession extends StatelessWidget {
  final String fieldName;
  final TextEditingController textEditingController;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldValidator<String>? validator;
  final int? maxLines;

  const TextFieldDeviceSession({
    super.key,
    required this.fieldName,
    required this.textEditingController,
    this.contentPadding,
    this.validator,
    this.maxLines = 1, // Initialize validator
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$fieldName:",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondarColor),
          ),
          const SizedBox(height: 4),
          CustomTextFormField(
            hintText: fieldName,
            controller: textEditingController,
            validator: validator, // Use the validator passed from parent
            contentPadding: contentPadding,
            maxLines: maxLines,
            hasBorder: true,
            fillColor: AppColors.primaryColor,
            customBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide.none,
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
              borderSide: BorderSide.none,
            ),
          ),
        ],
      ),
    );
  }
}

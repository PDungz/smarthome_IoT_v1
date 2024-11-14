import 'package:flutter/material.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/components/components_textfield/custom_text_form_field.dart';

class TextFieldSession extends StatefulWidget {
  final String fieldName;
  final String? currentValue;
  final EdgeInsetsGeometry? contentPadding;
  final FormFieldValidator<String>? validator;
  final void Function(String)? onChanged;

  const TextFieldSession({
    super.key,
    required this.fieldName,
    required this.currentValue,
    this.contentPadding,
    this.validator,
    this.onChanged,
  });

  @override
  State<TextFieldSession> createState() => _TextFieldSessionState();
}

class _TextFieldSessionState extends State<TextFieldSession> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.currentValue);
  }

  @override
  void didUpdateWidget(covariant TextFieldSession oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.currentValue != oldWidget.currentValue) {
      _controller.text = widget.currentValue ?? '';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.fieldName,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondarColor),
          ),
          const SizedBox(height: 4),
          CustomTextFormField(
            hintText: widget.fieldName,
            controller: _controller,
            onChanged: widget.onChanged,
            validator: widget.validator,
            contentPadding: widget.contentPadding,
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

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

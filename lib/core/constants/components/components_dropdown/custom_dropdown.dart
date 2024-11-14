import 'package:flutter/material.dart';

import '../../colors/app_colors.dart';

class CustomDropdown<T> extends StatelessWidget {
  final T? selectedItem;
  final List<T> items;
  final String hintText;
  final void Function(T?) onChanged;
  final String Function(T) itemLabelBuilder;

  const CustomDropdown({
    super.key,
    required this.selectedItem,
    required this.items,
    required this.onChanged,
    required this.itemLabelBuilder,
    this.hintText = 'Select an item',
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 2),
      decoration: BoxDecoration(
        color: AppColors.primaryColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<T>(
          value: selectedItem,
          hint: Text(
            hintText,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondarColor),
          ),
          isExpanded: true,
          icon: const Icon(
            Icons.arrow_drop_down,
            color: AppColors.iconSecondarColor,
          ),
          onChanged: onChanged,
          items: items.map((T item) {
            return DropdownMenuItem<T>(
              value: item,
              child: Text(
                itemLabelBuilder(item),
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: const Color.fromARGB(255, 211, 211, 211)),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

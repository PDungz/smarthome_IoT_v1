import 'package:flutter/material.dart';
import '../../../../core/constants/colors/app_colors.dart';
import '../../../../core/constants/components/components_dropdown/custom_dropdown.dart';

class DropdownDeviceSession<T> extends StatelessWidget {
  final String title;
  final String? selectedId;
  final String hintText;
  final List<T> items;
  final ValueChanged<String?> onChanged;
  final String Function(T) getId;
  final String Function(T) getName;

  const DropdownDeviceSession({
    super.key,
    required this.selectedId,
    required this.items,
    required this.onChanged,
    required this.getId,
    required this.getName,
    required this.hintText,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Text(
            title,
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.textSecondarColor),
          ),
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
          child: CustomDropdown<String>(
            selectedItem: selectedId,
            items: items.map(getId).toList(),
            hintText: hintText,
            onChanged: onChanged,
            itemLabelBuilder: (id) {
              final item = items.cast<T?>().firstWhere(
                    (item) => getId(item as T) == id,
                    orElse: () => null,
                  );
              return item != null ? getName(item) : '';
            },
          ),
        ),
      ],
    );
  }
}

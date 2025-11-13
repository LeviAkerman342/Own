import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final String? value;
  final ValueChanged<String?> onChanged;

  const CategoryDropdown({super.key, this.value, required this.onChanged});

  @override
  Widget build(BuildContext context) {
    const categories = [
      'Еда',
      'Транспорт',
      'Развлечения',
      'Покупки',
      'Здоровье',
      'Прочее',
    ];

    return DropdownButtonFormField<String>(
      value: value,
      decoration: const InputDecoration(labelText: 'Категория'),
      items: categories
          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
          .toList(),
      onChanged: onChanged,
    );
  }
}

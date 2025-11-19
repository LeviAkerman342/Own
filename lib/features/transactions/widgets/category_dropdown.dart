import 'package:flutter/material.dart';

class CategoryDropdown extends StatelessWidget {
  final String value;
  final ValueChanged<String> onChanged;
  final List<String> categories;

  const CategoryDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.categories = const [
      'Еда',
      'Транспорт',
      'Покупки',
      'Подписки',
      'Прочее',
    ],
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      initialValue: value,
      decoration: const InputDecoration(labelText: 'Категория'),
      items: categories
          .map((c) => DropdownMenuItem(value: c, child: Text(c)))
          .toList(),
      onChanged: (val) {
        if (val != null) onChanged(val);
      },
    );
  }
}

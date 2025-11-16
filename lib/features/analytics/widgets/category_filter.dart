import 'package:flutter/material.dart';

class CategoryFilter extends StatefulWidget {
  final List<String> categories;
  final ValueChanged<String> onSelect;

  const CategoryFilter({
    super.key,
    required this.categories,
    required this.onSelect,
  });

  @override
  State<CategoryFilter> createState() => _CategoryFilterState();
}

class _CategoryFilterState extends State<CategoryFilter> {
  String selected = "Все";

  @override
  Widget build(BuildContext context) {
    return Row(
      children: widget.categories
          .map(
            (c) => Padding(
              padding: const EdgeInsets.only(right: 8),
              child: GestureDetector(
                onTap: () {
                  setState(() => selected = c);
                  widget.onSelect(c);
                },
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 250),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  decoration: BoxDecoration(
                    color: selected == c ? Colors.black : Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    c,
                    style: TextStyle(
                      color: selected == c ? Colors.white : Colors.black87,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
          )
          .toList(),
    );
  }
}

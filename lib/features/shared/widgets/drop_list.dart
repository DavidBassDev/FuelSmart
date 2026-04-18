import 'package:flutter/material.dart';

class DropList<T> extends StatelessWidget {
  final String label;
  final String hint;
  final List<T> items;
  final T? value;
  final String Function(T) itemLabel;
  final void Function(T?) onChanged;

  const DropList({
    super.key,
    required this.label,
    required this.hint,
    required this.items,
    required this.value,
    required this.itemLabel,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        const SizedBox(height: 10),

        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12),
          decoration: BoxDecoration(border: Border.all(color: Colors.black)),
          child: DropdownButton<T>(
            value: value,
            hint: Text(hint),
            isExpanded: true,
            underline: const SizedBox(),

            items: items.map((item) {
              return DropdownMenuItem<T>(
                value: item,
                child: Text(itemLabel(item)),
              );
            }).toList(),

            onChanged: onChanged,
          ),
        ),

        const SizedBox(height: 10),
        const Divider(color: Colors.white),
      ],
    );
  }
}

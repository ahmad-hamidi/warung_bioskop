import 'package:flutter/material.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/widgets/selectable_card.dart';

List<Widget> options<T>({
  required String title,
  required List<T> options,
  required T? selectedItem,
  String Function(T object)? converter,
  bool Function(T object)? isOptionEnable,
  required void Function(T object) onTap,
}) =>
    [
      Padding(
        padding: const EdgeInsets.only(left: 24, right: 24),
        child: Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      verticalSpace(16),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: options
              .map(
                (e) => Padding(
                  padding: EdgeInsets.only(
                    left: e == options.firstOrNull ? 24 : 8,
                    right: e == options.lastOrNull ? 24 : 8,
                  ),
                  child: SelectableCard(
                    text: converter != null ? converter(e) : e.toString(),
                    isSelected: e == selectedItem,
                    isEnable: isOptionEnable?.call(e) ?? true,
                    onTap: () => onTap(e),
                  ),
                ),
              )
              .toList(),
        ),
      )
    ];

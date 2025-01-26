import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:warung_bioskop/presentation/widgets/bottom_nav_bar_item.dart';

class BottomNavBar extends StatelessWidget {
  final List<BottomNavBarItem> items;
  final int selectedIndex;
  final void Function(int index) onTap;

  const BottomNavBar(
      {super.key,
      required this.items,
      required this.selectedIndex,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        width: double.infinity,
        height: 70,
        padding: const EdgeInsets.only(top: 16),
        decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(color: Colors.blue),
          ],
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color.fromARGB(
            200,
            12,
            12,
            12,
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: items
              .map(
                (e) => GestureDetector(
                  child: e,
                  onTap: () {
                    onTap(e.index);
                  },
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

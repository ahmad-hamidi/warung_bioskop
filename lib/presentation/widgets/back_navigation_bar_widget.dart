import 'package:flutter/material.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';

class BackNavigationBarWidget extends StatelessWidget {
  final String title;
  final VoidCallback clickListener;
  const BackNavigationBarWidget({
    super.key,
    required this.title,
    required this.clickListener,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: clickListener,
          child: SizedBox(
            width: 40,
            height: 40,
            child: Icon(Icons.arrow_back),
          ),
        ),
        horizontalSpace(16),
        SizedBox(
          width: MediaQuery.of(context).size.width - 60 - 48,
          height: 40,
          child: Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

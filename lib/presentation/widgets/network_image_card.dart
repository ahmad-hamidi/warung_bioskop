import 'package:flutter/material.dart';

class NetworkImageCard extends StatelessWidget {
  final double width;
  final double height;
  final String? imageUrl;
  final BoxFit? fit;
  final double borderRadius;
  final VoidCallback? clickCallback;

  const NetworkImageCard({
    super.key,
    required this.width,
    required this.height,
    this.imageUrl,
    this.fit,
    required this.borderRadius,
    this.clickCallback,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: clickCallback,
      child: Container(
        width: width,
        height: height,
        decoration: const BoxDecoration(
          color: Colors.black54,
        ),
        child: Stack(
          children: [
            if (imageUrl?.isNotEmpty == true)
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(borderRadius),
                    image: DecorationImage(
                      image: NetworkImage(imageUrl!),
                      fit: fit,
                    )),
              )
            else
              const Center(
                child: CircularProgressIndicator(),
              )
          ],
        ),
      ),
    );
  }
}

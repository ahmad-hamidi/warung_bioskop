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
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            if (imageUrl?.isNotEmpty == true)
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(borderRadius),
                  child: Image.network(
                    imageUrl!,
                    fit: fit,
                    loadingBuilder: (BuildContext context, Widget child,
                        ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return Stack(
                          children: [
                            if (loadingProgress == null) child,
                          ],
                        ); // Image fully loaded
                      } else {
                        return Center(
                          child: CircularProgressIndicator(
                            value: loadingProgress.expectedTotalBytes != null
                                ? loadingProgress.cumulativeBytesLoaded /
                                    (loadingProgress.expectedTotalBytes ?? 1)
                                : null,
                          ),
                        ); // Show loading indicator
                      }
                    },
                    errorBuilder: (BuildContext context, Object error,
                        StackTrace? stackTrace) {
                      debugPrint('stackTrace $stackTrace');
                      debugPrint('error $error');
                      return const Center(
                        child: Icon(Icons.error,
                            color: Colors.red), // Fallback on error
                      );
                    },
                  ),
                ),
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

import 'dart:async';

import 'package:flutter/material.dart';

class AutoSizeNetworkImageCard extends StatefulWidget {
  final String imageUrl;
  final VoidCallback? clickCallback;
  final double borderRadius;
  final BoxFit fit;

  const AutoSizeNetworkImageCard({
    super.key,
    required this.imageUrl,
    this.clickCallback,
    this.borderRadius = 8.0,
    this.fit = BoxFit.cover,
  });

  @override
  AutoSizeNetworkImageCardState createState() =>
      AutoSizeNetworkImageCardState();
}

class AutoSizeNetworkImageCardState extends State<AutoSizeNetworkImageCard> {
  double? imageWidth;
  double? imageHeight;

  @override
  void initState() {
    super.initState();
    _getImageSize(widget.imageUrl);
  }

  Future<void> _getImageSize(String url) async {
    final Image image = Image.network(url);
    final Completer<Size> completer = Completer();
    image.image.resolve(const ImageConfiguration()).addListener(
      ImageStreamListener((ImageInfo info, bool _) {
        completer.complete(
            Size(info.image.width.toDouble(), info.image.height.toDouble()));
      }),
    );

    Size size = await completer.future;
    if (mounted) {
      setState(() {
        imageWidth = size.width;
        imageHeight = size.height;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (imageWidth == null || imageHeight == null) {
      return const Center(
          child: CircularProgressIndicator()); // Loading indicator
    }

    return GestureDetector(
      onTap: widget.clickCallback,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: Image.network(
          widget.imageUrl,
          width: imageWidth,
          height: imageHeight,
          fit: widget.fit,
        ),
      ),
    );
  }
}

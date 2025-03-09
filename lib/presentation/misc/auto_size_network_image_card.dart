import 'dart:async';

import 'package:cached_network_image/cached_network_image.dart';
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
          ImageStreamListener(
            (ImageInfo info, bool isLoad) {
              completer.complete(
                Size(info.image.width.toDouble(), info.image.height.toDouble()),
              );
            },
            onError: (error, stackTrace) {
              completer.complete(const Size(100, 100)); // Default fallback size
            },
          ),
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
    return GestureDetector(
      onTap: widget.clickCallback,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: CachedNetworkImage(
          imageUrl: widget.imageUrl,
          width: imageWidth,
          height: imageHeight,
          fit: widget.fit,
          placeholder: (context, url) =>
              const Icon(Icons.photo, size: 50, color: Colors.grey),
          errorWidget: (context, url, error) => const Icon(Icons.photo,
              size: 50, color: Colors.red), // Error fallback
          memCacheWidth: imageWidth?.toInt(),
          memCacheHeight: imageHeight?.toInt(),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';

Widget profileInfo(WidgetRef ref) {
  final url = ref.watch(userDataProvider).valueOrNull?.photoUrl;

  final imageProvider = (url?.isNotEmpty == true)
      ? NetworkImage(url!) as ImageProvider
      : const AssetImage(
          'assets/placeholder.png',
        );

  return Container(
    width: 100,
    height: 100,
    decoration: BoxDecoration(
      shape: BoxShape.circle,
      border: Border.all(color: Colors.grey, width: 1),
      image: DecorationImage(
        image: imageProvider,
        fit: BoxFit.contain,
      ),
    ),
  );
}

import 'package:flutter/material.dart';

import 'package:warung_bioskop/domain/entities/user.dart';
import 'package:warung_bioskop/presentation/extensions/int_extension.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/pages/profile_page/profile_info.dart';

Widget userInfo({
  User? user,
  required VoidCallback walletOnTap,
}) {
  return Row(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      horizontalSpace(16),
      profileInfo(user?.photoUrl, width: 60, height: 60),
      horizontalSpace(16),
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${getGreeting()}, ${user?.name}',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          verticalSpace(2),
          const Text(
            "Let's book your favorited movie",
            style: TextStyle(
              color: Colors.white,
            ),
          ),
          verticalSpace(2),
          GestureDetector(
            onTap: walletOnTap,
            child: Row(
              children: [
                const Icon(Icons.wallet),
                horizontalSpace(4),
                Text(
                  getBalanceFormat(user?.balance),
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ],
      )
    ],
  );
}

String getBalanceFormat(int? balance) {
  return (balance ?? 0).toIDRCurrencyFormat();
}

String getGreeting() {
  final hour = DateTime.now().hour;
  if (hour < 12) {
    return 'Good Morning';
  } else if (hour < 18) {
    return 'Good Afternoon';
  } else {
    return 'Good Evening';
  }
}

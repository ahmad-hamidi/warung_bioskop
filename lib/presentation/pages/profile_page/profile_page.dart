import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/pages/profile_page/profile_info.dart';
import 'package:warung_bioskop/presentation/pages/profile_page/profile_item.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(userDataProvider).valueOrNull;

    return Padding(
      padding: const EdgeInsets.only(
        left: 16,
        right: 16,
      ),
      child: ListView(
        children: [
          verticalSpace(32),
          profileInfo(userModel?.photoUrl),
          verticalSpace(16),
          Text(
            textAlign: TextAlign.center,
            userModel?.name ?? '-',
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          verticalSpace(8),
          Text(
            userModel?.email ?? '-',
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.normal,
            ),
          ),
          verticalSpace(16),
          const Divider(),
          verticalSpace(16),
          profileItem('Update Profile', () {}),
          verticalSpace(16),
          profileItem('My Wallet', () {}),
          verticalSpace(16),
          profileItem('Change Password', () {}),
          verticalSpace(16),
          profileItem('Change Language', () {}),
          verticalSpace(16),
          const Divider(),
          verticalSpace(16),
          profileItem('Contact Us', () {}),
          verticalSpace(16),
          profileItem('Privacy Policy', () {}),
          verticalSpace(16),
          profileItem('Term and Conditions', () {}),
          verticalSpace(32),
          ElevatedButton(
            onPressed: () {
              ref.read(userDataProvider.notifier).logout();
            },
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}

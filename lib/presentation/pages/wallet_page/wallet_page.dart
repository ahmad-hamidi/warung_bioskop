import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/extensions/int_extension.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/pages/wallet_page/methods/ballance_widget.dart';
import 'package:warung_bioskop/presentation/pages/wallet_page/methods/transaction_widget.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';
import 'package:warung_bioskop/presentation/widgets/back_navigation_bar_widget.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(userDataProvider).value;
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            padding: const EdgeInsets.only(top: kToolbarHeight + 16),
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    verticalSpace(190),
                    ...transactionWidget(ref: ref),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              color: Colors.transparent, // Change to a solid color if needed
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: SafeArea(
                child: Column(
                  children: [
                    BackNavigationBarWidget(
                      title: 'My Wallet',
                      clickListener: () {
                        ref.read(routerProvider).pop();
                      },
                    ),
                    verticalSpace(16),
                    balanceWidget('${user?.balance.toIDRCurrencyFormat()}',
                        '${user?.name}', () {
                      ref
                          .read(userDataProvider.notifier)
                          .topUp(Random().nextInt(99999));
                    }),
                    verticalSpace(16),
                    const Text(
                      'Recent Transaction',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

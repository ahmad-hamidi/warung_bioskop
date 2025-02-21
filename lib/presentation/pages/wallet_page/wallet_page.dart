import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/pages/wallet_page/methods/transaction_widget.dart';
import 'package:warung_bioskop/presentation/widgets/nav_bar_widget.dart';

class WalletPage extends ConsumerWidget {
  const WalletPage({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: NavBarWidget(ref: ref),
      body: Stack(
        children: [
          ListView(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    verticalSpace(16),
                    const Text(
                      'Recent Transaction',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(16),
                    ...transactionWidget(ref: ref),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

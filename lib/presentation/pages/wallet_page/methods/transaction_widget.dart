import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/pages/wallet_page/methods/transaction_card.dart';
import 'package:warung_bioskop/presentation/providers/user_data/transaction_data_provider.dart';

List<Widget> transactionWidget({required WidgetRef ref}) {
  return [
    ...ref.watch(transactionDataProvider).when(
          data: (transactions) {
            final transactionList = transactions
              ..sort(
                (a, b) => -a.transactionTime!.compareTo(b.transactionTime!),
              );

            if (transactionList.isEmpty) {
              return [
                const Center(
                  child: Text(
                    'No Transactions Found',
                    style: TextStyle(color: Colors.grey),
                  ),
                )
              ];
            }

            return transactionList.map(
              (transaction) {
                return TransactionCard(transaction: transaction);
              },
            );
          },
          error: (error, stackTrace) => [],
          loading: () => [
            const Center(
              child: CircularProgressIndicator(),
            ),
          ],
        )
  ];
}

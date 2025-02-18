import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/providers/user_data/transaction_data_provider.dart';
import 'package:warung_bioskop/presentation/widgets/ticket_widget.dart';

class TicketPage extends ConsumerWidget {
  const TicketPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView(
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            24,
            24,
            24,
            100,
          ),
          child: Column(
            children: ref.watch(transactionDataProvider).when(
                data: (transaction) {
                  return (transaction
                          .where(
                            (element) =>
                                element.title != 'Top Up' &&
                                DateTime.now().microsecondsSinceEpoch >=
                                    element.watchingTime!,
                          )
                          .toList()
                        ..sort(
                          (a, b) => a.watchingTime!.compareTo(b.watchingTime!),
                        ))
                      .map((transaction) => Padding(
                            padding: const EdgeInsets.only(
                              bottom: 20,
                            ),
                            child: TicketWidget(transaction: transaction),
                          ))
                      .toList();
                },
                error: (error, trace) => [const Text('error')],
                loading: () => [const CircularProgressIndicator()]),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/domain/entities/result.dart';
import 'package:warung_bioskop/domain/entities/transaction.dart';
import 'package:warung_bioskop/domain/usecases/create_transaction/create_transaction.dart';
import 'package:warung_bioskop/domain/usecases/create_transaction/create_transaction_param.dart';
import 'package:warung_bioskop/presentation/extensions/build_context_extension.dart';
import 'package:warung_bioskop/presentation/extensions/int_extension.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/misc/router_name.dart';
import 'package:warung_bioskop/presentation/pages/booking_confirmation_page/methods/transaction_row_widget.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/providers/usecases/create_transaction_provider.dart';
import 'package:warung_bioskop/presentation/providers/user_data/transaction_data_provider.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';
import 'package:warung_bioskop/presentation/widgets/back_navigation_bar_widget.dart';
import 'package:warung_bioskop/presentation/widgets/network_image_card.dart';

class BookingConfirmationPage extends ConsumerWidget {
  final (MovieDetail, Transaction) transactionDetail;

  const BookingConfirmationPage({
    required this.transactionDetail,
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    var (movieDetail, transaction) = transactionDetail;
    transaction = transaction.copyWith(
      total: (transaction.ticketAmount! * transaction.ticketPrice!) +
          transaction.adminFee,
    );

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
                    verticalSpace(48),
                    NetworkImageCard(
                      width: MediaQuery.of(context).size.width,
                      height: (MediaQuery.of(context).size.width - 48) * 0.6,
                      borderRadius: 8,
                      imageUrl: tmdbImageSizeW500Url +
                          (transactionDetail.$1.backdropPath ?? ''),
                      fit: BoxFit.cover,
                    ),
                    verticalSpace(12),
                    Text(
                      transactionDetail.$1.title,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    verticalSpace(12),
                    Container(
                      height: 1,
                      color: ghostWhite,
                    ),
                    verticalSpace(12),
                    transactionRowWidget(
                      title: 'Showing Date',
                      value: DateFormat('EEEE, d MMMM y').format(
                        DateTime.fromMillisecondsSinceEpoch(
                          transaction.watchingTime ?? 0,
                        ),
                      ),
                      width: MediaQuery.of(context).size.width,
                    ),
                    transactionRowWidget(
                      title: 'Theater',
                      value: transaction.theaterName ?? '-',
                      width: MediaQuery.of(context).size.width,
                    ),
                    transactionRowWidget(
                      title: 'Seat Numbers',
                      value: transaction.seats.join(', '),
                      width: MediaQuery.of(context).size.width,
                    ),
                    transactionRowWidget(
                      title: '# of Tickets',
                      value: '${transaction.seats.length} ticket(s)',
                      width: MediaQuery.of(context).size.width,
                    ),
                    transactionRowWidget(
                      title: 'Ticket Price',
                      value:
                          '${transaction.ticketPrice?.toIDRCurrencyFormat()}',
                      width: MediaQuery.of(context).size.width,
                    ),
                    transactionRowWidget(
                      title: 'Adm. Fee',
                      value: transaction.adminFee.toIDRCurrencyFormat(),
                      width: MediaQuery.of(context).size.width,
                    ),
                    verticalSpace(12),
                    Container(
                      height: 1,
                      color: ghostWhite,
                    ),
                    verticalSpace(12),
                    transactionRowWidget(
                      title: 'Total Price',
                      value: transaction.total.toIDRCurrencyFormat(),
                      width: MediaQuery.of(context).size.width,
                    ),
                  ],
                ),
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 40, horizontal: 24),
                child: ElevatedButton(
                  onPressed: () {
                    onProccesConfirm(ref, context, transaction);
                  },
                  style: ElevatedButton.styleFrom(
                    foregroundColor: backgroundColor,
                    backgroundColor: saffron,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: const Text(
                    'Pay Now',
                    style: TextStyle(color: Colors.black),
                  ),
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
                child: BackNavigationBarWidget(
                  title: 'Booking Confirmation',
                  clickListener: () {
                    ref.read(routerProvider).pop();
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void onProccesConfirm(
    WidgetRef ref,
    BuildContext context,
    Transaction transaction,
  ) async {
    int transactionTime = DateTime.now().microsecondsSinceEpoch;

    transaction = transaction.copyWith(
      transactionTime: transactionTime,
      id: 'flx-$transactionTime-${transaction.uid}',
    );
    CreateTransaction createTransaction = ref.read(createTransactionProvider);
    await createTransaction(CreateTransactionParam(transaction: transaction))
        .then((result) async {
      switch (result) {
        case Success(value: _):
          await ref
              .read(transactionDataProvider.notifier)
              .refreshTransactionData();
          await ref.read(userDataProvider.notifier).refreshUserData();
          ref.read(routerProvider).goNamed(RouterName.main);
        case Failed(:final message):
          {
            if (!context.mounted) {
              return;
            }
            context.showSnackBar(message);
          }
      }
    });
  }
}

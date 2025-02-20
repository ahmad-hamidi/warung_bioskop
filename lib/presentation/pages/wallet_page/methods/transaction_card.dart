import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warung_bioskop/domain/entities/transaction.dart';
import 'package:warung_bioskop/presentation/extensions/int_extension.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';

class TransactionCard extends StatelessWidget {
  final Transaction transaction;

  const TransactionCard({super.key, required this.transaction});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 100,
      margin: const EdgeInsets.only(bottom: 20),
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 1,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: transaction.title != topupKey
                      ? NetworkImage(tmdbImageSizeW500Url +
                          (transaction.transactionImage ?? '')) as ImageProvider
                      : const AssetImage(
                          'assets/topup.png',
                        ),
                  fit: BoxFit.cover,
                ),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10),
                  bottomLeft: Radius.circular(10),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    DateFormat('EEEE, d MMMM y HH:mm:ss').format(
                      DateTime.fromMillisecondsSinceEpoch(
                        transaction.transactionTime!,
                      ),
                    ),
                    style: const TextStyle(
                      fontSize: 10,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpace(5),
                  Text(
                    transaction.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  verticalSpace(5),
                  Text(
                    transaction.title == topupKey
                        ? '+ ${(-transaction.total).toIDRCurrencyFormat()}'
                        : transaction.total.toIDRCurrencyFormat(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: transaction.title == topupKey
                          ? const Color.fromARGB(255, 107, 237, 90)
                          : const Color(0xFFEAA94E),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

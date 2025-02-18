import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:warung_bioskop/domain/entities/transaction.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/widgets/network_image_card.dart';

class TicketWidget extends StatelessWidget {
  final Transaction transaction;

  const TicketWidget({
    super.key,
    required this.transaction,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: const Color(0xFF252836),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.grey.shade800,
              borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            child: Text(
              transaction.id ?? '-',
              style: const TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10),
                child: NetworkImageCard(
                  width: 75,
                  height: 114,
                  borderRadius: 10,
                  imageUrl: tmdbImageSizeW500Url +
                      (transaction.transactionImage ?? ''),
                  fit: BoxFit.cover,
                ),
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        transaction.title,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace(10),
                      Text(
                        transaction.theaterName ?? '-',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace(10),
                      Text(
                        DateFormat('EEEE, d MMMM y | HH:mm').format(
                          DateTime.fromMillisecondsSinceEpoch(
                            transaction.watchingTime ?? 0,
                          ),
                        ),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      verticalSpace(10),
                      Text(
                        '${transaction.ticketAmount} Tickets (${transaction.seats.join(', ')})',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

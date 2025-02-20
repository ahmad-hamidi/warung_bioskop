import 'package:flutter/material.dart';
import 'package:warung_bioskop/presentation/misc/constants.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';

Widget balanceWidget(
  String balance,
  String name,
  VoidCallback topUpOnTap,
) =>
    Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        gradient: LinearGradient(
          colors: [
            Colors.green.withOpacity(0.9),
            Colors.white30.withOpacity(0.8),
          ],
          begin: const Alignment(0, 0.3),
          end: Alignment.topCenter,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Current Balance',
                style: TextStyle(
                  color: Colors.grey.shade800,
                  fontSize: 10,
                ),
              ),
              Text(
                balance,
                style: const TextStyle(
                  color: saffron,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              verticalSpace(8),
              Text(
                name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          Column(
            children: [
              GestureDetector(
                onTap: topUpOnTap,
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.grey.shade800,
                  ),
                  padding: const EdgeInsets.all(2),
                  child: const Icon(
                    Icons.add,
                    color: saffron,
                  ),
                ),
              ),
              verticalSpace(2),
              const Text(
                'Top Up',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 10,
                ),
              ),
            ],
          )
        ],
      ),
    );

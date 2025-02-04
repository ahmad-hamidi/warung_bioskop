import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

List<Widget> promotionList(List<String> listPath) => [
      Padding(
        padding: const EdgeInsets.only(
          left: 24,
          top: 16,
        ),
        child: Text(
          'Promotion',
          style: GoogleFonts.poppins(
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
      SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
          children: listPath
              .map(
                (e) => Container(
                  width: 140,
                  height: 160,
                  margin: EdgeInsets.only(
                    left: e == listPath.first ? 24 : 10,
                    right: e == listPath.last ? 24 : 0,
                  ),
                  decoration: BoxDecoration(
                      image: DecorationImage(
                    image: AssetImage('assets/$e'),
                  )),
                ),
              )
              .toList(),
        ),
      )
    ];

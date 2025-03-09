import 'dart:io';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/entities/movie.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/domain/entities/transaction.dart';
import 'package:warung_bioskop/presentation/misc/router_name.dart';
import 'package:warung_bioskop/presentation/pages/booking_confirmation_page/booking_confirmation_page.dart';
import 'package:warung_bioskop/presentation/pages/detail_page/detail_page.dart';
import 'package:warung_bioskop/presentation/pages/login_page/login_page.dart';
import 'package:warung_bioskop/presentation/pages/main_page/main_page.dart';
import 'package:warung_bioskop/presentation/pages/register_page/register_page.dart';
import 'package:warung_bioskop/presentation/pages/seat_booking_page/seat_booking_page.dart';
import 'package:warung_bioskop/presentation/pages/splash_screen/splash_screen.dart';
import 'package:warung_bioskop/presentation/pages/time_booking_page/time_booking_page.dart';
import 'package:warung_bioskop/presentation/pages/wallet_page/wallet_page.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
      routes: [
        GoRoute(
          path: '/${RouterName.main}',
          name: RouterName.main,
          builder: (context, state) => MainPage(
            imageFile: state.extra != null ? state.extra as File : null,
          ),
        ),
        GoRoute(
          path: '/${RouterName.login}',
          name: RouterName.login,
          builder: (context, state) => const LoginPage(),
        ),
        GoRoute(
          path: '/${RouterName.register}',
          name: RouterName.register,
          builder: (context, state) => const RegsiterPage(),
        ),
        GoRoute(
          path: '/${RouterName.detail}',
          name: RouterName.detail,
          builder: (context, state) => DetailPage(
            movieEntity: state.extra as Movie,
          ),
        ),
        GoRoute(
          path: '/${RouterName.timeBooking}',
          name: RouterName.timeBooking,
          builder: (context, state) =>
              TimeBookingPage(state.extra as MovieDetail),
        ),
        GoRoute(
          path: '/${RouterName.seatBooking}',
          name: RouterName.seatBooking,
          builder: (context, state) => SeatBookingPage(
            transactionDetail: state.extra as (MovieDetail, Transaction),
          ),
        ),
        GoRoute(
          path: '/${RouterName.bookingConfirmation}',
          name: RouterName.bookingConfirmation,
          builder: (context, state) => BookingConfirmationPage(
            transactionDetail: state.extra as (MovieDetail, Transaction),
          ),
        ),
        GoRoute(
          path: '/${RouterName.myWallet}',
          name: RouterName.myWallet,
          builder: (context, state) => const WalletPage(),
        ),
        GoRoute(
          path: '/${RouterName.splashScreen}',
          name: RouterName.splashScreen,
          builder: (context, state) => const SplashScreen(),
        ),
      ],
      initialLocation: '/${RouterName.splashScreen}',
      debugLogDiagnostics: true,
    );

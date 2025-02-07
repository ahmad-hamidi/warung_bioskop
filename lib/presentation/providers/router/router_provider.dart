import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:warung_bioskop/domain/entities/movie.dart';
import 'package:warung_bioskop/domain/entities/movie_detail.dart';
import 'package:warung_bioskop/presentation/misc/router_name.dart';
import 'package:warung_bioskop/presentation/pages/detail_page/detail_page.dart';
import 'package:warung_bioskop/presentation/pages/login_page/login_page.dart';
import 'package:warung_bioskop/presentation/pages/main_page/main_page.dart';
import 'package:warung_bioskop/presentation/pages/register_page/register_page.dart';
import 'package:warung_bioskop/presentation/pages/time_booking_page/time_booking_page.dart';

part 'router_provider.g.dart';

@Riverpod(keepAlive: true)
Raw<GoRouter> router(RouterRef ref) => GoRouter(
      routes: [
        GoRoute(
          path: '/${RouterName.main}',
          name: RouterName.main,
          builder: (context, state) => const MainPage(),
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
      ],
      initialLocation: '/${RouterName.login}',
      debugLogDiagnostics: true,
    );

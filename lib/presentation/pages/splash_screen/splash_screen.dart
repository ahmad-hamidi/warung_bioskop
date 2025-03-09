import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/misc/router_name.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';

class SplashScreen extends ConsumerWidget {
  const SplashScreen({super.key, Key? ky});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      Future.delayed(const Duration(seconds: 3)).then((e) {
        if (next is AsyncData) {
          if (next.value != null) {
            ref.read(routerProvider).goNamed(RouterName.main);
          } else {
            ref.read(routerProvider).goNamed(RouterName.login);
          }
        } else {
          ref.read(routerProvider).goNamed(RouterName.login);
        }
      });
    });

    return Scaffold(
        body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        verticalSpace(50),
        Center(
          child: Image.asset(
            'assets/bioskop.png',
          ),
        ),
        verticalSpace(32),
        const Text(
          'Welcome! Experience a movie ticket purchasing simulation.',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 18,
            color: Colors.white,
            shadows: [
              Shadow(
                blurRadius: 2.0,
                color: Colors.black45,
                offset: Offset(1.0, 1.0),
              ),
            ],
          ),
        ),
      ],
    ));
  }
}

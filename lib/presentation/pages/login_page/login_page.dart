import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      if (next is AsyncData) {
        if (next.value != null) {
          ref.read(routerProvider).goNamed('main');
        }
      } else if (next is AsyncError) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              next.error.toString(),
            ),
          ),
        );
      }
    });

    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            onLogin(context, ref);
          },
          child: const Text('Login'),
        ),
      ),
    );
  }

  void onLogin(BuildContext context, WidgetRef ref) async {
    ref.read(userDataProvider.notifier).login(
          email: 'joni@gmail.com',
          password: 'joni123',
        );
  }
}

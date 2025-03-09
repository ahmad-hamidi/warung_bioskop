import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/extensions/build_context_extension.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/misc/router_name.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';
import 'package:warung_bioskop/presentation/widgets/bioskop_text_field.dart';

final emailControllerProvider = Provider((ref) => TextEditingController());
final passwordControllerProvider = Provider((ref) => TextEditingController());

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key, Key? ky});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(userDataProvider, (previous, next) {
      debugPrint('login page next: $next previous: $previous');
      if (next is AsyncData) {
        if (next.value != null) {
          ref.read(routerProvider).goNamed(RouterName.main);
        }
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(50),
          Center(
            child: Image.asset(
              'assets/bioskop.png',
              width: 150,
            ),
          ),
          verticalSpace(50),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: BioskopTextField(
                  labelText: 'Email',
                  controller: emailController,
                  isObscureText: false,
                ),
              ),
              verticalSpace(16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: BioskopTextField(
                  labelText: 'Password',
                  controller: passwordController,
                  isObscureText: true,
                ),
              ),
              // verticalSpace(16),
              // Align(
              //   alignment: Alignment.centerRight,
              //   child: TextButton(
              //     onPressed: () {},
              //     child: const Text(
              //       'Forgot Password',
              //       style: TextStyle(
              //         fontWeight: FontWeight.bold,
              //       ),
              //     ),
              //   ),
              // ),
              verticalSpace(16),
              ref.watch(userDataProvider).when(data: (user) {
                return ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  onPressed: () {
                    onLogin(context, ref);
                  },
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              }, error: (e, fd) {
                return Center(
                  child: Text(
                    'Error: $e $fd',
                    style: const TextStyle(
                      color: Colors.white,
                    ),
                  ),
                );
              }, loading: () {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }),
              verticalSpace(12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Belum punya akun?',
                    style: TextStyle(
                      color: Colors.white,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      ref.read(routerProvider).pushNamed(RouterName.register);
                    },
                    child: const Text(
                      'Buat disini',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  void onLogin(BuildContext context, WidgetRef ref) async {
    final emailController = ref.watch(emailControllerProvider);
    final passwordController = ref.watch(passwordControllerProvider);

    ref.read(userDataProvider.notifier).login(
          email: emailController.text,
          password: passwordController.text,
        );
  }
}

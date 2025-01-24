import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:warung_bioskop/presentation/extensions/build_context_extension.dart';
import 'package:warung_bioskop/presentation/misc/methods.dart';
import 'package:warung_bioskop/presentation/misc/router_name.dart';
import 'package:warung_bioskop/presentation/providers/router/router_provider.dart';
import 'package:warung_bioskop/presentation/providers/user_data/user_data_provider.dart';
import 'package:warung_bioskop/presentation/widgets/bioskop_text_field.dart';

class RegsiterPage extends ConsumerStatefulWidget {
  const RegsiterPage({super.key});

  @override
  ConsumerState<RegsiterPage> createState() {
    return _RegisterPageState();
  }
}

class _RegisterPageState extends ConsumerState<RegsiterPage> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController retypePasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen(userDataProvider, (previous, next) {
      debugPrint('register page next: $next previous: $previous');
      if (next is AsyncData && next.value != null) {
        ref.read(routerProvider).goNamed(RouterName.main);
      } else if (next is AsyncError) {
        context.showSnackBar(next.error.toString());
      }
    });

    return Scaffold(
      body: ListView(
        children: [
          verticalSpace(50),
          Column(
            children: [
              const CircleAvatar(
                radius: 50,
                child: Icon(
                  Icons.add_a_photo,
                  size: 50,
                ),
              ),
              verticalSpace(24),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: BioskopTextField(
                  labelText: 'Name',
                  controller: nameController,
                  isObscureText: false,
                ),
              ),
              verticalSpace(16),
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
              verticalSpace(16),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: BioskopTextField(
                  labelText: 'Retype password',
                  controller: retypePasswordController,
                  isObscureText: true,
                ),
              ),
              verticalSpace(16),
              ref.watch(userDataProvider).when(data: (user) {
                return ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  onPressed: () {
                    onRegister(context, ref);
                  },
                  child: const Text(
                    'Register',
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
                return ElevatedButton(
                  style: const ButtonStyle(
                    backgroundColor: WidgetStatePropertyAll(
                      Colors.white,
                    ),
                  ),
                  onPressed: () {
                    onRegister(context, ref);
                  },
                  child: const Text(
                    'Register',
                    style: TextStyle(
                      color: Colors.black,
                    ),
                  ),
                );
              }),
            ],
          ),
          verticalSpace(12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Already have an account?',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  ref.read(routerProvider).pushNamed(RouterName.login);
                },
                child: const Text(
                  'Login disini',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  void onRegister(BuildContext context, WidgetRef ref) async {
    if (passwordController.text != retypePasswordController.text) {
      context.showSnackBar('Password not matching');
      return;
    }

    ref.read(userDataProvider.notifier).register(
          email: emailController.text,
          password: passwordController.text,
          name: nameController.text,
        );
  }
}

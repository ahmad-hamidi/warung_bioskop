import 'package:flutter/material.dart';
import 'package:warung_bioskop/data/dummies/dummy_auth_repository.dart';
import 'package:warung_bioskop/data/dummies/dummy_user_repository.dart';
import 'package:warung_bioskop/data/firebase/firebase_auth_repository.dart';
import 'package:warung_bioskop/data/firebase/firebase_user_repository.dart';
import 'package:warung_bioskop/domain/usecases/login/login_params.dart';
import 'package:warung_bioskop/domain/usecases/login/login_usecase.dart';
import 'package:warung_bioskop/presentation/pages/main_page/main_page.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            onLogin(context);
          },
          child: const Text('Login'),
        ),
      ),
    );
  }

  void onLogin(BuildContext context) async {
    final LoginUsecase login = LoginUsecase(
      authRepository: FirebaseAuthRepository(),
      userRepository: FirebaseUserRepository(),
    );

    final response = await login
        .call(LoginParams(email: "joni@gmail.com", password: "joni123"));

    if (!context.mounted) return;

    if (response.isSuccess) {
      Navigator.of(context).push(
        MaterialPageRoute(
          builder: (context) => MainPage(user: response.resultValue!),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(response.errorMessage!),
        ),
      );
    }

    // login.call(LoginParams(email: "email@test.com", password: "1234")).then(
    //       (response) => {
    //         if (response.isSuccess)
    //           {
    //             Navigator.of(context).push(
    //               MaterialPageRoute(
    //                 builder: (context) => MainPage(user: response.resultValue!),
    //               ),
    //             )
    //           }
    //         else
    //           {
    //             ScaffoldMessenger.of(context).showSnackBar(
    //               SnackBar(
    //                 content: Text(response.errorMessage!),
    //               ),
    //             )
    //           }
    //       },
    //     );
  }
}

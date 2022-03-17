import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../constants.dart';
import '../../services/auth_service.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final TextEditingController emailController = TextEditingController();
    final TextEditingController passwordController = TextEditingController();

    final authService = Provider.of<AuthService>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBarBackgroundColor,
        title: const Text(
          'Admin Panel (Sign in)',
          style: kAppBarTitleTextStyle,
        ),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: TextField(
              controller: emailController,
              decoration: const InputDecoration(
                labelText: 'Email',
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 16),
            child: TextField(
              controller: passwordController,
              decoration: const InputDecoration(
                labelText: 'Password',
              ),
            ),
          ),
          // ElevatedButton(
          //   style: ButtonStyle(
          //     backgroundColor:
          //         MaterialStateProperty.all<Color>(const Color(0xFFD71440)),
          //   ),
          //   onPressed: () {
          //     authService.signInWithEmailAndPassword(
          //       emailController.text,
          //       passwordController.text,
          //     );
          //   },
          //   child: const Text('Login'),
          // ),
          // ElevatedButton(
          //   onPressed: () {
          //     Navigator.pushNamed(context, '/register');
          //   },
          //   child: Text('Register'),
          // ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await authService.signInWithEmailAndPassword(
            emailController.text.trim(),
            passwordController.text,
          );
        },
        label: const Text('Login'),
        backgroundColor: kButtonBackgroundColor,
        icon: const Icon(Icons.login),
      ),
    );
  }
}

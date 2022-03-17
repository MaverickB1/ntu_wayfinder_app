import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';

import '../../services/auth_service.dart';
import 'login_screen.dart';
import 'wrapper.dart';

class AdminPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthService>(
          create: (_) => AuthService(),
        ),
      ],
      // child: MaterialApp(
      //   title: 'Flutter Auth Example',
      //   theme: ThemeData(
      //     primarySwatch: Colors.blue,
      //   ),
      //   initialRoute: '/',
      //   routes: {
      //     '/': (context) => Wrapper(),
      //     '/login': (context) => LoginPage(),
      //     // '/register': (context) => RegisterScreen(),
      //   },
      // ),
      child: Wrapper(),
    );
  }
}

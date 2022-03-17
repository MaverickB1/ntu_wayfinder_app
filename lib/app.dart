import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'constants.dart';
import 'screens/home_screen.dart';

class App extends StatelessWidget {
  // This widget is the root of the application.

  final Future<FirebaseApp> _firebaseApp = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NTU Wayfinder',
      theme: ThemeData(
        fontFamily: 'Cairo',
        scaffoldBackgroundColor: kBackgroundColor,
        textTheme: Theme.of(context).textTheme.apply(displayColor: kTextColor),
      ),
      home: FutureBuilder(
        future: _firebaseApp,
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Error!'),
            );
          } else if (snapshot.hasData) {
            return MyHomePage();
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}

// class HomeScreen extends StatefulWidget {
//   @override
//   _HomeScreenState createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   @override
//   Widget build(BuildContext context) {
//     //query size (height & width) of device
//     final size = MediaQuery.of(context).size;
//     return Scaffold(
//       body: Stack(
//         children: <Widget>[
//           Container(
//             //Container size is made to be 45% of the total device height
//             height: size.height * 0.45,
//             decoration: const BoxDecoration(
//               color: Color(0xFFF5CEB8),
//               image: DecorationImage(
//                 alignment: Alignment.centerLeft,
//                 image:
//                     AssetImage('assets/images/instantsupport_background.png'),
//               ),
//             ),
//           ),
//           SafeArea(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 // ignore: prefer_const_literals_to_create_immutables
//                 children: <Widget>[
//                   const Padding(
//                     padding: EdgeInsets.all(16),
//                     child: Text(
//                       'Good Day Lost Adventurer! Let us help you find your way!',
//                       style: TextStyle(
//                         fontSize: 32,
//                         fontFamily: 'Cairo',
//                         fontWeight: FontWeight.bold,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

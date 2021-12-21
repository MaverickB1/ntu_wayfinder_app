import 'package:flutter/material.dart';

import 'indoor/nav_start_screen.dart';
import 'transport_mode_screen.dart';

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentIndex = 0;
  final screens = [
    const TransportModePage(),
    const NavStartPage(),
  ];

  // Future<bool> downloadData() async {
  //   final database = Database();
  //   navRoutes = await database.getNavRouteList();
  //   return true;
  // }

  @override
  void initState() {
    super.initState();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: screens,
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        selectedItemColor: Colors.blueAccent,
        onTap: (index) => setState(() => _currentIndex = index),
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.commute),
            label: 'Transport Mode',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.directions),
            label: 'Indoor Navigation',
          ),
        ],
      ),
    );
  }

  // Widget build(BuildContext context) {
  //   return FutureBuilder(
  //     future: downloadData(), // function to retrieve data from cloud firestore
  //     builder: (context, snapshot) {
  //       if (snapshot.hasError) {
  //         // error handling
  //         return const Center(
  //           child: Text('Error!'),
  //         );
  //       } else if (snapshot.hasData) {
  //         return Scaffold(
  //           appBar: AppBar(
  //             shape: const Border(
  //                 bottom: BorderSide(color: Colors.black, width: 4)),
  //             backgroundColor: const Color(0xFF0054A6),
  //             title: const Text(
  //               'NTU Wayfinder App',
  //               style: TextStyle(
  //                 color: Colors.white,
  //               ),
  //             ),
  //             actions: <Widget>[
  //               TextButton(
  //                 onPressed: () {
  //                   navRoutes.forEach((navRoute) {
  //                     final collectionRef =
  //                         FirebaseFirestore.instance.collection('navRoutes');
  //                     final docRef =
  //                         collectionRef.doc('navRoute${navRoute.routeId}');

  //                     docRef.set(navRoute.toJson());
  //                   });
  //                 },
  //                 child: const Text('Sync Here'),
  //               ),
  //             ],
  //           ),
  //           body: IndexedStack(
  //             index: _currentIndex,
  //             children: screens,
  //           ),
  //           bottomNavigationBar: BottomNavigationBar(
  //             currentIndex: _currentIndex,
  //             selectedItemColor: Colors.blueAccent,
  //             onTap: (index) => setState(() => _currentIndex = index),
  //             items: const <BottomNavigationBarItem>[
  //               BottomNavigationBarItem(
  //                 icon: Icon(Icons.commute),
  //                 label: 'Transport Mode',
  //               ),
  //               BottomNavigationBarItem(
  //                 icon: Icon(Icons.directions),
  //                 label: 'Indoor Navigation',
  //               ),
  //             ],
  //           ),
  //         );
  //         ;
  //       } else {
  //         // awaiting call function
  //         return const Center(
  //           child: CircularProgressIndicator(),
  //         );
  //       }
  //     },
  //   );
  // }
}

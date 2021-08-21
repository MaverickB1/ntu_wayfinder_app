import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ntu_wayfinder_app/widgets/search_bar_copy.dart';
import '../widgets/search_bar.dart';

class WayfinderPage extends StatelessWidget {
  const WayfinderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              //Container size is made to be 45% of the total device height
              height: size.height,
              color: const Color(0xFFF5CEB8),
              // decoration: const BoxDecoration(
              //   color: Color(0xFFF5CEB8),
              //   image: DecorationImage(
              //     alignment: Alignment.centerLeft,
              //     image:
              //         AssetImage('assets/images/instantsupport_background.svg'),
              //   ),
              // ),
              child: SvgPicture.asset(
                  'assets/images/instantsupport_background.svg'),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(28, 32, 28, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: <Widget>[
                  const Text(
                    'Hey Lost Adventurer! Let us help you find your way',
                    style: TextStyle(
                      fontSize: 32,
                      fontFamily: 'Cairo',
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SearchBarCopy(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

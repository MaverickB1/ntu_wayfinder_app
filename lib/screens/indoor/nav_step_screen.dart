import 'package:flutter/material.dart';

import '../../model/nav_step.dart';
import '../home_screen.dart';

class NavStepPage extends StatefulWidget {
  const NavStepPage(
      {Key? key,
      required this.finalStep,
      required this.navStep,
      required this.localIndex})
      : super(key: key);

  final NavStep navStep;
  final int localIndex;
  final bool finalStep;

  @override
  _NavStepPageState createState() => _NavStepPageState();
}

class _NavStepPageState extends State<NavStepPage> {
  @override
  Widget build(BuildContext context) {
    final ns = widget.navStep;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF1B1C62),
        title: Text(
          'Checkpoint ${widget.localIndex}',
        ),
      ),
      body: Column(
        children: [
          Container(
            child: Image.network(ns.imageUrl),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text(widget.navStep.instruction),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
              if (widget.finalStep) {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(
                        builder: (context) => MyHomePage(currentIndex: 1)),
                    (Route<dynamic> route) => false);
              }
            },
            child: Text(widget.finalStep ? 'Complete' : 'Next Step'),
          ),
        ],
      ),
    );
  }
}

// Future<Widget> _getImage(BuildContext context, String imageName) async {
//   Image image;

//   await FireStorageService.loadImage(context, imageName).then((value) {
//     image = Image.network(
//       value.toString(),
//       fit: BoxFit.scaleDown,
//     );
//   });

//   return image;
// }

// class FireStorageService extends ChangeNotifier {
//   FireStorageService();
//   static Future<dynamic> loadImage(BuildContext context, String Image) async {
//     return await FirebaseStorage.instance.ref().child(Image).getDownloadURL();
//   }
// }

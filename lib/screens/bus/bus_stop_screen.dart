import 'package:flutter/material.dart';
import 'package:ntu_wayfinder_app/model/bus_stop.dart';
import '../../model/nav_step.dart';

class BusStopPage extends StatefulWidget {
  const BusStopPage({Key? key, required this.busStop, required this.localIndex})
      : super(key: key);

  final BusStop busStop;
  final int localIndex;

  @override
  _BusStopPageState createState() => _BusStopPageState();
}

class _BusStopPageState extends State<BusStopPage> {
  @override
  Widget build(BuildContext context) {
    final bs = widget.busStop;

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
            child: Image.asset(bs.stopImage),
          ),
          Container(
            alignment: Alignment.bottomCenter,
            child: const Padding(
              padding: EdgeInsets.all(16),
              child: Text('nil'),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context, true);
            },
            child: const Text('Next Stop'),
          )
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

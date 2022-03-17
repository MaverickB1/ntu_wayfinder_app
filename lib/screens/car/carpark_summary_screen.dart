import 'package:flutter/material.dart';

import '../../constants.dart';
import '../../model/destination.dart';
import '../../services/map_util.dart';
import '../home_screen.dart';
// import 'package:ntu_wayfinder_app/constants.dart';
// import 'package:ntu_wayfinder_app/screens/home_screen.dart';

// import '../../model/destination.dart';
// import '../../services/map_util.dart';
// import '../indoor/nav_start_screen.dart';

class CarparkSummaryPage extends StatefulWidget {
  const CarparkSummaryPage({
    Key? key,
    required this.destination,
  }) : super(key: key);

  final Destination destination;

  @override
  _CarparkSummaryPageState createState() => _CarparkSummaryPageState();
}

class _CarparkSummaryPageState extends State<CarparkSummaryPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // shape: const Border(bottom: BorderSide(width: 4)),
        backgroundColor: kAppBarBackgroundColor,
        title: Text(
          widget.destination.label,
          style: kAppBarTitleTextStyle,
        ),
      ),
      body: Column(
        children: [
          Image.asset(widget.destination.destinationImage),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.destination.carparks.length,
            itemBuilder: (context, index) {
              final cp = widget.destination.carparks[index];

              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.asset(cp.carparkImage),
                  ),
                  title: Text(
                    index == 0
                        ? 'Recommended: Carpark ${cp.carparkId}'
                        : 'Fastest: Carpark ${cp.carparkId}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'Hourly Charge: \$${cp.hourCost}\nOperation: ${cp.opsInfo}'),
                  isThreeLine: true,
                  trailing: const Icon(Icons.arrow_forward_rounded),
                  onTap: () {
                    MapUtil.openMap(cp.mapLaunchUrl);
                  },
                ),
              );
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => MyHomePage(
                currentIndex: 1,
              ),
            ),
          );
        },
        label: const Text('I have arrived!'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: kButtonBackgroundColor,
      ),
    );
  }
}

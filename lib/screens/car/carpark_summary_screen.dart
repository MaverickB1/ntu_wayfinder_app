import 'package:flutter/material.dart';

import '../../model/destination.dart';
import '../../services/map_util.dart';
import '../indoor/nav_start_screen.dart';

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
        backgroundColor: const Color(0xFF0054A6),
        title: Text(
          widget.destination.label,
          style: const TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      body: Column(
        children: [
          Image.network(widget.destination.destinationImage),
          ListView.builder(
            shrinkWrap: true,
            itemCount: widget.destination.carparks.length,
            itemBuilder: (context, index) {
              final cp = widget.destination.carparks[index];

              return Card(
                child: ListTile(
                  leading: ClipRRect(
                    child: Container(
                      height: 80,
                      width: 80,
                      child: Image.network(cp.carparkImage),
                    ),
                  ),
                  title: Text(
                    index == 0
                        ? 'Recommended: Carpark ${cp.carparkId}'
                        : 'Fastest: Carpark ${cp.carparkId}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                      'Operation: ${cp.opsInfo}\nHourly Charge: \$${cp.hourCost}'),
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
              builder: (context) => const NavStartPage(),
            ),
          );
        },
        label: const Text('I have arrived!'),
        icon: const Icon(Icons.thumb_up),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

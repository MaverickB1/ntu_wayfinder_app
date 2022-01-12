import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ntu_wayfinder_app/constants.dart';

import '../../model/bus_route.dart';
import '../../model/bus_start.dart';
import '../../services/database.dart';
import 'bus_route_screen.dart';

class BusDestinationPage extends StatefulWidget {
  const BusDestinationPage({Key? key, required this.busStart})
      : super(key: key);

  final BusStart busStart;

  @override
  _BusDestinationPageState createState() => _BusDestinationPageState();
}

class _BusDestinationPageState extends State<BusDestinationPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // shape: const Border(bottom: BorderSide(width: 4)),
        backgroundColor: kAppBarBackgroundColor,
        title: const Text(
          'NTU Wayfinder',
          style: kAppBarTitleTextStyle,
        ),
      ),
      backgroundColor: const Color(0xFFD71440),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 360, 32, 0),
            child: SvgPicture.asset('assets/images/bus_stop_bg.svg',
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Text(
              'Shuttle Bus Navigation \n(Destination)',
              style: kScreenTitleTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 150, 16, 0),
            child: StreamBuilder<List<BusRoute>>(
                stream: Stream<List<BusRoute>>.fromFuture(
                    Database.getBusRouteList(busStart: widget.busStart)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: TypeAheadField<BusRoute?>(
                        hideSuggestionsOnKeyboardHide: false,
                        textFieldConfiguration: const TextFieldConfiguration(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            hintText: 'Choose Destination',
                          ),
                        ),
                        suggestionsCallback: (inputText) {
                          return BusRoute.getFirestoreBusRouteSuggestions(
                              query: inputText, data: snapshot.data!);
                        },
                        itemBuilder: (context, suggestion) {
                          final br = suggestion!;

                          return ListTile(
                            leading: Container(
                              width: 60,
                              height: 60,
                              //   child: Image.network(
                              //   user.imageUrl,
                              //   fit: BoxFit.cover,
                              // ),
                              child: Center(
                                child: Text(
                                  br.routeId.toString(),
                                ),
                              ),
                            ),
                            title: Text(
                              br.locationEnd,
                            ),
                          );
                        },
                        noItemsFoundBuilder: (context) => Container(
                          height: 100,
                          child: const Center(
                            child: Text(
                              'No Routes Found.',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        onSuggestionSelected: (suggestion) {
                          final br = suggestion!;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => BusRoutePage(busRoute: br),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                }),
          ),
        ],
      ),
    );
  }
}

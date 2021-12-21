import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../model/bus_start.dart';
import '../../services/database.dart';
import 'bus_destination_screen.dart';

class BusStartPage extends StatelessWidget {
  const BusStartPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // shape: const Border(bottom: BorderSide(width: 4)),
        backgroundColor: const Color(0xFF0054A6),
        title: const Text(
          'NTU Wayfinder',
          style: TextStyle(
            color: Colors.white,
          ),
        ),
      ),
      backgroundColor: const Color(0xFF1B1C62),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(32, 300, 32, 0),
            child: SvgPicture.asset('assets/images/indoor_navigation_bg.svg',
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Text(
              'Shuttle Bus Navigation \n(Start)',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 32,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 150, 16, 0),
            child: StreamBuilder<List<BusStart>>(
                stream: Stream<List<BusStart>>.fromFuture(
                    Database.getBusStartList()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: TypeAheadField<BusStart?>(
                        hideSuggestionsOnKeyboardHide: false,
                        textFieldConfiguration: const TextFieldConfiguration(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.pin_drop),
                            border: OutlineInputBorder(),
                            hintText: 'Your Location',
                          ),
                        ),
                        suggestionsCallback: (inputText) {
                          return BusStart.getFirestoreBusStartSuggestions(
                              query: inputText, data: snapshot.data!);
                        },
                        itemBuilder: (context, suggestion) {
                          final bs = suggestion!;

                          return ListTile(
                            //TODO: add image url
                            // leading: Container(
                            //   width: 60,
                            //   height: 60,
                            //   //   child: Image.network(
                            //   //   user.imageUrl,
                            //   //   fit: BoxFit.cover,
                            //   // ),
                            //   child: Center(
                            //     child: Text(
                            //       ns.routeId.toString(),
                            //     ),
                            //   ),
                            // ),
                            title: Text(
                              bs.locationName,
                            ),
                          );
                        },
                        noItemsFoundBuilder: (context) => Container(
                          height: 100,
                          child: const Center(
                            child: Text(
                              'No Location Found.',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        onSuggestionSelected: (suggestion) {
                          final bs = suggestion!;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BusDestinationPage(busStart: bs),
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

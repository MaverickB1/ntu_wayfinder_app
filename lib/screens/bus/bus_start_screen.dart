import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ntu_wayfinder_app/constants.dart';

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
        backgroundColor: kAppBarBackgroundColor,
        title: const Text(
          'Travel by Shuttle Bus',
          style: kAppBarTitleTextStyle,
        ),
      ),
      backgroundColor: kScreenBackgroundColor,
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
              'Shuttle Bus Navigation \n(Start)',
              style: kScreenTitleTextStyle,
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

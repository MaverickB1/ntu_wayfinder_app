import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../../model/destination.dart';
import '../../services/database.dart';
import 'carpark_summary_screen.dart';

class CarPage extends StatelessWidget {
  const CarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // shape: const Border(bottom: BorderSide(width: 4)),
        backgroundColor: const Color(0xFF0054A6),
        title: const Text(
          'Travel by Car',
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
              'Getting to NTU by Car',
              style: TextStyle(
                color: Color(0xFFFFFFFF),
                fontSize: 32,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.fromLTRB(16, 128, 16, 0),
              child: StreamBuilder<List<Destination>>(
                stream: Stream<List<Destination>>.fromFuture(
                    Database.getDestinationList()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: TypeAheadField<Destination?>(
                        hideSuggestionsOnKeyboardHide: false,
                        textFieldConfiguration: const TextFieldConfiguration(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            hintText: 'Tap Here to Search Navigation Route',
                          ),
                        ),
                        suggestionsCallback:
                            Destination.getDestinationSuggestions,
                        itemBuilder: (context, suggestion) {
                          final des = suggestion!;

                          return ListTile(
                            leading: Container(
                                width: 60,
                                height: 60,
                                child: Image.network(des.destinationImage)),
                            title: Text(
                              des.label.toString(),
                            ),
                          );
                        },
                        noItemsFoundBuilder: (context) => Container(
                          height: 100,
                          child: const Center(
                            child: Text(
                              'No Destinations Found.',
                              style: TextStyle(fontSize: 24),
                            ),
                          ),
                        ),
                        onSuggestionSelected: (suggestion) {
                          final des = suggestion!;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  CarparkSummaryPage(destination: des),
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return const CircularProgressIndicator();
                  }
                },
              )),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import '../model/nav_route.dart';
import 'nav_route_page.dart';

class WayfinderPage extends StatelessWidget {
  const WayfinderPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5CEB8),
      body: Stack(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
            child: SvgPicture.asset(
                'assets/images/instantsupport_background.svg',
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(28, 8, 28, 8),
            child: Text(
              'Let us help you find your way Lost Adventurer!',
              style: TextStyle(
                fontSize: 28,
                fontFamily: 'Cairo',
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 120, 10, 0),
            child: Container(
              padding: const EdgeInsets.all(16),
              child: TypeAheadField<NavRoute?>(
                hideSuggestionsOnKeyboardHide: false,
                textFieldConfiguration: const TextFieldConfiguration(
                  decoration: InputDecoration(
                    prefixIcon: Icon(Icons.search),
                    border: OutlineInputBorder(),
                    hintText: 'Tap Here to Search Navigation Route',
                  ),
                ),
                suggestionsCallback: NavRoute.getSuggestions,
                itemBuilder: (context, suggestion) {
                  final nr = suggestion!;

                  return ListTile(
                    leading: Container(
                      width: 60,
                      height: 60,
                      child: Text(
                        nr.id.toString(),
                      ),
                    ),
                    title: Text(
                      '${nr.start} to ${nr.destination}',
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
                  final index = suggestion!.id - 1;

                  Navigator.of(context).push<MaterialPageRoute>(
                    MaterialPageRoute(
                      builder: (context) => NavRoutePage(id: index),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}

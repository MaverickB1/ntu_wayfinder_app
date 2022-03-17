import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ntu_wayfinder_app/constants.dart';

import '../../model/nav_route.dart';
import '../../model/nav_start.dart';
import '../../services/database.dart';
import 'nav_route_screen.dart';

class NavDestinationPage extends StatefulWidget {
  const NavDestinationPage({Key? key, required this.navStart})
      : super(key: key);

  final NavStart navStart;

  @override
  _NavDestinationPageState createState() => _NavDestinationPageState();
}

class _NavDestinationPageState extends State<NavDestinationPage> {
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
            child: SvgPicture.asset('assets/images/indoor_navigation_bg.svg',
                alignment: Alignment.topCenter,
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 32, 32, 0),
            child: Text(
              'Indoor Navigation \n(Destination)',
              style: kScreenTitleTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 150, 16, 0),
            child: StreamBuilder<List<NavRoute>>(
                stream: Stream<List<NavRoute>>.fromFuture(
                    Database.getNavRouteList(navStart: widget.navStart)),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: TypeAheadField<NavRoute?>(
                        hideSuggestionsOnKeyboardHide: false,
                        textFieldConfiguration: const TextFieldConfiguration(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(),
                            hintText: 'Choose Destination',
                          ),
                        ),
                        suggestionsCallback: (inputText) {
                          return NavRoute.getFirestoreNavRouteSuggestions(
                              query: inputText, data: snapshot.data!);
                        },
                        itemBuilder: (context, suggestion) {
                          final nr = suggestion!;

                          return ListTile(
                            leading: Container(
                              width: 60,
                              height: 60,
                              child: Image.network(nr.navSteps.last.imageUrl),
                            ),
                            title: Text(
                              nr.locationEnd,
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
                          final nr = suggestion!;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => NavRoutePage(navRoute: nr),
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

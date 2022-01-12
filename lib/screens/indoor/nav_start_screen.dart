import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:ntu_wayfinder_app/constants.dart';

import '../../data/bus/bus_route_data.dart';
import '../../data/bus/bus_start_data.dart';
import '../../data/car/destination_data.dart';
import '../../data/indoor/nav_route_data.dart';
import '../../data/indoor/nav_start_data.dart';
import '../../model/nav_start.dart';
import '../../services/database.dart';
import 'nav_destination_screen.dart';

class NavStartPage extends StatelessWidget {
  const NavStartPage({Key? key}) : super(key: key);

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
        actions: <Widget>[
          //Sync Local Data to Firebase
          TextButton(
            onPressed: () {
              destinations.forEach((destination) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('destinations');
                final docRef = collectionRef
                    .doc('destination${destination.destinationId}');

                docRef.set(destination.toJson());
              });

              navRoutes.forEach((navRoute) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('navRoutes');
                final docRef = collectionRef.doc('navRoute${navRoute.routeId}');

                docRef.set(navRoute.toJson());
              });

              navStarts.forEach((navStart) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('navStarts');
                final docRef =
                    collectionRef.doc('navStart${navStart.locationId}');

                docRef.set(navStart.toJson());
              });

              busRoutes.forEach((busRoute) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('busRoutes');
                final docRef = collectionRef.doc('busRoute${busRoute.routeId}');

                docRef.set(busRoute.toJson());
              });

              busStarts.forEach((busStart) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('busStarts');
                final docRef =
                    collectionRef.doc('busStart${busStart.locationId}');

                docRef.set(busStart.toJson());
              });
            },
            child: const Text('Sync Here'),
          ),
        ],
      ),
      backgroundColor: kScreenBackgroundColor,
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
              'Indoor Navigation \n(Start)',
              style: kScreenTitleTextStyle,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(16, 150, 16, 0),
            child: StreamBuilder<List<NavStart>>(
                stream: Stream<List<NavStart>>.fromFuture(
                    Database.getNavStartList()),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Container(
                      padding: const EdgeInsets.all(16),
                      child: TypeAheadField<NavStart?>(
                        hideSuggestionsOnKeyboardHide: false,
                        textFieldConfiguration: const TextFieldConfiguration(
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.pin_drop),
                            border: OutlineInputBorder(),
                            hintText: 'Your Location',
                          ),
                        ),
                        suggestionsCallback: (inputText) {
                          return NavStart.getFirestoreNavStartSuggestions(
                              query: inputText, data: snapshot.data!);
                        },
                        itemBuilder: (context, suggestion) {
                          final ns = suggestion!;

                          return ListTile(
                            leading: Container(
                              width: 60,
                              height: 60,
                              child: Image.asset(ns.locationImage),
                            ),
                            title: Text(
                              ns.locationName,
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
                          final ns = suggestion!;

                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  NavDestinationPage(navStart: ns),
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
          const Padding(
            padding: EdgeInsets.fromLTRB(32, 230, 32, 0),
            child: Text(
              'Pick the closest recognizable landmark,\nlong-press option to enlarge image',
              style: kScreenSubtitleTextStyle,
            ),
          ),
        ],
      ),
    );
  }
}

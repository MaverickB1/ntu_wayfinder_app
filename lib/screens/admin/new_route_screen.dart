import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';
import 'package:provider/provider.dart';

import '../../../data/bus/bus_route_data.dart';
import '../../../data/bus/bus_start_data.dart';
import '../../../data/car/destination_data.dart';
import '../../../data/indoor/nav_start_data.dart';
import '../../constants.dart';
import '../../data/indoor/nav_route_data.dart';
import '../../model/nav_route.dart';
import '../../model/nav_start.dart';
import '../../model/nav_step.dart';
import '../../services/auth_service.dart';

class NewRoutePage extends StatefulWidget {
  NewRoutePage({Key? key}) : super(key: key);

  @override
  _NewRoutePageState createState() => _NewRoutePageState();
}

class _NewRoutePageState extends State<NewRoutePage> {
  final _formKey = GlobalKey<FormState>();

  TextEditingController _startLocationController = TextEditingController();
  TextEditingController _endLocationController = TextEditingController();
  TextEditingController _instructionController = TextEditingController();

  XFile? image;
  String fileName = '';

  List<NavStep> navSteps = [];

  Future _getImage() async {
    var picker = ImagePicker();
    var selectedImage = await picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 150,
    );

    setState(() {
      image = selectedImage!;
      fileName = basename(image!.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        // shape: const Border(bottom: BorderSide(width: 4)),
        backgroundColor: kAppBarBackgroundColor,
        title: const Text(
          'Admin Panel (Add new route)',
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
              print('destination okay');

              navRoutes.forEach((navRoute) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('navRoutes');
                final docRef = collectionRef.doc('navRoute${navRoute.routeId}');

                docRef.set(navRoute.toJson());
              });
              print('navroute okay');

              navStarts.forEach((navStart) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('navStarts');
                final docRef =
                    collectionRef.doc('navStart${navStart.locationId}');

                docRef.set(navStart.toJson());
              });
              print('navstart okay');

              busRoutes.forEach((busRoute) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('busRoutes');
                final docRef = collectionRef.doc('busRoute${busRoute.routeId}');

                docRef.set(busRoute.toJson());
              });
              print('busroute okay');

              busStarts.forEach((busStart) {
                final collectionRef =
                    FirebaseFirestore.instance.collection('busStarts');
                final docRef =
                    collectionRef.doc('busStart${busStart.locationId}');

                docRef.set(busStart.toJson());
              });
              print('busstart okay');
            },
            child: const Text('Sync Here'),
          ),
        ],
      ),
      backgroundColor: kScreenBackgroundColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // const Padding(
          //   padding: EdgeInsets.fromLTRB(32, 32, 32, 0),
          //   child: Text(
          //     'Add new route',
          //     style: kScreenTitleTextStyle,
          //   ),
          // ),
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(32),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  TextFormField(
                    decoration:
                        const InputDecoration(hintText: 'Start Location'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Entry is empty!';
                      }
                    },
                    controller: _startLocationController,
                  ),
                  TextFormField(
                      decoration:
                          const InputDecoration(hintText: 'End Location'),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Entry is empty!';
                        }
                      },
                      controller: _endLocationController),
                  Row(
                    children: [
                      const Text('Navigation Steps'),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.add_circle),
                        onPressed: () {
                          showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                    title: const Text('Add Navigation Step'),
                                    content: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: <Widget>[
                                          TextFormField(
                                              decoration: const InputDecoration(
                                                  hintText: 'Instruction'),
                                              validator: (value) {
                                                if (value!.isEmpty) {
                                                  return 'Entry is empty!';
                                                }
                                              },
                                              controller:
                                                  _instructionController),
//here
                                          FloatingActionButton.extended(
                                            onPressed: () async {
                                              await _getImage();

                                              setState(() {
                                                navSteps.add(NavStep(
                                                    imageUrl: image!.path,
                                                    stepId: 0,
                                                    instruction:
                                                        _instructionController
                                                            .text));

                                                _instructionController.text =
                                                    '';
                                                image = null;

                                                Navigator.of(context).pop();
                                              });
                                            },
                                            tooltip: 'Upload Image',
                                            icon: const Icon(Icons.add_a_photo),
                                            label: const Text('Upload'),
                                          ),
                                        ]));
                              });
                        },
                      )
                    ],
                  ),
                  ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: navSteps.length,
                      itemBuilder: (context, index) {
                        return Card(
                            child: ListTile(
                          leading: Image.file(File(navSteps[index].imageUrl)),
                          title: Text(
                            navSteps[index].instruction,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_circle),
                            onPressed: () {
                              setState(() {
                                navSteps.removeAt(index);
                              });
                            },
                          ),
                        ));
                      }),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        ///Firebase store
                        // setState(() {
                        // this._formKey.currentState.save();
                        // });
                        final collectionRefNavRoutes =
                            FirebaseFirestore.instance.collection('navRoutes');
                        final docRefNavRoutes = collectionRefNavRoutes.doc();

                        await saveImages();

                        var navRoute = NavRoute(
                            locationStart: _startLocationController.text,
                            locationEnd: _endLocationController.text,
                            routeId: 0,
                            navSteps: navSteps);

                        await docRefNavRoutes.set(navRoute.toJson());

                        final collectionRefNavStarts =
                            FirebaseFirestore.instance.collection('navStarts');
                        final docRefNavStarts = collectionRefNavStarts.doc();

                        final queryCheckNavStarts = await collectionRefNavStarts
                            .where('locationName',
                                isEqualTo: _endLocationController.text)
                            .get(); //this gets a filtered collection of NavStarts

                        print(_endLocationController.text);
                        print(queryCheckNavStarts);
                        print(queryCheckNavStarts.docs);
                        print(queryCheckNavStarts.docs.length);

                        //if there is a document (isNotEmpty == true), don't do anything
                        //if there isn't a document (isNotEmpty == false), update update
                        if (queryCheckNavStarts.docs.isNotEmpty) {
                          print('already exists');
                        } else {
                          var navStart = NavStart(
                              locationName: _endLocationController.text,
                              locationId: 0,
                              locationImage: navSteps[0].imageUrl);

                          await docRefNavStarts.set(navStart.toJson());
                        }

                        // var navStart = NavStart(
                        //     locationName: _startLocationController.text,
                        //     locationId: 0,
                        //     locationImage: navSteps[0].imageUrl);

                        // await docRefNavStarts.set(navStart.toJson());

                        ///Success message
                        setState(() {
                          _startLocationController.text = '';
                          _endLocationController.text = '';
                          navSteps.clear();
                        });
                      }
                    },
                    child: const Text('Submit'),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          await authService.signOut();
        },
        label: const Text('Logout'),
        backgroundColor: kButtonBackgroundColor,
        icon: const Icon(Icons.logout),
        // backgroundColor: MaterialStateProperty.all<Color>(const Color(0xFFD71440)),
        // ElevatedButton(
        //     style: ButtonStyle(
        //       backgroundColor:
        //           MaterialStateProperty.all<Color>(const Color(0xFFD71440)),
        //     ),

        //     child: const Text('Log out'),
        //   ),
      ),
    );
  }

  Future<void> saveImages() async {
    for (var i = 0; i < navSteps.length; i++) {
      final imageURL = await uploadFile(File(navSteps[i].imageUrl));

      navSteps[i].imageUrl = imageURL;
    }
  }

  Future<String> uploadFile(File _image) async {
    final storageReference = FirebaseStorage.instance
        .ref()
        .child('sightings/${basename(_image.path)}');
    final uploadTask = storageReference.putFile(_image);
    final downloadUrl = await uploadTask;
    final returnURL = await storageReference.getDownloadURL();

    return returnURL;
  }
}

import 'dart:async';
import 'dart:io';
import 'package:location/location.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:wastegram/screens/post_details_screen.dart';
import 'package:wastegram/screens/post_entry_form.dart';
import '../models/post_fields.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CameraScreen extends StatefulWidget {

  late num passcounter;

  CameraScreen(this.passcounter, {Key? key}) : super(key: key);

  @override
  _CameraScreenState createState() => _CameraScreenState(passcounter);
}

class _CameraScreenState extends State<CameraScreen> {

  _CameraScreenState(this.passcounter);
  late num passcounter;
  File? image;
  final picker = ImagePicker();
  final postInfo = PostFields(items: '', date: '', url: '', longitude: '', latitude: '');

  late LocationData locationData;
  bool locationSet = false;
  late PostFields postFields;
  num totalCount = 0;
  int count = 0;

  @override
  void initState() {
    super.initState();
    retrieveLocation();
  }

  // this functions will get our users location data and will keep count
  // of the number of wasted items entered by the user.
  void retrieveLocation() async {
    var locationService = Location();
    locationData = await locationService.getLocation();
    setState(() {
      locationSet=true;
    });
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    //prefs.setInt('itemCount', 0);
    count = prefs.getInt('itemCount') ?? 0;
    setState(() {
      count += 0;
    });
  }

/*
* Pick an image from the gallery, upload it to Firebase Storage and return
* the URL of the image in Firebase Storage.
*/
  Future<File?> getImage() async {
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickedFile!.path);
    return image;
  }


  @override
  Widget build(BuildContext context) {
    late final imageURL;
    late var longPost;
    late var latPost;

    if (locationSet == false) {
      // if no location data spinning location wheel displayed
      return Center(child: const CircularProgressIndicator());
    } else {
      return Scaffold(
          appBar: AppBar(
            // display the count along with the title
            title: Text('Wasteagram - $count'),
            centerTitle: true,
          ),
          body:
          // get our firebase instance and get records to display out of it
          StreamBuilder(
              stream: FirebaseFirestore.instance.collection('wasteposts').orderBy('url', descending: true).snapshots(),
              builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData &&
                    snapshot.data!.docs != null &&
                    snapshot.data!.docs.length > 0) {
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: snapshot.data!.docs.length,
                          itemBuilder: (context, index) {
                            var post = snapshot.data!.docs[index];
                            return Semantics(
                              enabled: true, onTapHint: 'See details of post.',
                              child: ListTile(
                                // display date and items wasted on our list view
                                  title: Text(post['date'].toString(), style: Theme.of(context).textTheme.headline6),
                                  trailing: Text(post['items'].toString(), style: Theme.of(context).textTheme.headline6),
                                  onTap: () {
                                    postInfo.items = post['items'].toString();
                                    postInfo.date = post['date'];
                                    postInfo.url = post['url'];
                                    postInfo.longitude = post['longitude'].toString();
                                    postInfo.latitude = post['latitude'].toString();
                                    // send the fields needed to display on details screen
                                    Navigator.push(context, MaterialPageRoute(builder: (context) =>
                                        PostDetailsScreen(postInfo.items, postInfo.date, postInfo.url,
                                            postInfo.longitude, postInfo.latitude)));
                                  })
                            );
                          },
                        ),
                      ),
                      // button will allow user to add a new post if records
                      // are already entered
                      Semantics(
                        enabled: true, button: true, onTapHint: 'Select an image to upload.',
                        child: IconButton(
                          icon: const Icon(Icons.add_a_photo_rounded, color: Colors.white, size: 35),
                          onPressed: () async {
                            imageURL = await getImage();
                            longPost = locationData.longitude.toString();
                            latPost = locationData.latitude.toString();
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) => PostEntryScreen(imageURL, longPost, latPost, totalCount)));
                          },
                        ),
                      ),

                    ],
                  );
                } else {
                  // display the spinning circel and icon button when no records
                  // have been entered
                  return Semantics(
                    enabled: true, button: true, onTapHint: 'Select an image to upload.',
                    child: Column(
                      children: [
                        const Expanded(
                          child: Align(alignment: Alignment.center, child: CircularProgressIndicator()),
                        ),
                        Expanded(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: IconButton(
                                icon: const Icon(Icons.add_a_photo_rounded, color: Colors.white, size: 35),
                                onPressed: () async {
                                  imageURL = await getImage();
                                  longPost = locationData.longitude.toString();
                                  latPost = locationData.latitude.toString();
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => PostEntryScreen(imageURL, longPost, latPost, totalCount)));
                                },
                              ),
                            )
                        )
                      ],
                    )
                  );
                }
              })
      );
    }
  }
}
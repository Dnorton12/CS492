import 'dart:io';
import 'package:flutter/material.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'camera_screens.dart';

class PostEntryScreen extends StatefulWidget {
  final File imageURL;
  final String longPost;
  final String latPost;
  late num count;


  PostEntryScreen(this.imageURL, this.longPost, this.latPost, this. count, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostEntryScreenState(imageURL, longPost, latPost, count);
}

class _PostEntryScreenState extends State<PostEntryScreen> {

  _PostEntryScreenState(this.imageURL, this.longPost, this.latPost, this.count);

  final File imageURL;
  final String longPost;
  final String latPost;
  late num count;
  String? items;
  final formKey = GlobalKey<FormState>();

  // used to set the number of items correctly
  setItemNumber(value) async {
    int counter = 0;
    int counter2 = 0;
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    counter = prefs.getInt('itemCount') ?? 0;
    counter2 = int.parse(value);
    counter += counter2;
    prefs.setInt('itemCount', counter);
  }

  // will show the user the image they selected and also allow them
  // to input a number greater then 0
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text('New Post'),
          centerTitle: true),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
                height: MediaQuery.of(context).size.width / 1.5,
                width: MediaQuery.of(context).size.width,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Image.file(imageURL),
                )
            ),
            Padding(padding: const EdgeInsets.only(top: 15, left: 10, right: 10),
              child: Form(
                  key: formKey,
                  child: Column(
                      children: [
                        TextFormField(
                          style: const TextStyle(height: 1, fontSize:30),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.greenAccent, width: 3)
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide: BorderSide(color: Colors.greenAccent, width: 3)
                            ),
                            contentPadding: EdgeInsets.symmetric(horizontal: 50, vertical: 10),
                            labelText: 'Enter number of wasted items',
                            labelStyle: TextStyle(fontSize: 20),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            floatingLabelAlignment: FloatingLabelAlignment.center
                          ),
                          keyboardType: TextInputType.number,
                          onSaved: (value) {
                            items = value;
                          },
                          validator: (value) {
                            if (value!.isEmpty) {
                              return 'Please enter a valid number of items';
                            } else {
                              if (int.parse(value) <= 0) {
                                return 'Enter a number of items greater than 0.';
                              }
                            }
                            setItemNumber(value);
                            return null;
                          },
                        ),
                      ]
                  )
              ),

            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        // this is the bottom app bar button that will send information to
        // firebase and route the user back to the listview screen
        child: Semantics(
          enabled: true, button: true, onTapHint: 'Upload a new post.',
          child: Container(
            color: Colors.blue,
            height: 100,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                    child:
                    IconButton(
                        padding: const EdgeInsets.only(bottom: 55),
                        icon: const Icon(Icons.cloud_upload_rounded, color: Colors.white, size: 85),
                        onPressed: () async{
                          formKey.currentState!.validate();
                          formKey.currentState!.save();
                          await uploadToDatabase(imageURL, items, longPost, latPost);
                          Navigator.push(context,
                              MaterialPageRoute(builder: (context) => CameraScreen(count)));
                        }
                    )
                )
              ],
            ),
          )
        )
      ),
    );
  }

  // upload information to database
  Future uploadToDatabase(imageURL, items, finalLong, finalLat) async {
    var fileName = '${DateTime.now()}.jpg';
    Reference storageReference = FirebaseStorage.instance.ref().child(fileName);
    UploadTask uploadTask = storageReference.putFile(imageURL);
    await uploadTask;
    final url = await storageReference.getDownloadURL();
    final date = DateFormat.yMMMMEEEEd().format(DateTime.now());
    int finalCount = int.parse(items);
    FirebaseFirestore.instance
        .collection('wasteposts')
        .add({'date': date, 'items': finalCount, 'url': url,
          'longitude': finalLong, 'latitude': finalLat
    });
  }
}
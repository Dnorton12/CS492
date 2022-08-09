import 'dart:core';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class PostDetailsScreen extends StatefulWidget {

  late String finalItem;
  late String finalDate;
  late String finalURL;
  late String finalLong;
  late String finalLat;

  PostDetailsScreen(this.finalItem, this.finalDate, this.finalURL,
      this.finalLong, this.finalLat, {Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PostDetailScreen();
  }

class _PostDetailScreen extends State<PostDetailsScreen> {

  // this will display the date, image, number of items, longitude and latitude
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Wasteagram'),
          centerTitle: true,
        ),
        body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('wasteposts').snapshots(),
          builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {{
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(50),
                    child: Text(widget.finalDate, style: Theme.of(context).textTheme.headline5),),

                  SizedBox(
                      height: MediaQuery.of(context).size.width / 1.5,
                      width: MediaQuery.of(context).size.width,
                      child: FittedBox(
                        fit: BoxFit.fill,
                        alignment: Alignment.center,
                        child: Image.network(widget.finalURL),
                      )),

                  Padding(
                    //fit: BoxFit.fill,
                    padding: const EdgeInsets.only(top:40, bottom: 90),
                    child: Text('${widget.finalItem} items', style: Theme.of(context).textTheme.headline4)),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 25),
                    child: Text('Location:  (${widget.finalLong},  ${widget.finalLat})'),
                  )
                ],
              );
            }
          },

        )
    );
  }
}
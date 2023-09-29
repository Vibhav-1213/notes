import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller.dart';
import 'Home.dart';
import 'dart:developer';

class RedirectFilePage extends StatefulWidget {
  //const RedirectFilePage(Text text, {super.key});

  @override
  State<RedirectFilePage> createState() => _FilePageState();
}

class _FilePageState extends State<RedirectFilePage> {
  TextEditingController title1 = new TextEditingController();
  TextEditingController note1 = new TextEditingController();
  TextEditingController noteedit = TextEditingController();
  TextEditingController contedit = TextEditingController();
  TextEditingController date2 = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: CustomScrollView(
        slivers: [
          SliverAppBar.medium(
            backgroundColor: Colors.black,
            expandedHeight: 85,
            leading: IconButton(onPressed: (){
              Navigator.pop(context);
            },icon: Icon(Icons.arrow_back_ios_new_rounded,size: 26.5,),),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            actions: [
              Padding(
                padding: EdgeInsets.only(right:17,top: 0),
                child: IconButton(onPressed: () async {
                  await FirebaseFirestore.instance.collection("notes").doc(Get.arguments['docid'].toString()).update({
                    "Title": noteedit.text.trim(),
                    "Content": contedit.text.trim(),
                  }).then((value) => {
                    log("Data Updated "),
                  });
                  //Map <String,dynamic> data = {"Title":noteedit.text,"Content":contedit.text};
                  Navigator.pop(context);
                }, icon: ImageIcon(AssetImage('images/tick.png'),size: 25,)))
            ],
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:0,left: 15,right: 20,bottom: 10),
                  child: TextField(
                    maxLines: null,
                    controller: noteedit..text = "${Get.arguments["Title"].toString()}",
                    decoration: InputDecoration(
                      hintText: "Title",
                      hintStyle: TextStyle(color: Colors.white,fontSize: 34)
                    ),
                    style: TextStyle(color: Colors.white,fontSize: 34),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(top:0,left: 22.5,right: 20,bottom: 10),
                  child: TextField(
                    maxLines: null,
                    controller: contedit..text = "${Get.arguments["Content"].toString()}",
                    decoration: InputDecoration(
                      hintText: "Note",
                      hintStyle: TextStyle(color: Colors.white,fontSize: 20)
                    ),
                    style: TextStyle(color: Colors.white,fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 60.0,right: 60,top: 250),
              child: TextButton.icon(
                icon: Image.asset('images/delete.png',
                height: 25,
                width: 25,),
                onPressed: () async {
                  await FirebaseFirestore.instance.collection("notes").doc(Get.arguments['docid'].toString()).delete();
                  Navigator.pop(context);
                },
              label: Text("Delete note",style: TextStyle(fontSize: 20,color: Colors.red),)),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(top: 100),
              child: Align(
                alignment: Alignment.center,
                child: Text("Posted at : " + "${Get.arguments["Date"].toString()}",style: TextStyle(color: Colors.grey),)),
            )
          ),
        ],
      ),
    );
  }
}

import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/controller.dart';

class FilePage extends StatefulWidget {
  const FilePage({super.key});

  @override
  State<FilePage> createState() => _FilePageState();
}

class _FilePageState extends State<FilePage> {
  TextEditingController title1 = new TextEditingController();
  TextEditingController note1 = new TextEditingController();
  TextEditingController date1 = new TextEditingController();
  bool? isChecked = false;
  DateTime _dateTime = DateTime.now();
  void _showDatePicker(){
    showDatePicker(
      context: context, 
      initialDate: DateTime.now(), 
      firstDate: DateTime(2000), 
      lastDate: DateTime(2025)).then(
        (value) {
          setState(() {
            _dateTime = value!;
          });
        }
        );
  }
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
                child: IconButton(onPressed: (){
                  Map <String,dynamic> data = {"Title":title1.text,"Content":note1.text,"Date":_dateTime.toString()};
                  FirebaseFirestore.instance.collection("notes").add(data);
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
                    controller: title1,
                    maxLines: null,
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
                    controller: note1,
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
              padding: EdgeInsets.only(left: 20,right: 20,top: 100),
              child: ElevatedButton(
                onPressed: _showDatePicker, 
                child: Text("Choose Date",style: TextStyle(color: Colors.white,fontSize: 20),),),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: EdgeInsets.only(left: 20,right: 20,top: 250),
              child: Align(
                alignment: Alignment.center,
                child: Text("Time : " + _dateTime.toString(),style: TextStyle(color: Colors.grey,fontSize: 12),))),
          )
        ],
      ),
    );
  }
}

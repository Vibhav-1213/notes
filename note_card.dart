import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

Widget noteCard (Function()? onTap, QueryDocumentSnapshot doc){
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: EdgeInsets.all(8),
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: Color.fromARGB(255, 5, 46, 101),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc["Title"],
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            doc["date"],
            style: TextStyle(color: Colors.white),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            doc["Content"],
            style: TextStyle(color: Colors.white),
            overflow: TextOverflow.ellipsis,
          )
        ],
      ),
    ),
  );
}
import 'package:flutter/material.dart';
import 'package:notes/Home.dart';

class EntryPage extends StatelessWidget {
  const EntryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/coverpage.png'),fit: BoxFit.cover)
        ),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(bottom: 32.5),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Color.fromARGB(255, 10, 137, 139),
                fixedSize: Size(230, 70)
              ),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(builder: (context) => HomePage()));
              },
              child: Text("Take Notes",style: TextStyle(color: Colors.white,fontSize: 30),)),
          ),
        ),
      ),
    );
  }
}
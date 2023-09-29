import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notes/file.dart';
import 'package:notes/redirectfile.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {
  String name ="";
  List<Map<String, dynamic>> firestoreData = [];
  @override
  Widget build(BuildContext context) {
    final _userStream = FirebaseFirestore.instance.collection('notes').snapshots();
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [CustomScrollView(
          shrinkWrap: true,
              slivers: [
                SliverAppBar.large(
                  flexibleSpace: FlexibleSpaceBar(
                    title: Text('Notes',style: TextStyle(color: Color.fromARGB(255, 255, 255, 255),fontSize: 27),),
                    background: ClipRRect(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(20),bottomRight: Radius.circular(20)),
                      child: Image.asset('images/dblue.jpeg',)),
                  ),
                  leading:  IconButton(onPressed: (){
                    Navigator.pop(context);
                  }, icon: Icon(Icons.arrow_back_ios_new_rounded,size: 27,color: Colors.white,)),
                  expandedHeight: 189,
                  backgroundColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  

                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.only(left: 8.0, right: 8.0, top: 30),
                    child: TextField(
                      style: const TextStyle(fontSize: 16, color: Colors.white),
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                        hintText: "Search notes..",
                        hintStyle: const TextStyle(color: Colors.grey),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.grey,
                        ),
                        fillColor: Colors.grey.shade800,
                        filled: true, 
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.transparent), 
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(30),
                          borderSide: const BorderSide(color: Colors.transparent)
                        ),
                      ),
                      onChanged: (value){
                        setState(() {
                          name = value;
                        });
                      },
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.only(top: 0),
                    child: Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20)),
                        child: Container(
                          // decoration: BoxDecoration(
                          //   image: DecorationImage(image: AssetImage('images/blue.jpeg'),fit: BoxFit.cover)
                          // ),
                            //height: 10000,
                            child: StreamBuilder(
                              stream: _userStream,
                              builder: (context, snapshot){
                                var docs = snapshot.data!.docs;
                                if (snapshot.hasError){
                                  return const Text('Connection Error');
                                }
                                if (snapshot.connectionState == ConnectionState.waiting){
                                  return const Text('Loading....');
                                }
                                firestoreData.clear();
                                snapshot.data!.docs.forEach((document) {
                                  firestoreData.add(document.data() as Map<String, dynamic>);
                                 });
                                return GridView.builder(
                                  shrinkWrap: true,
                                  itemCount: docs.length,
                                  physics: BouncingScrollPhysics(),
                                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    crossAxisSpacing: 6.0,
                                    mainAxisSpacing: 6.0,
                                    ), 
                                  itemBuilder: (_,index){
                                    var title3 = docs[index]['Title'];
                                    var title4 = docs[index]['Content'];
                                    var docid = snapshot.data!.docs[index].id;
                                    var date = docs[index]["Date"];
                                    if (firestoreData.isEmpty){
                                    return GestureDetector(
                                      onTap: (){
                                        Get.to(() => RedirectFilePage(),arguments: {"Title":title3,"Content":title4,"docid":docid,"Date":date});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 1.5,right:1.5,bottom: 3 ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: Color.fromARGB(255, 2, 59, 106),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(docs[index]['Title'],
                                                  style: TextStyle(color: Colors.white,fontSize: 23),),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                Expanded(
                                                  child: 
                                                  Text('${docs[index]['Content']}',
                                                  style: TextStyle(color: Colors.white),
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                // Align(
                                                //   alignment: Alignment(1,5),
                                                //   child: Text(docs[index]['date'],
                                                //     style: TextStyle(color: Colors.white),),
                                                // ),
                                              ],
                                            ),
                                          )
                                        ),
                                      ),
                                    );
                                    }
                                    if (docs[index]["Title"].toString().toLowerCase().startsWith(name.toLowerCase())){
                                      return GestureDetector(
                                      onTap: (){
                                        Get.to(() => RedirectFilePage(),arguments: {"Title":title3,"Content":title4,"docid":docid,"Date":date});
                                      },
                                      child: Padding(
                                        padding: EdgeInsets.only(left: 0.5,right:0.5,bottom: 1 ),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(20.0),
                                            color: Color.fromARGB(255, 2, 59, 106),
                                          ),
                                          child: Padding(
                                            padding: EdgeInsets.all(15.0),
                                            child: Column(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              children: [
                                                Text(docs[index]['Title'],
                                                  style: TextStyle(color: Colors.white,fontSize: 23),),
                                                  SizedBox(
                                                    height: 15,
                                                  ),
                                                Expanded(
                                                  child: 
                                                  Text('${docs[index]['Content']}',
                                                  style: TextStyle(color: Colors.white),
                                                  maxLines: 5,
                                                  overflow: TextOverflow.ellipsis,
                                                  ),
                                                ), 
                                                Text('${docs[index]["Date"]}',style: TextStyle(color: Colors.grey,fontSize: 8),)
                                                // Align(
                                                //   alignment: Alignment(1,5),
                                                //   child: Text(docs[index]['date'],
                                                //     style: TextStyle(color: Colors.white),),
                                                // ),
                                              ],
                                            ),
                                          )
                                        ),
                                      ),
                                    );
                                    }  
                                  }
                                );
                                
                                
                              },
                            )
                          ),
                      ),
                      ),
                  ),
),
              ],
            ),
            Positioned(
              bottom: 20,
              right: 15,
              child: FloatingActionButton(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)
                ),
                elevation: 8,
                backgroundColor: Color.fromARGB(255, 2, 36, 64),
                onPressed: (){
                  Navigator.push(context, MaterialPageRoute(builder: (context) => FilePage()));
                },
                child: ImageIcon(AssetImage('images/note.png'),size: 34,),  
              ),
            ),
          ],
        ),  
    );
  }
}

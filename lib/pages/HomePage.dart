//import 'package:firebase_app_web/Service/Auth_Service.dart';
// import 'package:firebase_app_web/main.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/custom/TodoCard.dart';
import 'package:to_do_app/pages/AddTodo.dart';
import 'package:to_do_app/pages/Profile.dart';
import 'package:to_do_app/pages/ViewData.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream=
      FirebaseFirestore.instance.collection("Todo").snapshots();
  List<Select> selected = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: const Text(
          "Today's Schedule",
          style: TextStyle(
              fontSize: 34,
              fontWeight: FontWeight.bold,
              color: Colors.black87),
        ),
        actions: const [
          CircleAvatar(
            backgroundImage: AssetImage("assets/profile.jpg"),
          ),
          SizedBox(
            width: 25,
          ),
        ],
        bottom: PreferredSize(
          child: Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Senin, 20",
                    style: TextStyle(
                        fontSize: 33,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87),
                  ),
                  IconButton(
                    onPressed: (){
                        var instance = FirebaseFirestore.instance
                            .collection("Todo");
                        for(int i =0; i<selected.length; i++){
                          if (selected[i].checkValue) {
                            instance.doc(selected[i].id).delete();
                          }
                        }
                    },
                    icon: Icon(
                      Icons.delete,
                      color: Colors.red,
                      size: 28,
                    ),
                  ),
                ],
              ),
            ),
          ),
          preferredSize: const Size.fromHeight(35),
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.white,
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              size: 32,
              color: Colors.black87,
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AddTodoPage(),
                  ),
                );
              },
              child: Container(
                height: 52,
                width: 52,
                decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(colors: [
                      Colors.yellowAccent,
                      Colors.orange
                    ])),
                child: Icon(
                  Icons.add,
                  size: 32,
                  color: Colors.black87,
                ),
              ),
            ),
            label: '',
          ),
          BottomNavigationBarItem(
            icon: InkWell(
              onTap: (){
                Navigator.push(context, 
                    MaterialPageRoute(builder: (builder) => Profile()));
              },
              child: Icon(
                Icons.settings,
                size: 32,
                color: Colors.black87,
              ),
            ),
            label: '',
          ),
        ],
      ),
      body:
      StreamBuilder(
          stream: _stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: snapshot.data!.docs.length,
                itemBuilder: (context, index){
                  IconData iconData;
                  Color iconColor;
                  Map<String, dynamic> document =
                  snapshot.data!.docs[index].data() as Map<String, dynamic>;
                  switch(document["Category"])
                  {
                    case "Work"://sesuai field
                      iconData = Icons.work;
                      iconColor = Colors.red;
                      break;
                    case "WorkOut":
                      iconData = Icons.sports_gymnastics;
                      iconColor = Colors.teal;
                      break;
                    case "Food":
                      iconData = Icons.food_bank_rounded;
                      iconColor = Colors.blueGrey;
                      break;
                    case "Design":
                      iconData = Icons.draw;
                      iconColor = Colors.purple;
                      break;
                    default:
                      iconData = Icons.work;
                      iconColor = Colors.red;
                      break;
                  }
                  selected.add(Select(id:snapshot.data!.docs[index].id,checkValue: false ));
                  return InkWell(
                    onTap: () {
                      Navigator.push(context,
                          MaterialPageRoute(
                              builder: (builder) => ViewData(
                                document: document,
                                id : snapshot.data!.docs[index].id,
                              ),
                          ),
                      );
                    },
                    child: TodoCard(
                      title: document["title"]==null
                          ? "Hey There"
                          : document["title"],//orgnya kyknya typo jd ttile
                      check: selected[index].checkValue,
                      iconBgColor: Colors.white,
                      iconColor: iconColor,
                      iconData: iconData,
                      time: "5 AM",
                      index: index,
                      onChange: onChange,
                    ),
                  );
                },
            );
          }
      ),
    );
  }
  void onChange(int index){
    setState(() {
      selected[index].checkValue = !selected[index].checkValue;
    });
  }
}

class Select {
  String id;
  bool checkValue = false;
  Select({required this.id, required this.checkValue});
}
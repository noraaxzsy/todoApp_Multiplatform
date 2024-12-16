import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do_app/Service/todo_provider.dart';
import 'package:to_do_app/custom/TodoCard.dart';
import 'package:to_do_app/pages/AddTodo.dart';
import 'package:to_do_app/pages/Profile.dart';
import 'package:to_do_app/pages/ViewData.dart';
import 'package:intl/intl.dart';


class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final Stream<QuerySnapshot> _stream=
      FirebaseFirestore.instance.collection("Todo").snapshots();
  List<Select> selected = [];

  @override
  Widget build(BuildContext context) {
    String? _email = _auth.currentUser!.email;
    final todoStream = Provider.of<TodoProvider>(context).todosStream;
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: Colors.white,
          title: Padding(
            padding: const EdgeInsets.only(top: 10, left: 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 0.0),
                  child: Text(
                    " Halo Aisy! ✨",
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                        height: 1.2,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: Text(" Yuk selesaikan tugasmu!",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                          color: Colors.black87,
                          height: 1.2,
                      )),
                )
              ],
            ),
          ),

          actions: const [
            Padding(
              padding: EdgeInsets.only(right: 16.0), // Menambahkan jarak dari tepi
              child: CircleAvatar(
                radius: 30, // Ubah ukuran lingkaran dengan menyesuaikan nilai radius
                backgroundImage: AssetImage("assets/profile.jpg"),
              ),
            ),
            SizedBox(
              width: 10,
            ),
          ],
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
          stream: todoStream,
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
                  // Ambil waktu dari dokumen (createdAt atau updatedAt)
                  Timestamp? timestamp = document["updatedAt"] ?? document["createdAt"];
                  String formattedTime;

                  if (timestamp != null) {
                    DateTime dateTime = timestamp.toDate(); // Ubah Timestamp ke DateTime
                    formattedTime = DateFormat('hh:mm a').format(dateTime); // Format waktu
                  } else {
                    DateTime currentTime = DateTime.now(); // Waktu sekarang
                    formattedTime = DateFormat('hh:mm a').format(currentTime); // Gunakan waktu sekarang
                  }

                  switch(document["category"])
                  {
                    case "Belajar"://sesuai field
                      iconData = Icons.work;
                      iconColor = Colors.red;
                      break;
                    case "Olahraga":
                      iconData = Icons.sports_gymnastics;
                      iconColor = Colors.teal;
                      break;
                    case "Hobi":
                      iconData = Icons.directions_bike_rounded;
                      iconColor = Colors.blueGrey;
                      break;
                    case "Tugas":
                      iconData = Icons.draw;
                      iconColor = Colors.purple;
                      break;
                    case "Main":
                      iconData = Icons.videogame_asset_rounded;
                      iconColor = Colors.teal;
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
                          : document["title"],
                      check: selected[index].checkValue,
                      iconBgColor: Colors.white,
                      iconColor: iconColor,
                      iconData: iconData,
                      time: formattedTime,
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
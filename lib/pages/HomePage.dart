//import 'package:firebase_app_web/Service/Auth_Service.dart';
// import 'package:firebase_app_web/main.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/custom/TodoCard.dart';
import 'package:to_do_app/pages/AddTodo.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // AuthClass authClass = AuthClass();
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
            backgroundImage: AssetImage("assets/profil.jpg"),
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
              child: Text(
                "Senin, 20",
                style: TextStyle(
                    fontSize: 33,
                    fontWeight: FontWeight.w600,
                    color: Colors.black87),
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
            icon: Icon(
              Icons.settings,
              size: 32,
              color: Colors.black87,
            ),
            label: '',
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        children: const [
          TodoCard(
            title: "Bangun",
            check: true,
            iconBgColor: Colors.white,
            iconColor: Color.fromARGB(221, 255, 187, 51),
            iconData: Icons.alarm,
            time: "5 AM",
          ),
          SizedBox(
            height: 10,
          ),
          TodoCard(
            title: "Jalan Pagi",
            check: true,
            iconBgColor: Color.fromARGB(255, 253, 92, 181),
            iconColor: Colors.white,
            iconData: Icons.run_circle,
            time: "6 AM",
          ),
          SizedBox(
            height: 10,
          ),
          TodoCard(
            title: "Sarapan",
            check: false,
            iconBgColor: Color.fromARGB(255, 250, 51, 51),
            iconColor: Colors.white,
            iconData: Icons.food_bank,
            time: "7 AM",
          ),
          SizedBox(
            height: 10,
          ),
          TodoCard(
            title: "Kerja",
            check: false,
            iconBgColor: Color.fromARGB(255, 207, 41, 182),
            iconColor: Colors.white,
            iconData: Icons.work,
            time: "8 AM",
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
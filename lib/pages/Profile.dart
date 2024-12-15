import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:to_do_app/pages/login_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/pages/HomePage.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}): super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker picker = ImagePicker();
  XFile? image;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center, // Elemen mulai dari kiri
            children: [
              // Baris untuk tombol kembali dengan teks
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (builder) => HomePage()),
                      );
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                  Text(
                    "Pengaturan",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20), // Spasi di bawah baris kembali
              CircleAvatar(
                radius: 60,
                backgroundImage: getImage(),
              ),
              SizedBox(height: 30),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(),
                  IconButton(
                    onPressed: () async {
                      final pickedImage =
                      await picker.pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        setState(() {
                          image = pickedImage;
                        });
                      }
                    },
                    icon: Icon(
                      Icons.add_a_photo,
                      color: Color(0xffF46036),
                      size: 30,
                    ),
                  )
                ],
              ),
              SizedBox(height: 15),
              Container(
                height: 45,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  gradient: LinearGradient(
                    colors: [
                      Color(0xff8C271E),
                      Color(0xffA52422),
                    ],
                  ),
                ),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  onPressed: () {
                    _auth.signOut();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => LoginScreen(),
                      ),
                    );
                  },
                  child: Text(
                    "Keluar Akun",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }


  ImageProvider getImage() {
    if (image != null && File(image!.path).existsSync()) {
      return FileImage(File(image!.path));
    }
    return const AssetImage("assets/profile.jpg");
  }

  Widget button() {
    return InkWell(
        onTap: () {},
        child: Container(
          height: 40,
          width: MediaQuery.of (context).size.width / 2 ,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            gradient: LinearGradient(
              colors: [
                Colors.yellowAccent,
                Colors.orange,
              ],
            ),
          ),
          child: Center(
            child: Text(
              "Simpan Foto",
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
    );
  }
}
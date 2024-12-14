import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}): super(key: key);

  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final ImagePicker picker = ImagePicker();
  XFile? image;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: MediaQuery
              .of(context)
              .size
              .width,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 60,
                backgroundImage: getImage(),
              ),
              SizedBox(height: 30,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  button(),
                  IconButton(onPressed: () async {
                    final pickedImage =
                    await picker.pickImage(source: ImageSource.gallery);
                    if (pickedImage != null) {
                      setState(() {
                        image = pickedImage;
                      });
                    }
                  }, icon: Icon(
                    Icons.add_a_photo,
                    color: Colors.teal,
                    size: 30,))
                ],
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
                Color(0xff8a32f1),
                Color(0xffad32f9),
              ],
            ),
          ),
          child: Center(
            child: Text(
              "Upload",
              style: TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        )
    );
  }
}
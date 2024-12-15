import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/pages/HomePage.dart';

class ViewData extends StatefulWidget {
  const ViewData({Key? key, required this.document, required this.id}): super(key: key);
  final  Map<String, dynamic> document;
  final String id;

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  String type = "";
  String category = "";
  bool edit = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    String title = widget.document["title"]==null
        ?"Hey there"
        : widget.document["title"];
    titleController = TextEditingController(text: title);
    descriptionController = TextEditingController(text: widget.document["description"]);
    type = widget.document["task"];
    category = widget.document["category"];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
            Colors.white,
            Colors.white70,
          ]),
        ),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: (){
                      Navigator.pop(context);
                    },
                    icon: Icon(
                      CupertinoIcons.arrow_left,
                      color: Colors.black,
                      size: 28,
                    ),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: (){
                          FirebaseFirestore.instance
                              .collection("Todo")
                              .doc(widget.id)
                              .delete()
                              .then((value) {
                                Navigator.pop(context);
                          });
                        },
                        icon: Icon(
                          Icons.delete,
                          color: Colors.red,
                          size: 28,
                        ),
                      ),
                      IconButton(
                        onPressed: (){
                          setState(() {
                            edit = !edit;
                          });
                        },
                        icon: Icon(
                          Icons.edit,
                          color: edit?Colors.green: Colors.black,
                          size: 28,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Padding(
                padding:
                const EdgeInsets.symmetric (horizontal: 25, vertical: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      edit?"Ubah":"Lihat",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    Text(
                      "Aktivitas Saya",
                      style: TextStyle(
                        fontSize: 28,
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 2,
                      ),
                    ),
                    SizedBox(height: 15,
                    ),
                    label("Judul Aktivitas"),
                    SizedBox(
                      height: 8,
                    ),
                    title(),
                    SizedBox(
                      height: 15,
                    ),
                    label("Tipe Aktivitas"),
                    SizedBox(
                      height: 8,
                    ),
                    Row(
                      children: [
                        taskSelect("Penting", 0xffA71D31),
                        SizedBox(
                          width: 20,
                        ),
                        taskSelect("Biasa", 0xff7067CF),
                      ],
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    label("Deskripsi"),
                    SizedBox(
                      height: 8,
                    ),
                    description(),
                    SizedBox(
                      height: 15,
                    ),
                    label("Kategori"),
                    SizedBox(
                      height: 8,
                    ),
                    Wrap(
                      alignment: WrapAlignment.start,
                      crossAxisAlignment: WrapCrossAlignment.start,
                      runSpacing: 10,
                      children: [
                        categorySelect("Belajar", 0xff51355A),
                        SizedBox(
                          width: 15,
                        ),
                        categorySelect("Tugas", 0xff1B998B),
                        SizedBox(
                          width: 15,
                        ),
                        categorySelect("Olahraga", 0xff1768AC),
                        SizedBox(
                          width: 15,
                        ),
                        categorySelect("Hobi", 0xffB91372),
                        SizedBox(
                          width: 15,
                        ),categorySelect("Main", 0xff058C42),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    edit?button():Container(),
                    SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),),
    );
  }

  Widget button() {
    return InkWell(
        onTap: () {
          FirebaseFirestore.instance.collection("Todo").doc(widget.id).update(
              {"title": titleController.text, "task": type, "category" : category, "description" : descriptionController.text});
          Navigator.pop(context);
        },
        child: Container(
          height: 56,
          width: MediaQuery.of (context).size.width,
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
              "Ubah Aktivitas",
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

  Widget description() {
    return Container(
      height: 150,
      width: MediaQuery.of (context).size.width,
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextFormField(
        controller: descriptionController,
        enabled: edit,
        style: TextStyle(
          color: Colors.black,
          fontSize: 17,
        ),
        maxLines: null,
        decoration: InputDecoration(
          border: InputBorder.none,
          hintText: "Deskripsi",
          hintStyle: TextStyle(
            color: Colors.grey,
            fontWeight: FontWeight.normal,
            fontSize: 17,
          ),
          contentPadding: EdgeInsets.only(
            left: 20,
            right: 20,
          ),
        ),
      ),
    );
  }

  Widget taskSelect(String label, int color) {
    return InkWell(
      onTap: edit?(){
        setState(() {
          type = label;
        });
      }: null,
      child: Chip(
        backgroundColor: type==label? Colors.yellowAccent : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: type==label? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget categorySelect(String label, int color) {
    return InkWell(
      onTap: edit?(){
        setState(() {
          category = label;
        });
      }:null,
      child: Chip(
        backgroundColor: category==label? Colors.yellowAccent : Color(color),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
        ),
        label: Text(
          label,
          style: TextStyle(
            color: category==label? Colors.black : Colors.white,
            fontSize: 15,
            fontWeight: FontWeight.w600,
          ),
        ),
        labelPadding: EdgeInsets.symmetric(
          horizontal: 17,
          vertical: 3.8,
        ),
      ),
    );
  }

  Widget title() {
    return Container(
      height: 55,
      width: MediaQuery.of (context).size.width,
      decoration: BoxDecoration(
        color: Color(0xffD9D9D9),
        borderRadius: BorderRadius.circular(15),
      ),child: Center(
        child: TextFormField(
          controller: titleController,
          enabled: edit,
          style: TextStyle(
            color: Colors.black,
            fontSize: 17,
          ),
          decoration: InputDecoration(
            border: InputBorder.none,
            hintText: "Judul Aktivitas",
            hintStyle: TextStyle(
              color: Colors.grey,
              fontSize: 17,
              fontWeight: FontWeight.normal,
            ),
            contentPadding: EdgeInsets.only(
              left: 20,
              right: 20,
              bottom: 0,
            ),
          ),
        )
    ),
    );
  }

  Widget label(String label){
    return Text(
      label,
      style: TextStyle(
          color: Colors.black,
          fontWeight: FontWeight.w600,
          fontSize: 16.5,
          letterSpacing: 0.2
      ),
    );
  }
}


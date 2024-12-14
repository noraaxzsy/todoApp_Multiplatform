import 'package:flutter/material.dart';

class TodoCard extends StatelessWidget {
  const TodoCard({
    Key? key,
    required this.title,
    required this.iconData,
    required this.iconColor,
    required this.time,
    required this.check,
    required this.iconBgColor,
    required this.onChange,
    required this.index}
      ) :super(key: key);

  //we need to assign all value dinamis

  final String title;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final bool check;
  final Color iconBgColor;
  final Function onChange;
  final int index;


  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        child: Row(
          children: [
            Theme(
              child: Transform.scale(
                scale: 1.5,
                child: Checkbox(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(5)
                  ),
                  activeColor: Color(0xFF55E192),
                  checkColor: Color(0xff0e3e26),
                  value: check,
                  onChanged: (value) {
                    onChange(index);
                  },
                ),
              ),
              data: ThemeData(
                primarySwatch:Colors.green,
                unselectedWidgetColor: Color.fromARGB(255, 2, 4, 10),
              ),
            ),

            Expanded(
              child: Container(
                height: 75,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)
                  ),
                  color: Color(0xFFFFB100),//warna kolom aktivitas
                  child: Row(
                    children: [
                      SizedBox(width: 15,
                      ),
                      Container(
                        height: 33,
                        width: 36,
                        decoration: BoxDecoration(
                            color: iconBgColor,
                            borderRadius: BorderRadius.circular(8)
                        ),
                        child: Icon(iconData, color: iconColor,),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: Text(
                          title,
                          style: TextStyle(
                              fontSize: 18,
                              letterSpacing: 1,
                              fontWeight: FontWeight.w500,
                              color: Colors.black87
                          ),
                        ),
                      ),
                      Text(
                        time,
                        style: TextStyle(
                            fontSize: 15,
                            color: Colors.black87
                        ),
                      ),
                      SizedBox(
                        width: 20,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        )
    );
  }
}
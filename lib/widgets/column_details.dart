import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
class ColumnDetails extends StatelessWidget {
  final String text;
  final String labelText;
  ColumnDetails(
    this.text,
    this.labelText,
 ) ;

  @override
  Widget build(BuildContext context) {
    return  Column(
     crossAxisAlignment: CrossAxisAlignment.start,
     mainAxisAlignment: MainAxisAlignment.start,
     children: [
       Container(
         margin: EdgeInsets.only(left: 0, top: 20, bottom: 5),
         child: Text(labelText,
             textAlign: TextAlign.left,
             style: TextStyle(
                 color: Colors.grey,
                 // fontWeight: FontWeight.bold,
                 fontSize: 20)),
       ),
       Text(text,
           textAlign: TextAlign.left,
           style: TextStyle(color: Colors.black, fontSize: 20)),
       Divider(
         color: Colors.black,
         height: 20,
       ),

     ],
   );
  }

}

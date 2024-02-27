import 'package:flutter/material.dart';


List sweetSayings=[
  "Your presence, lights up the whole room",
  "We admire, Your strong personality",
  "wtf",
  "wana",
  "gana",
  "kala jamun",
];

class CustomAppBar extends StatelessWidget {

  // const CustomAppBar ({super.key});
  Function? onTap;
  int? quoteInd;
  CustomAppBar({this.onTap, this.quoteInd});

  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        onTap!();
      },
      child: Container(
      child: Text(
      sweetSayings[quoteInd !], 
      style: TextStyle(
        fontSize: 30,
        ),
      ),
    ),
    );
  }
}
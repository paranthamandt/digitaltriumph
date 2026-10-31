import 'package:flutter/material.dart';

import 'appcolor.dart';
class Textstyle {
 static TextStyle heading=TextStyle(
  fontFamily: "Inter",
   fontSize: 32,fontWeight: FontWeight.bold,
 );
 static TextStyle title=TextStyle(
     fontFamily: "Inter",
   fontSize: 24,fontWeight: FontWeight.bold
 );
 static TextStyle body=TextStyle(
     fontFamily: "Inter",
   fontSize: 18,fontWeight: FontWeight.bold
 );
 static TextStyle body1=TextStyle(
     fontFamily: "Inter",
     fontSize: 16,fontWeight: FontWeight.bold
 );
 static TextStyle body2=TextStyle(
     fontFamily: "Inter",
     fontSize: 11,fontWeight: FontWeight.bold
 );
 static TextStyle body3=TextStyle(
     fontFamily: "Inter",
     fontSize: 8,fontWeight: FontWeight.bold
 );
 static TextStyle cardTitle = TextStyle(
  fontFamily: "Inter",
  fontSize: 13,
  fontWeight: FontWeight.w700,
 );

 static TextStyle cardSubtitle = TextStyle(
  fontFamily: "Inter",
  fontSize: 11,
  fontWeight: FontWeight.w400,
  color: Colors.grey.shade700,
 );

 static TextStyle chip = TextStyle(
  fontFamily: "Inter",
  fontSize: 10,
  fontWeight: FontWeight.w600,
 );

 static TextStyle view=TextStyle(
     fontFamily: "Inter",
     fontSize: 16,fontWeight: FontWeight.bold,
  color: Appcolor.backgroundColor

 );



}



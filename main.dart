import 'package:flutter/material.dart';
import 'country_data.dart';

void main()=>runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home:CountryData(),
      theme: ThemeData(       
       fontFamily: "GoogleSans",
       scaffoldBackgroundColor: Color.fromARGB(255, 19, 28, 26)
     ),
      debugShowCheckedModeBanner: false,
    );
  }
}



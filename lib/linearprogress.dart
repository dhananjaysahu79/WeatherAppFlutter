import 'package:flutter/material.dart';
import 'dart:async';

class LinearProgressBar extends StatefulWidget {
  var  value;
  var parameter;
  var name;
  LinearProgressBar(this.value,this.parameter,this.name);
  @override

  _LinearProgressBarState createState() => _LinearProgressBarState(this.value,this.parameter,this.name);
}

class _LinearProgressBarState extends State<LinearProgressBar> {
    var value;
    var width=4.0;
    var parameter;
    var name;
  _LinearProgressBarState(this.value,this.parameter,this.name);
  @override
  void initState() { 
    super.initState();
    returnwidth();
  }

  Future returnwidth() async {
   await Future.delayed(const Duration(microseconds: 500),(){
   setState(() {
     width=(value==null)?4.0:value*4.toDouble();
     
   });
   });
   
 }
  @override
  Widget build(BuildContext context) {
    return Row(
      
                  children: <Widget>[
                    Padding(padding: EdgeInsets.only(left: 22),),
                    Container(
                      height: MediaQuery.of(context).size.height/35,
                      width: MediaQuery.of(context).size.width/4,
                      decoration: BoxDecoration(
                        
                        gradient: LinearGradient(
                           stops: [0.0,0.9],
                         colors: [Color.fromARGB(210, 19, 206, 206),Color.fromARGB(210, 76, 240, 207),]
                    ),
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(5),
                          bottomLeft: Radius.circular(5)
                          )
                      ),
                      child: Center(child: Text(name,
                      style: TextStyle(fontSize: MediaQuery.of(context).size.height/50),
                      )),
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height/35,
                      width: MediaQuery.of(context).size.width/100,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.only(
                          
                          )
                      ),
                    ),
                    AnimatedContainer(
                      height: MediaQuery.of(context).size.height/35,
                      width: width,
                      decoration: BoxDecoration(
                       // color: Colors.red[700],
                       gradient: LinearGradient(
                           stops: [0.0,0.9],
                         colors: [Color.fromARGB(210, 19, 206, 206),Color.fromARGB(210, 76, 240, 207),]
                    ),
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(5),
                          bottomRight: Radius.circular(5)
                          )
                      ), duration: Duration(seconds: 5),curve: Curves.fastOutSlowIn,
                    ),
                    Padding(padding: EdgeInsets.only(left: 8),),
                    Text(parameter==null?"null":parameter.toString(),style: TextStyle(color: Colors.white54,fontSize: MediaQuery.of(context).size.height/45),)
                  ],
                );
  }
}
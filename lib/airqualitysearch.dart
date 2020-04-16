import 'package:flutter/material.dart';
import 'dart:convert';
import 'dart:async';
import 'package:http/http.dart'as http;
import 'package:progressbar/linearprogress.dart';
import 'progress.dart';
import 'package:auto_size_text/auto_size_text.dart';
class AqiSearch extends StatefulWidget {
   var longitude,latitude,location;
   AqiSearch(this.longitude,this.latitude,this.location);

  @override
   State<AqiSearch> createState() {return _AqiSearchState(this.longitude,this.latitude,this.location);}
}

class _AqiSearchState extends State<AqiSearch> {
  var latitude;
  var longitude;
  var conditions;
  var location;
  var co;
  var pm10;
  var so2;
  var o3;
  var pm25;
  var no2;
  var width1=4.0;
  var width2=4.0;
  var width3=4.0;
  _AqiSearchState(this.longitude,this.latitude,this.location);
  var decodedJson3;
  var aqi;
  
  @override
  void initState() { 
    super.initState();
     getAqi();
  }
  
   
   Future getAqi() async{
      var response= await http.get(Uri.encodeFull("https://api.waqi.info/feed/geo:$latitude;$longitude/?token=4beb9d4d7424de855a8a6c4b436bffdbf97b1ef7"),
       headers: {"results":"application/json"}
      );
      decodedJson3 = jsonDecode(response.body);
      setState(() {
        location=location.toUpperCase();
        aqi=decodedJson3["data"]["aqi"];
        try{
        co=decodedJson3["data"]["iaqi"]["co"]["v"];        
        }catch(Exception )  {}
        try{
         pm10=decodedJson3["data"]["iaqi"]["pm10"]["v"];
        }catch(Exception){}
         try{
          pm25=decodedJson3["data"]["iaqi"]["pm25"]["v"];
        }catch(Exception){}
         try{
         no2=decodedJson3["data"]["iaqi"]["no2"]["v"]; 
        }catch(Exception){}
         try{
         so2=decodedJson3["data"]["iaqi"]["so2"]["v"]; 
        }catch(Exception){}  
       
      });
     
   }
   
   calCondition(){
     if(aqi<=50){
       conditions="GOOD";
     }
     else if(aqi>=51&&aqi<=100){
       conditions="MODERATE";
     }
     else if(aqi<=101&&aqi>=150){
       conditions="NOT GOOD";
     }
     else if(aqi>=151&&aqi<=200){
       conditions="UNHEALTHY";
     }
     else if(aqi>=201&&aqi<=300){
       conditions="VERY\nUNHEALTHY";
     }
     else{
       conditions="HAZARDOUS";
     }
     return conditions;
    
   }
   
  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: decodedJson3==null?Center(child: CircularProgressIndicator()):Column(
           crossAxisAlignment: CrossAxisAlignment.center,
           mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Expanded(
               flex: 2,
                child: Column(
                  children: <Widget>[
               Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/35)),                                         
               Container (
                height: MediaQuery.of(context).size.height/3,
                width: MediaQuery.of(context).size.width/1.09,
                child: Stack(         
                  alignment: Alignment.center,        
                  children: <Widget>[
                    ProgressBar((aqi/5).round()),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                    AutoSizeText(
                     aqi.toString(),
                     minFontSize: 40,
                     maxFontSize: 40,
                     textScaleFactor: 0.8,
                    style: TextStyle(color: Colors.white),),
                    AutoSizeText(calCondition(),
                      minFontSize: 18,
                      maxFontSize: 18,
                     textScaleFactor: 0.8,
                    textAlign: TextAlign.center,style: TextStyle(color: Colors.white,letterSpacing: 1),),
                    ],)
                    
                  ],
                ),
              ) ,
               Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45)),  
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: MediaQuery.of(context).size.height/17,
                    width:MediaQuery.of(context).size.width/1.2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(5)) ,
                      gradient: LinearGradient(
                           stops: [0.0,0.9],
                         colors: [Color.fromARGB(210, 19, 206, 206),Color.fromARGB(210, 76, 240, 207),]
                    ),),
                    child: Center(child: AutoSizeText("${location}-AQI",
                      minFontSize: 20,
                      maxFontSize: 20,
                     textScaleFactor: 0.8,
                    style: TextStyle(color: Colors.black,letterSpacing: 2,fontWeight: FontWeight.bold),)),
                  ),
                 
              ],),
                  ],
                ),
              ),
              Expanded(
               //flex: 1,
                child: Column(
                  children: <Widget>[
                      LinearProgressBar(co==null?0:(co/400)*100.round(),co,"CO"),
                      Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),),
                      LinearProgressBar(pm10==null?0:(pm10/400)*100.round(),pm10,"PM10"),
                      Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),),
                      LinearProgressBar(pm25==null?0:(pm25/400)*100.round(),pm25,"PM25"),
                      Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),),
                      LinearProgressBar(no2==null?0:(no2/50)*100.round(),no2,"NO2"),  
                      Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),),
                      LinearProgressBar(so2==null?0:(so2/50)*100.round(),so2,"SO2"),                    

                  ],
                ),
              ),
              
              Flexible(
                child: AutoSizeText("**Note: All The Null Values are because of the nearest pollution station of that city doesnot calculate those parameters ",
                 minFontSize: 14,
                      maxFontSize: 14,
                     textScaleFactor: 0.8,
               textAlign:TextAlign.center,style: TextStyle(color: Colors.white24),),
              ),
               Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),),     
            ],
          ),
    );
  }
}
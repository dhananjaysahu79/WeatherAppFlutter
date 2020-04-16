import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'dart:async';
import 'package:http/http.dart'as http;
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:geolocator/geolocator.dart';
import 'package:geocoder/geocoder.dart';
import 'package:progressbar/splashscreen.dart';
import 'airqualitysearch.dart';

class CountryData extends StatefulWidget {
  CountryData({Key key}) : super(key: key);

  _CountryDataState createState() => _CountryDataState();
}

class _CountryDataState extends State<CountryData> {
  TextEditingController t1 =TextEditingController();
   var url ="56ea943804a332dfedff52ba6de1543a";
   var loc;
   var decodedJson;
   var humidity;
   var wind;
   var sunset;
   var sunrise;
   var temp;
   var type;
   var temp_min;
   var temp_max;
   var location;
   var decodedJson2;
   var day1;
   var sday1;
   var sday2;
   var sday3;
   var sday4;
   var sday5;
   var day5;
   var date1;
   var date5;
   var month1;
   var month5;
   var curmax=0;
   var day1_icon;
   var day2_icon;
   var day3_icon;
   var day4_icon;
   var day5_icon;
   var long ;
   var lat;
   var curmin;
   var first;
   var feels_like;
   Image img;
   var img_name;
   List<String> dailymin_temp=new List(5);
   List<String> dailymax_temp=new List(5);
   var allloaded=null;

   @override
  void initState() {
    getlocation();
    super.initState(); 
  }
  getlocation() async {
    Position position =await Geolocator().getCurrentPosition(
     desiredAccuracy:LocationAccuracy.high
      );
       final coordinates =new Coordinates(position.latitude,position.longitude);
        var addresses= await Geocoder.local.findAddressesFromCoordinates(coordinates);
         first= addresses.first;
        setState(() {
          loc=first.locality;
          fetchData();
          fetchForecastData();
        });
  }
  

  Future fetchData() async {
    var res = await http.get(Uri.encodeFull("https://api.openweathermap.org/data/2.5/weather?q=$loc&units=imperial&appid=56ea943804a332dfedff52ba6de1543a"),
   headers: {"results":"application/json"}
    );
    decodedJson = jsonDecode(res.body);
    setState(() {
     type=decodedJson["weather"][0]["description"];
     temp=decodedJson["main"]["temp"];
     temp=tempConverter(temp);
     humidity=decodedJson["main"]["humidity"];
     temp_min=decodedJson["main"]["temp_min"];
     temp_min=tempConverter(temp_min);
     temp_max=decodedJson["main"]["temp_max"];
     temp_max=tempConverter(temp_max);
     wind=decodedJson["wind"]["speed"];
     location=decodedJson["name"];
     sunrise=decodedJson["sys"]["sunrise"];
     sunset=decodedJson["sys"]["sunset"];
     feels_like=decodedJson["main"]["feels_like"];
     feels_like=tempConverter(feels_like) + 1;
     img_name=decodedJson["weather"][0]["icon"];
     long=decodedJson["coord"]["lon"];
     lat=decodedJson["coord"]["lat"];
    });
  }

   Future fetchForecastData() async {
    var res1 = await http.get(Uri.encodeFull("http://api.openweathermap.org/data/2.5/forecast?q=$loc&units=imperial&mode=json&appid=56ea943804a332dfedff52ba6de1543a"),
   headers: {"results":"application/json"}
    );
    decodedJson2 = jsonDecode(res1.body);
    calmax(int start,int end){
      var curmax1=0;
     for(int i=start;i<=end;i++){
      if (tempConverter(decodedJson2["list"][i]["main"]["temp_max"])>curmax1){
        curmax1=tempConverter(decodedJson2["list"][i]["main"]["temp_max"]);
      }
      }
      return curmax1;
     }
     calmin(int index,int start,int end){
       var curmin2=55;
       for(int i=start;i<=end;i++){
       if (tempConverter(decodedJson2["list"][i]["main"]["temp_min"])<curmin2){
        curmin2=tempConverter(decodedJson2["list"][i]["main"]["temp_min"]);
       }
      }
      return curmin2;
     }
     dailymax_temp[0]=calmax(8,13).toString();
      dailymax_temp[1]=calmax(14,20).toString();
      dailymax_temp[2]=calmax(21,27).toString();
      dailymax_temp[3]=calmax(28,33).toString();
      dailymax_temp[4]=calmax(34,39).toString();
      dailymin_temp[0]=calmin(0,8,13).toString();
      dailymin_temp[1]=calmin(1,14,20).toString();
      dailymin_temp[2]=calmin(2,21,27).toString();
      dailymin_temp[3]=calmin(3,28,33).toString();
      dailymin_temp[4]=calmin(4,34,39).toString();
    setState(() {
      for(int i=4;i<14;i++){
      if (tempConverter(decodedJson2["list"][i]["main"]["temp_max"])>curmax){
        curmax=tempConverter(decodedJson2["list"][i]["main"]["temp_max"]);
      }
      }
      curmin=curmax;
      for(int i=1;i<10;i++){
      if (tempConverter(decodedJson2["list"][i]["main"]["temp_min"])<curmin){
        curmin=tempConverter(decodedJson2["list"][i]["main"]["temp_min"]);
      }
      }
      var format1 =DateFormat("d");
      var format2 =DateFormat("MMM");
      var format3=DateFormat("EEEE");
      var format4=DateFormat("EEE");
      date1=format1.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][8]["dt"] * 1000));
      date5=format1.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][39]["dt"] * 1000));
      month1=format2.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][8]["dt"] * 1000));
      month5=format2.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][39]["dt"] * 1000));
      day1=format3.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][8]["dt"] * 1000));
      day5=format3.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][39]["dt"] * 1000));
      sday1=format4.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][8]["dt"] * 1000)).toUpperCase();
      sday2=format4.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][16]["dt"] * 1000)).toUpperCase();
      sday3=format4.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][24]["dt"] * 1000)).toUpperCase();
      sday4=format4.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][32]["dt"] * 1000)).toUpperCase();
      sday5=format4.format(DateTime.fromMillisecondsSinceEpoch(decodedJson2["list"][39]["dt"] * 1000)).toUpperCase();
      day1_icon=(decodedJson2["list"][11]["weather"][0]["description"]).toString();
      day2_icon=decodedJson2["list"][19]["weather"][0]["description"].toString();
      day3_icon=decodedJson2["list"][27]["weather"][0]["description"].toString();
      day4_icon=decodedJson2["list"][34]["weather"][0]["description"].toString();
      day5_icon=decodedJson2["list"][39]["weather"][0]["description"].toString();
      print(day1_icon);
      allloaded=1;
    });
  }
  

 tempConverter(var t){
     t=5/9*(t-32);
     t=t.round()-1;
     return t;
 }

 search(){
 setState(() {
   loc=t1.text.toString();
   print(loc);
   fetchData();
   fetchForecastData();
   t1.text="";
 });
 }
String readTimestamp(int timestamp) {
    var now = new DateTime.now();
    var format = new DateFormat('HH:mm a');
    var date = new DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    var diff = now.difference(date);
    var time = '';

    if (diff.inSeconds <= 0 || diff.inSeconds > 0 && diff.inMinutes == 0 || diff.inMinutes > 0 && diff.inHours == 0 || diff.inHours > 0 && diff.inDays == 0) {
      time = format.format(date);
    } else if (diff.inDays > 0 && diff.inDays < 7) {
      if (diff.inDays == 1) {
        time = diff.inDays.toString() + ' DAY AGO';
      } else {
        time = diff.inDays.toString() + ' DAYS AGO';
      }
    } else {
      if (diff.inDays == 7) {
        time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
      } else {

        time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
      }
    }

    return time;
  }

  geticon(String name){
    IconData icon;
    if(name=="clear sky"){
      icon= Icons.wb_sunny;
    }
    else if(name=="few clouds"){
      icon=MdiIcons.weatherCloudy;
    }
    else if(name=="snow"){
      icon=MdiIcons.weatherSnowy;
    }
    else if(name=="mist"){
      icon=MdiIcons.weatherPartlyRainy;
    }
    else if(name=="broken clouds"||name=="overcast clouds"){
      icon=MdiIcons.weatherCloudy;
    }
    else{
      icon= Icons.wb_sunny;
    }
   return icon;
  }




  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarColor: Colors.transparent), 
      child: decodedJson==null?SplashScreen():Scaffold(
      body: SingleChildScrollView(
        child: Column(
        children: <Widget>[
          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/82),),
          Row(
            children: <Widget>[
              Container(
                color: Colors.white.withOpacity(0),
                height: MediaQuery.of(context).size.height/8,
                width: MediaQuery.of(context).size.width,
                  child:Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                        Container(
                          child: Row(
                            children: <Widget>[
                              Card(
                               elevation: 10,
                               color: Colors.black54,
                               shape:RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
                               child: Container(
                               width: MediaQuery.of(context).size.width/1.4,
                               height: MediaQuery.of(context).size.height/17,
                               child: Center(
                               child: TextField(
                               controller: t1,   onSubmitted: search(),           
                               style: TextStyle(color: Colors.white),
                               decoration: InputDecoration(
                               prefixIcon: Icon(Icons.search,color: Colors.white,),
                               hintText: "Search Location..",
                               labelStyle: TextStyle(color: Colors.white),
                               border: InputBorder.none,
                               hintStyle: TextStyle(
                               color: Colors.white,
                               fontSize: MediaQuery.of(context).size.height/41)
                              ,),
                             ),
                            ),
                           ),
                          ),
                         ],
                        ),
                       ),
                    AutoSizeText("AQ\nWeather",
                      minFontSize: 18,
                      maxFontSize: 18,
                      textScaleFactor: 0.8,
                      style:TextStyle(
                      color:Colors.greenAccent,
                      fontWeight: FontWeight.bold,
                    ))
                    ],
                    ),
                  ),
                ),
            ],
          ),
          Row(
            children: <Widget>[
              Stack(
               children: <Widget>[
                 Container(
                  height: MediaQuery.of(context).size.height/3.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    color: Colors.black54,
                    image: DecorationImage(
                      fit: BoxFit.cover,
                      image: AssetImage("Assets/Images/greengrass.jpg")
                    )
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height/3.3,
                  width: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                  gradient: LinearGradient(
                  colors: <Color>[
                    Color.fromARGB(210, 75, 226, 201),
                    Color.fromARGB(210, 10, 215, 219)
                      ],
                    stops: [0.1,0.9],
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter
                  )
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        height: MediaQuery.of(context).size.height/3.3,
                        width: MediaQuery.of(context).size.width/12,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height/3.3,
                        width: MediaQuery.of(context).size.width/1.19,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/32),),
                          Row(
                          children: <Widget>[
                              AutoSizeText("Weather Forecast",
                               minFontSize: 25,
                               maxFontSize: 25,
                               textScaleFactor: 0.8,
                              style: TextStyle(fontWeight: FontWeight.bold,),                        
                              ),  
                          ],
                        ),
                         Row(
                          children: <Widget>[
                              AutoSizeText("Forecast from $day1 $date1 $month1 to $day5 $date5 $month5",
                               minFontSize: 14,
                               maxFontSize: 14,
                              textScaleFactor: 0.8,                       
                              ),
                          ],
                        ),
                        Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/27),),
                         Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,                           
                             children: <Widget>[
                               Container(
                                   height: MediaQuery.of(context).size.height/6,
                                   child: Column(
                                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                     children: <Widget>[
                                       Row(
                                         children: <Widget>[
                                           AutoSizeText("$sday1",
                                            minFontSize: 22,
                                            maxFontSize: 22,
                                            textScaleFactor: 0.8,
                                           style: TextStyle(fontWeight: FontWeight.bold),)
                                         ],
                                       ),
                                      Row(
                                        children: <Widget>[
                                          Icon(geticon("$day1_icon"),size: MediaQuery.of(context).size.height/29,)
                                        ],
                                      ),
                                      Row(
                                         children: <Widget>[
                                          AutoSizeText(dailymin_temp[0]+"°/"+dailymax_temp[0]+"°",
                                           minFontSize: 15,
                                            maxFontSize: 15,
                                            textScaleFactor: 0.8,

                                          )
                                         ],
                                       ),
                                     ],
                                   ),
                                 ),

                                Container(
                                 height: MediaQuery.of(context).size.height/6,
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: <Widget>[
                                     Row(
                                       children: <Widget>[
                                         AutoSizeText("$sday2",
                                            minFontSize: 22,
                                            maxFontSize: 22,
                                            textScaleFactor: 0.8,
                                             style: TextStyle(fontWeight: FontWeight.bold),)
                                       ],
                                     ),
                                    Row(
                                      children: <Widget>[
                                        Icon(geticon("$day2_icon"),size: MediaQuery.of(context).size.height/29,)
                                      ],
                                    ),
                                    Row(
                                       children: <Widget>[
                                     AutoSizeText(dailymin_temp[1]+"°/"+dailymax_temp[1]+"°",
                                      minFontSize: 15,
                                      maxFontSize: 15,
                                      textScaleFactor: 0.8,
                                     )
                                       ],
                                     ),
                                   ],
                                 ),
                               ),

                                Container(
                                 height: MediaQuery.of(context).size.height/6,
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: <Widget>[
                                     Row(
                                       children: <Widget>[
                                        AutoSizeText("$sday3",
                                            minFontSize: 22,
                                            maxFontSize: 22,
                                            textScaleFactor: 0.8,
                                        style: TextStyle(fontWeight: FontWeight.bold),)
                                       ],
                                     ),
                                    Row(
                                      children: <Widget>[
                                         Icon(geticon("$day3_icon"),size: MediaQuery.of(context).size.height/29,)
                                      ],
                                    ),
                                    Row(
                                       children: <Widget>[
                                         AutoSizeText(dailymin_temp[2]+"°/"+dailymax_temp[2]+"°",
                                         minFontSize: 15,
                                         maxFontSize: 15,
                                         textScaleFactor: 0.8,
                                         )
                                       ],
                                     ),
                                   ],
                                 ),
                               ),

                                Container(
                                 height: MediaQuery.of(context).size.height/6,
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: <Widget>[
                                     Row(
                                       children: <Widget>[
                                         AutoSizeText("$sday4",
                                            minFontSize: 22,
                                            maxFontSize: 22,
                                            textScaleFactor: 0.8,
                                         style: TextStyle(fontWeight: FontWeight.bold),)
                                       ],
                                     ),
                                    Row(
                                      children: <Widget>[
                                         Icon(geticon("$day4_icon"),size: MediaQuery.of(context).size.height/29,)
                                      ],
                                    ),
                                    Row(
                                       children: <Widget>[
                                         AutoSizeText(dailymin_temp[3]+"°/"+dailymax_temp[3]+"°",
                                          minFontSize: 15,
                                          maxFontSize: 15,
                                          textScaleFactor: 0.8,
                                         )
                                       ],
                                     ),
                                   ],
                                 ),
                               ),

                                Container(
                                 height: MediaQuery.of(context).size.height/6,
                                 child: Column(
                                   mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                   children: <Widget>[
                                     Row(
                                       children: <Widget>[
                                         AutoSizeText("$sday5",
                                            minFontSize: 22,
                                            maxFontSize: 22,
                                            textScaleFactor: 0.8,
                                         style: TextStyle(fontWeight: FontWeight.bold),)
                                       ],
                                     ),
                                    Row(
                                      children: <Widget>[
                                         Icon(geticon("$day5_icon"),size: MediaQuery.of(context).size.height/29,)
                                      ],
                                    ),
                                    Row(
                                       children: <Widget>[
                                         AutoSizeText(dailymin_temp[4]+"°/"+dailymax_temp[4]+"°",
                                          minFontSize: 15,
                                          maxFontSize: 15,
                                          textScaleFactor: 0.8,
                                         )
                                       ],
                                     ),
                                   ],
                                 ),
                               )
                             ],
                           )   
                          ],
                        ),
                      )
                    ],
                  ),
                )
               ],
              )
            ],
          ),
          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/28),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/22),),
              Expanded(child: 
              AutoSizeText("$location",
              minFontSize: 31,
              maxFontSize: 31,
              textScaleFactor: 0.8,
              style: TextStyle(
                color:Colors.white,
                fontWeight: FontWeight.bold,
                 ),
              )),
              Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/32),),
              InkWell(
               onTap:()=>{Navigator.of(context).push(MaterialPageRoute<Null>(builder:(BuildContext context){return AqiSearch(long,lat,location);}))},
                splashColor: Colors.blue,
                child: AutoSizeText("AIR\nQUALITY",
                minFontSize: 13,
                maxFontSize: 13,
                textScaleFactor: 0.8,
                textAlign: TextAlign.center,
                style:TextStyle(
                  color: Colors.white,
                  )
                ),
              ),
              IconButton(icon: Icon(Icons.location_on,color: Colors.white,size: MediaQuery.of(context).size.height/38,),
               onPressed: () {
                 getlocation();
                 setState(() {                   
                 });
               },),
              IconButton(icon: Icon(MdiIcons.replay,color: Colors.white,size: MediaQuery.of(context).size.height/38,), 
              onPressed: () {
                fetchData();
                fetchForecastData();
                setState(() {
                  
                });
              },)
            ],
          ),
          
          Row(
            children: <Widget>[
               Padding(padding: EdgeInsets.only(left: MediaQuery.of(context).size.width/21),),
              Expanded(child: AutoSizeText((type==null)?"null":type.toString(),
              minFontSize: 15,
              maxFontSize: 15,
              textScaleFactor: 0.8,
              style: TextStyle(
                color: Colors.white54
              ),
              ))
            ],
          ),
          Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/34),),
         Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: <Widget>[
             Card(
               elevation: 6,
               color: Colors.black,
               child: 
               Container(
                 height: MediaQuery.of(context).size.height/4.8,
                 width: MediaQuery.of(context).size.width/1.09,
                 child: Row(
                   children: <Widget>[
                     Container(
                      height: MediaQuery.of(context).size.height/4.8,
                      width: MediaQuery.of(context).size.width/140,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(7),
                          bottomLeft: Radius.circular(7)
                          ),
                        gradient: LinearGradient(
                          colors: <Color>[
                        Color.fromARGB(210, 19, 206, 206),
                        Color.fromARGB(210, 76, 240, 207),
                         //Color.fromARGB(200, 184, 30, 160),
                         //Color.fromARGB(200, 60, 17, 109),
                      ],
                      stops: [0,0.5],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter
                        )
                      ),
                     ),
                     Container(
                       height: MediaQuery.of(context).size.height/4.8,
                      width: MediaQuery.of(context).size.width/13,
                     ),
                     Container(
                       width: MediaQuery.of(context).size.width/1.3,
                       child: Column(
                         children: <Widget>[
                           Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/50),),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.spaceBetween,
                             children: <Widget>[
                              AutoSizeText(temp==null?" ":temp.toString()+"°C",
                              minFontSize: 75,
                              maxFontSize: 75,
                              textScaleFactor: 0.8,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white
                              )
                              ,),
                              Container(
                                height:  MediaQuery.of(context).size.height/12,
                                width: MediaQuery.of(context).size.height/12,
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    fit: BoxFit.fill,
                                    image: NetworkImage("http://openweathermap.org/img/wn/$img_name@2x.png"),
                                  )
                                ),
                              )
                             
                           ],
                           ),
                           Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/60),),
                           Row(
                             children: <Widget>[
                               Container(
                                 color: Colors.white,
                                 height: 0.3,
                                 width:  MediaQuery.of(context).size.width/1.3,
                               )
                             ],
                           ),
                            Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/100),),
                           Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: <Widget>[
                               Expanded(child: AutoSizeText("Today in the City $location is $type with Temperature max "+curmax.toString() +"°C and temperature min "+curmin.toString() +"°C",
                               minFontSize: 13,
                               maxFontSize: 13,
                               textScaleFactor: 0.8,
                               style: TextStyle(
                                 color: Colors.white,
                                 fontWeight: FontWeight.bold
                                 ),))
                             ],
                           )
                         ],
                       ),
                     )
                   ],
                 ),
               ),
             )
           ],
         ),
         Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/45),),
         Container(
            height: MediaQuery.of(context).size.height/7.4,
            width: MediaQuery.of(context).size.width/1.07,
           child: Row(
             mainAxisAlignment: MainAxisAlignment.spaceBetween,
             children: <Widget>[
               Card(elevation: 2,
                 shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.only(
                     topLeft: Radius.circular(26)
                   )
                   ),
                 color: Colors.black,
                 child: Container(                 
                  height: MediaQuery.of(context).size.height/7.2,
                  width: MediaQuery.of(context).size.width/4.8, 
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(MdiIcons.waterOutline,color:Colors.blue,size: MediaQuery.of(context).size.height/30,),
                      Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/70),),
                      AutoSizeText("HUMIDITY",
                      minFontSize: 13,
                      maxFontSize: 13,
                      textScaleFactor: 0.8,
                      style:TextStyle(color:Colors.blue,fontWeight:FontWeight.bold)),
                      AutoSizeText((humidity==null)?"null":humidity.toString()+" %",
                      minFontSize: 12,
                      maxFontSize: 12,
                     textScaleFactor: 0.8,
                      style:TextStyle(color:Colors.blue,fontWeight:FontWeight.bold)),
                    ],
                  ),
                 ),
               ),
                Card(elevation: 2,
                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                 color: Colors.black,
                 child: Container(                 
                  height: MediaQuery.of(context).size.height/7.2,
                  width: MediaQuery.of(context).size.width/4.8, 
                   child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                     children: <Widget>[
                       Icon(MdiIcons.weatherWindy,color:Colors.greenAccent,size: MediaQuery.of(context).size.height/30,),
                       Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/70),),
                      AutoSizeText("WIND",
                        minFontSize: 13,
                      maxFontSize: 13,
                     textScaleFactor: 0.8,
                      style:TextStyle(color:Colors.greenAccent,fontWeight:FontWeight.bold)),
                      AutoSizeText("$wind KMH",
                        minFontSize: 12,
                      maxFontSize: 12,
                     textScaleFactor: 0.8,
                      style:TextStyle(color:Colors.greenAccent,fontWeight:FontWeight.bold)),
                     ],
                   ),
                 ),
               ),
                Card(elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
                 color: Colors.black,
                 child: Container(                 
                  height: MediaQuery.of(context).size.height/7.2,
                  width: MediaQuery.of(context).size.width/4.8, 
                  child: Column(
                     crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(MdiIcons.weatherSunsetUp,color:Colors.deepOrangeAccent,size: MediaQuery.of(context).size.height/30,),
                      Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/70),),
                      AutoSizeText("SUNRISE",
                        minFontSize: 13,
                      maxFontSize: 13,
                     textScaleFactor: 0.8,
                      style:TextStyle(color:Colors.deepOrangeAccent,fontWeight:FontWeight.bold)),
                      AutoSizeText(readTimestamp(sunrise)==null?"":readTimestamp(sunrise),
                        minFontSize: 12,
                      maxFontSize: 12,
                     textScaleFactor: 0.8,
                      style:TextStyle(color:Colors.deepOrangeAccent,fontWeight:FontWeight.bold)),
                    ],
                  ),
                 ),
               ),
                Card(elevation: 2,
                  shape: RoundedRectangleBorder(
                   borderRadius: BorderRadius.only(
                     bottomRight: Radius.circular(26)
                   )),
                 color: Colors.black,
                 child: Container(                 
                  height: MediaQuery.of(context).size.height/7.2,
                  width: MediaQuery.of(context).size.width/4.8, 
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Icon(MdiIcons.weatherSunsetDown,color:Colors.purple,size: MediaQuery.of(context).size.height/30,),
                      Padding(padding: EdgeInsets.only(top: MediaQuery.of(context).size.height/70),),
                      AutoSizeText("SUNSET",
                        minFontSize: 13,
                      maxFontSize: 13,
                     textScaleFactor: 0.8,
                      style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold)),
                      AutoSizeText(readTimestamp(sunset),
                        minFontSize: 12,
                      maxFontSize: 12,
                     textScaleFactor: 0.8,
                      style:TextStyle(color:Colors.purple,fontWeight:FontWeight.bold)),
                    ],
                  ),
                 ),
               ),
             ],
           ),
         )
        ],
      ),
    ),
      ),
    );
  }
}
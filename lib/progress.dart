import 'package:flutter/material.dart';
import 'package:vector_math/vector_math.dart' as math;


class ProgressBar extends StatefulWidget {
  var aqi;
  ProgressBar(this.aqi);

  _ProgressBarState createState(){ return _ProgressBarState(aqi);}
}

class _ProgressBarState extends State<ProgressBar> {
  int aqi;
  _ProgressBarState(this.aqi);
 void initState() { 
    __refresh();
    
  }
   __refresh() async {
   await Future.delayed(const Duration(seconds:2),(){
      setState(() {
        
      });
   });
  }

  @override
  Widget build(BuildContext context) {
      
            return CustomPaint(
             child: Container(
               height: 200,
               width: 200,
             ),
             painter: RadialPainter(aqi),
            );
        
     
  }
}

class RadialPainter extends CustomPainter{
  var aqi;
  RadialPainter(this.aqi);

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint=Paint()
    ..color=Colors.white12
    ..strokeCap=StrokeCap.round
    ..style=PaintingStyle.stroke
    ..strokeWidth=4;
    Offset center = Offset(size.width/2, size.height/2);
    canvas.drawCircle(center, size.width/2, paint);
    

    Paint progresspaint=Paint()
    
    ..shader=LinearGradient(
      stops: [0.0,0.9],
      //colors: [Colors.red,Colors.deepPurple]
      colors: [Color.fromARGB(210, 19, 206, 206),Color.fromARGB(210, 76, 240, 207),]
    ).createShader(Rect.fromCircle(center:center,radius:size.width/2))
    ..strokeCap=StrokeCap.round
    ..style=PaintingStyle.stroke
    
    ..strokeWidth=13.0;

    Paint blurr =Paint()
    ..color=Colors.black.withAlpha(250)
    ..style=PaintingStyle.stroke
    ..strokeWidth=5
    ..maskFilter=MaskFilter.blur(BlurStyle.normal, 12);
   
    Paint headpoint =Paint()
    ..color=Colors.white
    ..style=PaintingStyle.stroke
    ..strokeWidth=7
    ..strokeCap=StrokeCap.round;

    Paint head =Paint()
    ..shader=LinearGradient(
      stops: [0.0,0.9],
      //colors: [Colors.red,Colors.deepPurple]
      colors: [Color.fromARGB(210, 19, 206, 206),Color.fromARGB(210, 76, 240, 207),]
    ).createShader(Rect.fromCircle(center:center,radius:size.width/2))
    ..style=PaintingStyle.stroke
    ..strokeWidth=17
    ..strokeJoin=StrokeJoin.bevel
    ..strokeCap=StrokeCap.round;
    
   
   canvas.drawArc(
     Rect.fromCircle(center:center,radius: size.width/2), 
     math.radians(-90),
     math.radians(aqi*3.6),
     false,
     progresspaint
     );
   
    canvas.drawArc(Rect.fromCircle(center:center,radius: size.width/2),
     math.radians(-90),
     math.radians(aqi*3.6),
     false,
     blurr);
     canvas.drawArc(Rect.fromCircle(center:center,radius: size.width/2)
    ,  math.radians(-90+aqi*3.6), math.radians(0.5), false, head);
    canvas.drawArc(Rect.fromCircle(center:center,radius: size.width/2)
    ,  math.radians(-90+aqi*3.6), math.radians(0.3), false, headpoint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate){
    return true;
  }
}
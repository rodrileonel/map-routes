import 'package:flutter/material.dart';

class PainterStartPainter extends CustomPainter {

  final int minutes;

  PainterStartPainter(this.minutes);

  @override
  void paint(Canvas canvas, Size size) {

    final double radBlack =15;
    final double radWhite =6;

    Paint paint = Paint()
    ..color = Colors.black;

    //circulo negro
    canvas.drawCircle(
      Offset(radBlack,size.height-radBlack), 
      radBlack, 
      paint
    );
    //circulo blanco
    paint.color = Colors.white;
    canvas.drawCircle(
      Offset(radBlack,size.height-radBlack), 
      radWhite, 
      paint
    );

    //sombras
    final Path shadow = Path()
    ..moveTo(size.width/7, 10)
    ..lineTo(size.width-10, 10)
    ..lineTo(size.width-10, size.height/1.5)
    ..lineTo(size.width/7, size.height/1.5);

    canvas.drawShadow(shadow, Colors.black, 10, false);

    //caja blanca
    final whiteBox = Rect.fromLTWH(size.width/7, 10, (size.width-10 - size.width/7), (size.height/1.5-10));
    canvas.drawRect(whiteBox, paint);
    //caja negra
    paint.color = Colors.black;
    final blackBox = Rect.fromLTWH(size.width/7, 10, (size.width-10 - size.width/7)/4, (size.height/1.5-10));
    canvas.drawRect(blackBox, paint);

    //textos
    TextSpan textSpan = TextSpan(
      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
      text: '$minutes'
    );

    TextPainter textPainter = TextPainter(
      text:textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      maxWidth:(size.width-10 - size.width/7)/4,
      minWidth:(size.width-10 - size.width/7)/4,
    );

    textPainter.paint(canvas, Offset(size.width/7,25));

    //texto minutos
    textSpan = TextSpan(
      style: TextStyle(color: Colors.white,fontSize: 15),
      text: 'Min'
    );

    textPainter = TextPainter(
      text:textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      maxWidth:(size.width-10 - size.width/7)/4,
      minWidth:(size.width-10 - size.width/7)/4,
    );

    textPainter.paint(canvas, Offset(size.width/7,48));

    //texto ubicación
    textSpan = TextSpan(
      style: TextStyle(color: Colors.black,fontSize: 20),
      text: 'Mi ubicación'
    );
    
    textPainter = TextPainter(
      text:textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      maxWidth:size.width,
    );

    textPainter.paint(canvas, Offset((size.width-10 - size.width/7)/2,32));
  }

  @override
  bool shouldRepaint(PainterStartPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PainterStartPainter oldDelegate) => false;
}
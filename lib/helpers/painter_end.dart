import 'package:flutter/material.dart';

class PainterEndPainter extends CustomPainter {

  final String description;
  final double km;

  PainterEndPainter(this.km, this.description);

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
    ..moveTo(0, 10)
    ..lineTo(size.width-10, 10)
    ..lineTo(size.width-10, size.height/1.5)
    ..lineTo(0, size.height/1.5);

    canvas.drawShadow(shadow, Colors.black, 10, false);

    //caja blanca
    final whiteBox = Rect.fromLTWH(0, 10, size.width-10, (size.height/1.5-10));
    canvas.drawRect(whiteBox, paint);
    //caja negra
    paint.color = Colors.black;
    final blackBox = Rect.fromLTWH(0, 10, (size.width-10)/4, (size.height/1.5-10));
    canvas.drawRect(blackBox, paint);

    //textos
    TextSpan textSpan = TextSpan(
      style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),
      text: '${(((km/1000)*10).floor().toDouble())/10}'
    );

    TextPainter textPainter = TextPainter(
      text:textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      maxWidth:(size.width-10)/4,
      minWidth:(size.width-10)/4,
    );

    textPainter.paint(canvas, Offset(0,25));

    //texto minutos
    textSpan = TextSpan(
      style: TextStyle(color: Colors.white,fontSize: 15),
      text: 'Km'
    );

    textPainter = TextPainter(
      text:textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.center,
    )..layout(
      maxWidth:(size.width-10)/4,
      minWidth:(size.width-10)/4,
    );

    textPainter.paint(canvas, Offset(0,48));

    //texto ubicación
    textSpan = TextSpan(
      style: TextStyle(color: Colors.black,fontSize: 20),
      text: '$description'
    );
    
    textPainter = TextPainter(
      text:textSpan,
      textDirection: TextDirection.ltr,
      textAlign: TextAlign.left,
      maxLines: 2,
      ellipsis: '...'
    )..layout(
      maxWidth:size.width-size.width/4-16,
    );

    textPainter.paint(canvas, Offset(size.width/4+5,20));
  }

  @override
  bool shouldRepaint(PainterEndPainter oldDelegate) => true;

  @override
  bool shouldRebuildSemantics(PainterEndPainter oldDelegate) => false;
}
import 'dart:ui';

import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:googlemaps/helpers/painter_end.dart';
import 'package:googlemaps/helpers/painter_start.dart';

Future<BitmapDescriptor> getMarkerStartIcon(int seconds) async{
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(300, 120);

  final minutes = (seconds/60).floor();

  final markerStart = PainterStartPainter(minutes);
  markerStart.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());

}

Future<BitmapDescriptor> getMarkerEndIcon(int distance, String description) async{
  final recorder = PictureRecorder();
  final canvas = Canvas(recorder);
  final size = Size(300, 120);

  final markerEnd = PainterEndPainter(distance.toDouble(),description);
  markerEnd.paint(canvas, size);

  final picture = recorder.endRecording();
  final image = await picture.toImage(size.width.toInt(), size.height.toInt());
  final byteData = await image.toByteData(format: ImageByteFormat.png);

  return BitmapDescriptor.fromBytes(byteData.buffer.asUint8List());

}
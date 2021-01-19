//https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png

import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

Future<BitmapDescriptor> getAssetImageMarker() async {
  return await BitmapDescriptor.fromAssetImage(
    ImageConfiguration(
      devicePixelRatio: 1.5
    ),
    'assets/custom-pin.png'
  );
}

Future<BitmapDescriptor> getNetworkImageMarker() async {
  final response = await Dio().get(
    'https://cdn4.iconfinder.com/data/icons/small-n-flat/24/map-marker-512.png',
    options: Options(responseType:ResponseType.bytes)
  );
  //ajustar dimensiones dela imagen
  final imageCodec = await instantiateImageCodec(response.data,targetHeight: 130,targetWidth: 130);
  final frame = await imageCodec.getNextFrame();
  final data = await frame.image.toByteData(format: ImageByteFormat.png);

  return await BitmapDescriptor.fromBytes(data.buffer.asUint8List());
}
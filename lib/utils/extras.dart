import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/services.dart';

Future<Uint8List> loadAsset(String path,
    {int width = 50, int height = 50}) async {
  ByteData data = await rootBundle.load(path);
  final Uint8List bytes = data.buffer.asUint8List();

  final ui.Codec codec = await ui.instantiateImageCodec(bytes,
      targetWidth: width, targetHeight: height);

  final ui.FrameInfo frame = await codec.getNextFrame();

  data = await frame.image.toByteData(format: ui.ImageByteFormat.png);

  return data.buffer.asUint8List();
}

import 'dart:async';
import 'dart:typed_data';

import 'dart:ui' as ui show Image, ImageByteFormat;

import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';

Future<ui.Image> captureImage(GlobalKey key) async {
  final RenderRepaintBoundary boundary =
      key.currentContext.findRenderObject() as RenderRepaintBoundary;
  return boundary.toImage();
}

// cannot be tested due to: https://github.com/flutter/flutter/issues/49317
Future<Uint8List> formatAsPng(ui.Image image) async {
  final byteData = await image.toByteData(format: ui.ImageByteFormat.png);
  return byteData.buffer.asUint8List();
}

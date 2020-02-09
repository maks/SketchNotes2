import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sketchnotes2/image_formats.dart';

void main() {
  testWidgets('create a in-memory image from a widget', (tester) async {
    final GlobalKey _globalKey = GlobalKey();
    await tester.pumpWidget(
      Directionality(
        child: RepaintBoundary(
          key: _globalKey,
          child: Text('Test'),
        ),
        textDirection: TextDirection.ltr,
      ),
    );

    expect(find.byType(RepaintBoundary), findsOneWidget);

    final img = await captureImage(_globalKey);

    expect(img.width, 800);
    expect(img.height, 600);
  });
}

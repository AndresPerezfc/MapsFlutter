import 'package:flutter/material.dart';
import 'package:google_maps/models/place.dart';

class MyCustomMarker extends CustomPainter {
  final Place place;

  MyCustomMarker(this.place);

  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint();
    paint.color = Colors.blueAccent;

    final height = size.height - 15;

    // final Rect rect = Rect.fromLTWH(0, 0, size.width, height);
    final RRect rrect =
        RRect.fromLTRBR(0, 0, size.width, height, Radius.circular(25));
    canvas.drawRRect(rrect, paint);

    final rect = Rect.fromLTWH(size.width / 2 - 2.5, height, 5, 15);
    canvas.drawRect(rect, paint);

    paint.color = Colors.redAccent;

    canvas.drawCircle(Offset(20, height / 2), 12, paint);

    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: this.place.title, style: TextStyle(fontSize: 14)),
      textDirection: TextDirection.ltr,
      maxLines: 2,
    );

    textPainter.layout(maxWidth: size.width - 55);

    textPainter.paint(canvas, Offset(40, height / 2 - textPainter.height / 2));
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

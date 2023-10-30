//!

import 'package:attendance_app/model/user_model.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

class FaceDetectorPainter extends CustomPainter {
  FaceDetectorPainter(
      {required this.absoluteImageSize,
      required this.faces,
      required this.camDire2});

  final Size absoluteImageSize;
  final List<UserModel> faces;
  final CameraLensDirection camDire2;

  @override
  void paint(Canvas canvas, Size size) {
    final double scaleX = size.width / absoluteImageSize.width;
    final double scaleY = size.height / absoluteImageSize.height;

    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0
      ..color = Colors.indigoAccent;
    if (faces.isNotEmpty) {
      var face = faces[0];

      // for (UserModel face in faces) {
      canvas.drawRect(
        Rect.fromLTRB(
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.location!.right) * scaleX
              : face.location!.left * scaleX,
          face.location!.top * scaleY,
          camDire2 == CameraLensDirection.front
              ? (absoluteImageSize.width - face.location!.left) * scaleX
              : face.location!.right * scaleX,
          face.location!.bottom * scaleY,
        ),
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(FaceDetectorPainter oldDelegate) {
    return true;
  }
}

import 'package:attendance_app/controller/camera_preview_controller.dart';
import 'package:attendance_app/model/user_model.dart';
import 'package:attendance_app/pages/camera/face_detector_painter.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FaceRecognitonScreen extends StatefulWidget {
  const FaceRecognitonScreen({
    super.key,
    required this.cameraController,
  });
  final CameraController cameraController;

  // final CameraLensDirection camDirec;

  @override
  State<FaceRecognitonScreen> createState() => _FaceRecognitonScreenState();
}

class _FaceRecognitonScreenState extends State<FaceRecognitonScreen> {
  late Size imageSize;
  late CustomPainter painter;
  CameraPreviewController _previewController =
      Get.put(CameraPreviewController());
  @override
  void initState() {
    imageSize = Size(
      widget.cameraController.value.previewSize!.height,
      widget.cameraController.value.previewSize!.width,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () {
        return _previewController.scanResults.value != []
            ? CustomPaint(
                painter: FaceDetectorPainter(
                  absoluteImageSize: imageSize,
                  faces: _previewController.scanResults.value,
                  camDire2: CameraLensDirection.front,
                ),
              )
            : const Center(child: Text('Camera is not initialized'));
      },
    );
  }
}

import 'dart:developer';
import 'dart:ui';
import 'package:attendance_app/firebase/attendance_firebase.dart';
import 'package:attendance_app/machine_learning/tflite_recognizer.dart';
import 'package:attendance_app/model/user_model.dart';
import 'package:attendance_app/helper/app_colors/helper.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_mlkit_face_detection/google_mlkit_face_detection.dart';
import 'package:image/image.dart' as img;

class CameraPreviewController extends GetxController {
  CameraLensDirection camDirec = CameraLensDirection.front;
  Rx<bool> isBusy = false.obs;
  late FaceDetector faceDetector;
  late TfliteRecognizer tfliteRecognizer;
    Rx<String> checkIn = "".obs;
  // CameraImage? frame;
  late List<UserModel> userModelList = [];
  img.Image? image;
  late img.Image croppedFace;
  Rx<bool> register = false.obs;
  var userModel = UserModel(name: "Unknown").obs;
  // var registeredFacesMap = <String, UserModel>{}.obs;

  late Size size;
  var scanResults = <UserModel>[].obs;
  @override
  @override
  void onInit() {
    super.onInit();

    faceDetector = FaceDetector(
        options: FaceDetectorOptions(performanceMode: FaceDetectorMode.fast));
    tfliteRecognizer = TfliteRecognizer();
  }

  doFaceDetectionOnFrame(
      {required CameraImage frame,
      required CameraDescription description}) async {
    InputImage inputImage =
        getInputImage(frame: frame, description: description);
    List<Face> faces = await faceDetector.processImage(inputImage);
    performFaceRecognition(faces: faces, frame: frame);
    log("xox faces length ${faces.length} ");
    isBusy.value = false;
  }

  performFaceRecognition(
      {required List<Face> faces, required CameraImage frame}) async {
    userModelList.clear();

    image = convertYUV420ToImage(frame);
    image =
        img.copyRotate(image!, camDirec == CameraLensDirection.front ? 90 : 270);

    for (Face face in faces) {
      Rect faceRect = face.boundingBox;

      croppedFace = img.copyCrop(
          image!,
          faceRect.left.toInt(),
          faceRect.top.toInt(),
          faceRect.width.toInt(),
          faceRect.height.toInt());

      userModel.value = tfliteRecognizer.recognize(croppedFace, faceRect);
      if (userModel.value.distance > 1) {
        userModel.value.name = "Unknown";
      }
      userModelList.add(userModel.value);
    }

    isBusy.value = false;
    scanResults.value = userModelList;
  }

  InputImage getInputImage({
    required CameraImage frame,
    required CameraDescription description,
  }) {
    final WriteBuffer allBytes = WriteBuffer();
    for (final Plane plane in frame.planes) {
      allBytes.putUint8List(plane.bytes);
    }
    final bytes = allBytes.done().buffer.asUint8List();
    final Size imageSize =
        Size(frame.width.toDouble(), frame.height.toDouble());
   
    final imageRotation =
        InputImageRotationValue.fromRawValue(description.sensorOrientation);
    final inputImageFormat =
        InputImageFormatValue.fromRawValue(frame.format.raw);
    final planeData = frame.planes.map(
      (Plane plane) {
        return InputImagePlaneMetadata(
          bytesPerRow: plane.bytesPerRow,
          height: plane.height,
          width: plane.width,
        );
      },
    ).toList();

    final inputImageData = InputImageData(
      size: imageSize,
      imageRotation: imageRotation!,
      inputImageFormat: inputImageFormat!,
      planeData: planeData,
    );

    final inputImage =
        InputImage.fromBytes(bytes: bytes, inputImageData: inputImageData);

    return inputImage;
  }

  img.Image convertYUV420ToImage(CameraImage cameraImage) {
    final width = cameraImage.width;
    final height = cameraImage.height;
    final yRowStride = cameraImage.planes[0].bytesPerRow;
    final uvRowStride = cameraImage.planes[1].bytesPerRow;
    final uvPixelStride = cameraImage.planes[1].bytesPerPixel!;
    final image = img.Image(width, height);
    for (var w = 0; w < width; w++) {
      for (var h = 0; h < height; h++) {
        final uvIndex =
            uvPixelStride * (w / 2).floor() + uvRowStride * (h / 2).floor();
        final index = h * width + w;
        final yIndex = h * yRowStride + w;

        final y = cameraImage.planes[0].bytes[yIndex];
        final u = cameraImage.planes[1].bytes[uvIndex];
        final v = cameraImage.planes[2].bytes[uvIndex];

        image.data[index] = yuv2rgb(y, u, v);
      }
    }
    return image;
  }

 

  int yuv2rgb(int y, int u, int v) {
    var r = (y + v * 1436 / 1024 - 179).round();
    var g = (y - u * 46549 / 131072 + 44 - v * 93604 / 131072 + 91).round();
    var b = (y + u * 1814 / 1024 - 227).round();

    r = r.clamp(0, 255);
    g = g.clamp(0, 255);
    b = b.clamp(0, 255);

    return 0xff000000 |
        ((b << 16) & 0xff0000) |
        ((g << 8) & 0xff00) |
        (r & 0xff);
  }

  getCurrentDateTime() {
    DateTime currentDate = DateTime.now();
    return convertDateYYYYMMDDToHumanReadableFormat(currentDate.toString());
  }
}

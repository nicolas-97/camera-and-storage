import 'package:camera_and_storage/screens/take_picture.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

Future<void> main() async {

  WidgetsFlutterBinding.ensureInitialized();

  final cameras = await availableCameras();

  final firstCamera = cameras.first;

  runApp(
    App(
      camera: firstCamera
      )
  );
}

class App extends StatelessWidget {
  const App({
    super.key,
    required this.camera
  });

  final CameraDescription camera;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.dark(),
      home: TakePicture(camera: camera),
    );
  }
}
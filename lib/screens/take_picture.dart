import 'package:camera_and_storage/screens/display_picture.dart';
import 'package:flutter/material.dart';
import 'package:camera/camera.dart';

class TakePicture extends StatefulWidget {
  const TakePicture({
      super.key,
      required this.camera
    });

  final CameraDescription camera;

  @override
  State<TakePicture> createState() => _TakePictureState();
}

class _TakePictureState extends State<TakePicture> {

  late CameraController _controller;
  late Future<void> _initializeControllerFuture;

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.max
    );

    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose(){
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tomar una foto'),
      ),
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if(snapshot.connectionState == ConnectionState.done){
            return CameraPreview(_controller);
          }else{
            return const Center(child: CircularProgressIndicator());
          }
        }, 
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;

            final image = await _controller.takePicture();

            print(image.path);

            if(!mounted) return;

            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => DisplayPicture(imagePath: image.path)),
            );

          }catch(e){
            print('error $e');
          }
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
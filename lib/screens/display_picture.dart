import 'dart:io';

import 'package:flutter/material.dart';

class DisplayPicture extends StatelessWidget {
  const DisplayPicture({
    super.key,
    required this.imagePath
  });

  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ver foto'),
      ),
      body: Image.file(File(imagePath)),
    );
  }
}
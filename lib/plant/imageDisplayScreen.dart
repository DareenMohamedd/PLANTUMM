import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImageDisplayScreen extends StatefulWidget {

  const ImageDisplayScreen({super.key, required this.image});
  final XFile image;

  @override
  State<ImageDisplayScreen> createState() => _ImageDisplayScreenState();
}

class _ImageDisplayScreenState extends State<ImageDisplayScreen> {
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Image.file(
          File(widget.image.path),
        ),
      ),
    );
  }
}

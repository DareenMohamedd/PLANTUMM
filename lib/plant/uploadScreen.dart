import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class Upload extends StatefulWidget {
  const Upload({Key? key}) : super(key: key);

  @override
  State<Upload> createState() => _UploadState();
}

class _UploadState extends State<Upload> {
  List<XFile> _images = [];
  String type = "";
  String tConfidence = "";
  String disease = "";
  String dConfidence = "";
  String error = "";
  String status = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(56.0),
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF636FA4), Color(0xFF3fada8)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
        ),
      ),
      backgroundColor: const Color(0xff55598d),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image1 == null
                ? const Stack(
              alignment: Alignment.center,
              children: [
                CircleAvatar(
                  radius: 156,
                  backgroundColor: Color(0xFF636FA4),
                ),
                CircleAvatar(
                  radius: 153,
                  backgroundColor: Color(0xFF3fada8),
                ),
                CircleAvatar(
                  radius: 150,
                  backgroundImage: AssetImage('assets/images/Upload.jpg'),
                ),
              ],
            )
                : Image.file(_image1!, height: 200, width: 200,),
            const SizedBox(height: 30,),
            Visibility(
              visible: type.isNotEmpty,
              child: Column(
                children: [
                  Text("Type: $type", style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10,),
                  Text("Confidence: $tConfidence", style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10,),
                  Text("Disease: $disease", style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
                  const SizedBox(height: 10,),
                  Text("Confidence: $dConfidence", style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.bold)),
                ],
              ),
            ),
            Visibility(
              visible: error.isNotEmpty,
              child: Text("Error: $error", style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold)),
            ),
            const SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(0.0),
              child: ElevatedButton(
                style: ButtonStyle(
                  elevation: MaterialStateProperty.all<double>(0),
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(40.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all<Size>(
                      const Size(200, 50)),
                  backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.transparent),
                ),
                onPressed: () {
                  uploadImage1(source: ImageSource.camera);
                },
                child: Container(
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF636FA4), Color(0xFF3fada8)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Container(
                    constraints: const BoxConstraints(
                        maxWidth: 330, minHeight: 50),
                    alignment: Alignment.center,
                    child: const Text(
                      "Scan",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20,),
            ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(40.0),
                  ),
                ),
                minimumSize: MaterialStateProperty.all<Size>(
                    const Size(200, 50)),
                backgroundColor: MaterialStateProperty.all<Color>(
                    Colors.transparent),
              ),
              onPressed: () {
                uploadImage1(source: ImageSource.gallery);
              },
              child: Container(
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF636FA4), Color(0xFF3fada8)],
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                  ),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Container(
                  constraints: const BoxConstraints(
                      maxWidth: 330, minHeight: 50),
                  alignment: Alignment.center,
                  child: const Text(
                    "Upload",
                    style: TextStyle(fontSize: 20, color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50,),
          ],
        ),
      ),
    );
  }

  final pickedFile = ImagePicker();
  File? _image1;

  uploadImage1({required ImageSource source}) async {
    var pickedImage = await pickedFile.pickImage(source: source);
    if (pickedImage != null) {
      setState(() {
        _image1 = File(pickedImage.path);
        // Reset previous results
        type = "";
        tConfidence = "";
        disease = "";
        dConfidence = "";
        error = "";
        status = "";
        // Fetch new result
        getResult(image: _image1!.path);
      });
    }
  }


  Future<void> getResult({required String image}) async {
    try {
      final response = await Dio().post(
        'http://172.20.10.2:5000/api',
        data: FormData.fromMap({
          "image": await MultipartFile.fromFile(image),
        }),
        options: Options(contentType: Headers.formUrlEncodedContentType),
      );

      if (response.statusCode == 200) {
        setState(() {
          if (response.data['Status'] == "False") {
            error = response.data['Error'];
          } else {
            type = response.data["Predicted_Class"];
            tConfidence = response.data['Predicted_Class_Confidence'];
            disease = response.data['Predicted_Disease'];
            dConfidence = response.data['Predicted_Disease_Confidence'];
          }
        });
      } else {
        setState(() {
          error = "Failed to fetch result.";
        });
      }
    } catch (e) {
      setState(() {
        error = "Error: $e";
      });
    }
  }
}
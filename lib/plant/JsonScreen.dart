import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class JsonScreen extends StatefulWidget {


  const JsonScreen({super.key, required this.result});
  final String result;
  @override
  State<JsonScreen> createState() => _JsonScreenState();
}

class _JsonScreenState extends State<JsonScreen> {
  @override
  void initState() {

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title:  Text("The Result Is : ${widget.result}"),),

    );
  }
}


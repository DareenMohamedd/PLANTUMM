import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:lottie/lottie.dart';

import 'IntroScreen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  dynamic _time;
  start()
  {


    _time = Timer(const Duration(seconds: 6),call);
  }
  void call()
  {
    Navigator.pushReplacement(
        context as BuildContext,
        MaterialPageRoute(builder: (context)=> const MIModel(),));
  }
  @override
  void initState()
  {
    start();
    super.initState();
  }
  @override
  void dispose()
  {
    _time.cancel();
    super.dispose();

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff55598d),
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarBrightness: Brightness.dark,
            statusBarColor: Colors.black,
            systemNavigationBarColor: Colors.black
        ),
        backgroundColor: const Color(0xff55598d),
        elevation: 0,
      ),
      body: Center(child:Lottie.network('https://lottie.host/8df19f1f-8418-4ab3-a2b9-fc99541ee690/fqiWuh5S8R.json') ,),



    );
  }

}
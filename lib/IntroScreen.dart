import 'package:flutter/material.dart';
import 'package:graduation_project/plant/login.dart';


class MIModel extends StatefulWidget {
  const MIModel({super.key});

  @override
  State<MIModel> createState() => _MIModelState();
}

class _MIModelState extends State<MIModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Color(0xff55598d) ,
      body:
      Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/images/Introooo.jpg",
              // Replace with the path to your image
              fit: BoxFit.cover,
            ),
          ),
          Column(
            children: [
              SizedBox(height: 80,),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("Welcome to",style:TextStyle(fontSize: 30,
                              fontWeight: FontWeight.normal,color: Colors.black),),
                        ),
                        SizedBox(width: 10,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text("PLANTUM",style:TextStyle(fontSize: 35,
                              fontWeight: FontWeight.bold,color: Colors.black),),
                        )
                      ],
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text("Snap a photo,and get accurate results",style: TextStyle(fontSize: 25,color: Colors.black),),
                    )
                  ],
                ),
              ),
              SizedBox(height:500),
             ElevatedButton(
                 style: ButtonStyle( elevation: MaterialStateProperty.all<double>(0),
                   shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                     RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(40.0),
                     ),
                   ),
                   minimumSize: MaterialStateProperty.all<Size>(
                     const Size(200, 50),
                   ),backgroundColor:MaterialStateProperty.all<Color>(Colors.transparent),
                 ),
                 onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>const LoginScreen()));
                 }
                 , child:Container(decoration:BoxDecoration(
                 gradient: LinearGradient(colors: [
                   Color(0xFF636FA4),
                  Color(0xFF3fada8)
                 ],
                  begin: Alignment.centerLeft,
                   end: Alignment.centerRight,
                 ),
                  borderRadius: BorderRadius.circular(40.0)
                 ),
                  child: Container(
                  constraints: BoxConstraints(
                   maxWidth:330,
                   minHeight: 50
                    ),
                  alignment: Alignment.center,
                  child: const Text(
                   "Get Started",
                   style: TextStyle(
                   fontSize: 20,
                  fontWeight: FontWeight.normal,color: Colors.white // Adjust the font weight as needed
                  ),
                  ),
              ),
             ),

             )

            ],
          ),
        ],
      )
      ,
    );
  }
  navToUploadScreen() {
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => const LoginScreen()),
    );
  }

}


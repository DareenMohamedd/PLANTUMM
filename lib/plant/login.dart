import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/plant/register.dart';
import 'package:graduation_project/plant/uploadScreen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool obscureText = true;

  final  emailController=TextEditingController();
  final  passwordController=TextEditingController();
  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:  PreferredSize(
        preferredSize: Size.fromHeight(56.0), // Adjust the height as needed
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [Color(0xFF636FA4), Color(0xFF3fada8)],
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
            ),
          ),
          child: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0, // Remove the shadow
          ),
        ),
      ),
      backgroundColor:Color(0xff55598d) ,

      body:
      SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  const SizedBox(height: 300),
                  TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      labelStyle: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white,fontSize:20),
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.email,color: Colors.white,),

                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Email required";
                      }
                      if (!value.contains("@") || !value.contains(".")) {
                        return "Invalid email!";
                      }
                      return null;
                    },
                  ),

                  const SizedBox(height: 20,),
                  TextFormField(
                    controller: passwordController,
                    obscureText: obscureText,
                    decoration: InputDecoration(
                      labelText: 'Password',
                      labelStyle: const TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.white,fontSize: 20),
                      border: const OutlineInputBorder(),
                      prefixIcon: const Icon(Icons.lock,color: Colors.white,),
                      suffixIcon: IconButton(
                        onPressed: () {
                          obscureText = !obscureText;
                          setState(() {});
                        },
                        icon:  Icon(
                          obscureText
                            ? Icons.visibility_off
                            : Icons.visibility,color: Colors.white,

                        ),
                      ),
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Password required";
                      }
                      if (value.length < 6) {
                        return "Password must be at least 6 characters";
                      }
                      return null;
                    },

                  ),
                  const SizedBox(height: 10,),

                  Padding(
                    padding: const EdgeInsets.all(10.0),
                    child: Row(
                      children: [
                        Expanded(child:  ElevatedButton(
                          style: ButtonStyle( elevation: MaterialStateProperty.all<double>(0),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                // Adjust the border radius as needed
                              ),


                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(200, 50),
                            ),backgroundColor:MaterialStateProperty.all<Color>(Colors.transparent),

                          ),


                          onPressed: () async {
                            String email = emailController.text;
                            String password = passwordController.text;
                            bool loggedIn = await signIn(email, password);

                            if (loggedIn) {
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const Upload()));
                            } else {
                              // Handle unsuccessful login
                              Fluttertoast.showToast(msg:'Invalid email or password');
                            }
                          },


                          child:Container(decoration:BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF636FA4),
                                Color(0xFF3fada8)

                              ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,

                              ),
                              borderRadius: BorderRadius.circular(30)
                          ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth:330,
                                  minHeight: 50
                              ),
                              alignment: Alignment.center,
                              child: Text("Login",style: TextStyle(
                                  fontSize: 20,color: Colors.white
                              ),
                              ),
                            ),

                          ),
                        ),
                        ),
                        const SizedBox(width: 5,),
                        Expanded(child:  ElevatedButton(
                          style: ButtonStyle( elevation: MaterialStateProperty.all<double>(0),
                            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(40.0),
                                // Adjust the border radius as needed
                              ),


                            ),
                            minimumSize: MaterialStateProperty.all<Size>(
                              const Size(200, 50),
                            ),backgroundColor:MaterialStateProperty.all<Color>(Colors.transparent),

                          ),


                          onPressed: () {
                            Navigator.push(context, MaterialPageRoute(builder: (context) => const RegisterScreen()));
                            // Add your action here
                          },


                          child:Container(decoration:BoxDecoration(
                              gradient: LinearGradient(colors: [
                                Color(0xFF636FA4),
                                Color(0xFF3fada8)

                              ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,

                              ),
                              borderRadius: BorderRadius.circular(30)
                          ),
                            child: Container(
                              constraints: BoxConstraints(
                                  maxWidth:330,
                                  minHeight: 50
                              ),
                              alignment: Alignment.center,
                              child: Text("Register",style: TextStyle(
                                  fontSize: 20,color: Colors.white
                              ),
                              ),
                            ),

                          ),
                        ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

    );
  }

  navToRegisterScreen() {
    Navigator.push(
      context, MaterialPageRoute(builder: (context) => const RegisterScreen()),
    );
  }
  Future<bool> signIn(String emailAddress, String password) async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailAddress,
          password: password
      );
      return true; // Successful login
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found' || e.code == 'wrong-password') {
        return false; // Unsuccessful login
      }
      // Handle other exceptions if needed
      return false;
    }
  }


}
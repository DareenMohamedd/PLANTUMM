import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:graduation_project/plant/login.dart';


class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool obscureText = true;
  final  emailController=TextEditingController();
  final  passwordController=TextEditingController();
  final formKey=GlobalKey<FormState>();
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
            elevation: 0,
            // Remove the shadow
          ),
        ),
      ),
      backgroundColor:Color(0xff55598d) ,
      body:

      SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Container(
                child: Form(
                 key: formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 95),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Name',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.person,color: Colors.white,),

                      ),
                    ),

                    const SizedBox(height: 20,),
                    TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Phone',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.phone,color: Colors.white,),

                      ),

                    ),const SizedBox(height: 20,),
                    TextFormField(
                      controller: emailController,
                      decoration: const InputDecoration(
                        labelText: 'Email',
                        labelStyle: TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
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

                    ),const SizedBox(height: 20,),
                    TextFormField(
                      obscureText: obscureText,
                      controller: passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(fontWeight: FontWeight.bold,color: Colors.white),
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
                    const SizedBox(height: 20,),
                    ElevatedButton(
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
                        bool register = await createAccount(email, password);

                        if (register) {
                          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginScreen()));
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
                          child: Text("Register",style: TextStyle(
                              fontSize: 20,color: Colors.white
                          ),
                          ),
                        ),

                      ),
                    ),
                  ],
                ),
              ),
            ),
            ),
          )
    );
  }
  Future<bool> createAccount(String emailAddress, String password) async {
    try {
      final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailAddress,
        password: password,
      );
      Fluttertoast.showToast(msg: 'Account created successfully');
      Navigator.pop(context);
      return true; // Account creation succeeded
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
        Fluttertoast.showToast(msg: 'The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
        Fluttertoast.showToast(msg: 'The account already exists for that email.');
      }
      return false; // Account creation failed
    } catch (e) {
      print(e);
      return false; // Account creation failed
    }
  }
  void register() {
    if (!formKey.currentState!.validate()) {
      return;
    }
  }
  void displayToast(String message) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_LONG,
      gravity: ToastGravity.CENTER,
      backgroundColor: Colors.green,
      textColor: Colors.white,
      fontSize: 16.0,
    );
  }

}
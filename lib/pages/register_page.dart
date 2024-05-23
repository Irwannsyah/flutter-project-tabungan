import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:project_tabungan/components/button.dart';
import 'package:project_tabungan/components/textfield.dart';
import 'package:project_tabungan/helper/helper_function.dart';

class RegisterPage extends StatefulWidget {
  final Function()? onTap;

  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPwController = TextEditingController();

  void registerUser() async {
    //show loading circles
    showDialog(
      context: context,
      builder: (context) => const Center(
        child: CircularProgressIndicator(),
      ),
    );

    //make sure password match
    if (passwordController.text != confirmPwController.text) {
      //pop loading circle
      Navigator.pop(context);
      //show error message to user
      displayMessageToUser("password dont match!", context);
    } else {
      try {
        UserCredential? userCredential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        createUserDocument(userCredential);

        //pop loading circle
        // ignore: use_build_context_synchronously
        if (context.mounted) Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        //pop loading cicle
        Navigator.pop(context);
        //display error to user
        displayMessageToUser(e.code, context);
      }
    }
  }

  Future<void> createUserDocument(UserCredential? userCredential) async {
    if (userCredential != null && userCredential.user != null) {
      await FirebaseFirestore.instance
          .collection("Users")
          .doc(userCredential.user!.email)
          .set({
        'email': userCredential.user!.email,
        'username': usernameController.text,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(
                height: 20,
              ),
              //appname
              const Text(
                "T A B U N G A N KU",
                style: TextStyle(fontSize: 20),
              ),
              const SizedBox(
                height: 20,
              ),
              //email Textfield
              MyTextField(
                  hintText: "Username",
                  obsecureText: false,
                  controller: usernameController),
              const SizedBox(
                height: 10,
              ),
              MyTextField(
                  hintText: "Email",
                  obsecureText: false,
                  controller: emailController),

              const SizedBox(
                height: 10,
              ),
              //password
              MyTextField(
                  hintText: "Password",
                  obsecureText: true,
                  controller: passwordController),

              const SizedBox(
                height: 10,
              ),
              //password
              MyTextField(
                  hintText: "confirm password",
                  obsecureText: true,
                  controller: confirmPwController),

              const SizedBox(height: 5),
              //forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.secondary),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              //sign in button
              MyButton(
                text: "Register",
                onTap: registerUser,
              ),

              const SizedBox(
                height: 15,
              ),
              //dont have an account? register here
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "already have an account?",
                    style: TextStyle(
                        color: Theme.of(context).colorScheme.inversePrimary),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: const Text(
                      " Login Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

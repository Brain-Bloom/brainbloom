import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:brainbloom/textField.dart';
import 'package:brainbloom/RegistrationPage.dart';
import 'package:brainbloom/mainPage.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  bool usernameHasError = false;
  TextEditingController passwordController = TextEditingController();
  bool passwordHasError = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text('Brainbloom',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      fontStyle: FontStyle.normal,
                      fontFamily: 'Roboto')),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: MyTextField(
                    textEditingController: usernameController,
                    hasError: usernameHasError,
                    hintText: "Identifiant",
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                  width: MediaQuery.of(context).size.width * 0.3,
                  child: MyTextField(
                    textEditingController: passwordController,
                    hasError: passwordHasError,
                    hintText: "Mot de passe",
                    passwordField: true,
                  )),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      usernameHasError = usernameController.text.isEmpty;
                      passwordHasError = passwordController.text.isEmpty;
                    });

                    // Vérifier si les champs sont remplis avant de naviguer
                    if (!usernameHasError && !passwordHasError) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => MainPage(),
                        ),
                      );
                    }
                  },
                  child: const Text('Se connecter',
                      style: TextStyle(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold))),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Vous n\'avez pas de compte? '),
                  SizedBox(height: MediaQuery.of(context).size.width * 0.002),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegistrationPage(),
                          ),
                        );
                      },
                      child: const Text('Inscrivez-vous',
                          style: TextStyle(color: Colors.blue)))
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}

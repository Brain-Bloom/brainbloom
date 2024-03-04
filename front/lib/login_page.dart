import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:brainbloom/textField.dart';
import 'package:brainbloom/RegistrationPage.dart';
class LoginPage extends StatefulWidget {

  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage>{

  TextEditingController usernameController = TextEditingController();
  bool usernameHasError = false;
  TextEditingController passwordController = TextEditingController();
  bool passwordHasError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(



    body: Container (
      //mettre une image en background
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
              const Text('Brainbloom', style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, fontStyle: FontStyle.normal, fontFamily: 'Roboto')),
              SizedBox(height: MediaQuery.of(context).size.height*0.02),

              SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: MyTextField(
                    textEditingController: usernameController,
                    hasError: usernameHasError,
                    hintText: "Identifiant",
                  )
              ),

              // mettre de l'espace entre les deux champs de texte
              SizedBox(height: MediaQuery.of(context).size.height*0.02),




              SizedBox(
                  width: MediaQuery.of(context).size.width*0.3,
                  child: MyTextField(
                    textEditingController: passwordController,
                    hasError: passwordHasError,
                    hintText: "Mot de passe",

                    passwordField: true,
                  )
              ),

              // mettre un bouton se connecter avec la police de caractère en gras

              SizedBox(height: MediaQuery.of(context).size.height*0.02),

              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      usernameHasError = usernameController.text.isEmpty;
                      passwordHasError = passwordController.text.isEmpty;
                    });
                  },
                  // la police se connecter doit etre en noir
                  child: const Text('Se connecter', style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold))
              ),

              SizedBox(height: MediaQuery.of(context).size.height*0.02),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Vous n\'avez pas de compte? '),
                  SizedBox(height: MediaQuery.of(context).size.width*0.002),
                  InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => RegistrationPage()),
                        );


                        // mettre le texte en bleu
                      },
                      child: const Text('Inscrivez-vous', style: TextStyle(color: Colors.blue))
                  )
                ],


              )





            ],


          )
      ),

    )
    );
  }


}
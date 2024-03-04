import 'package:brainbloom/MyDropdownButton.dart';
import 'package:flutter/material.dart';
import 'package:brainbloom/textField.dart';


class RegistrationPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Inscription'),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/background.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'Inscription',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: TextEditingController(),
                    hintText: 'Adresse email',
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: TextEditingController(),
                    hintText: 'Mot de passe',
                    hasError: false,
                    passwordField: true,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: TextEditingController(),
                    hintText: 'Date de naissance',
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: TextEditingController(),
                    hintText: 'Sexe',
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: TextEditingController(),
                    hintText: 'Profession',
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyDropdownButton(
                    hint: 'Niveau d\'éducation',
                    items: [
                      'High School',
                      'Bachelor Degree',
                      'Master Degree',
                      'PhD'
                    ],
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: TextEditingController(),
                    hintText: 'Cours souhaité',
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyDropdownButton(
                    hint: 'Niveau du cours',
                    items: ['Débutant', 'Intermédiaire', 'Avancé'],
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Ajouter le code pour traiter l'inscription
                  },
                  child: Text('S\'inscrire'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

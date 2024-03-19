import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:brainbloom/mainPage.dart';
import 'package:brainbloom/RegistrationPage.dart';
import 'package:brainbloom/textField.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool usernameHasError = false;
  bool passwordHasError = false;

  Future<void> login() async {
    String username = usernameController.text;
    String password = passwordController.text;

    var url = Uri.parse('https://zs1zk36dyj.execute-api.eu-west-1.amazonaws.com/Prod/userList?username=$username');
    var response = await http.get(url);

    if (response.statusCode == 200) {
      print(response.body);

      // Check the content type of the response
      if (response.headers['content-type'] == 'application/json') {
        // Parse response body only if content type is JSON
        var data = jsonDecode(response.body);
        if (data == "L'utilisateur avec le nom d'utilisateur '${username}' n'est pas dans la base.") {
          showErrorMessage();
        } else {
          String actualUsername = data['username'];
          String actualPassword = data['password'];

          if (username == actualUsername && password == actualPassword) {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MainPage(username: username, desiredCourse: data['desired_course'], level_of_course: data['level_of_course'], level_of_education: data['level_of_education']),
              ),
            );
          } else {
            showErrorMessage();
          }
        }
      } else {
        // Handle non-JSON response
        showErrorMessage();
      }
    } else {
      print(response.body);

      // Handle HTTP error status codes
      showErrorMessage();
    }
  }

  void showErrorMessage() {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Incorrect username or password')),
    );
  }

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
              const Text(
                'Brainbloom',
                style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  fontStyle: FontStyle.normal,
                  fontFamily: 'Roboto',
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: MyTextField(
                  textEditingController: usernameController,
                  hasError: usernameHasError,
                  hintText: "Username",
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.3,
                child: MyTextField(
                  textEditingController: passwordController,
                  hasError: passwordHasError,
                  hintText: "Password",
                  passwordField: true,
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    usernameHasError = usernameController.text.isEmpty;
                    passwordHasError = passwordController.text.isEmpty;
                  });

                  if (!usernameHasError && !passwordHasError) {
                    login();
                  }
                },
                child: const Text(
                  'Login',
                  style: TextStyle(
                    color: Colors.black87,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 0.02),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Don\'t have an account? '),
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
                    child: const Text(
                      'Sign Up',
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

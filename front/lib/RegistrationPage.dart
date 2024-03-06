import 'package:flutter/material.dart';
import 'package:brainbloom/textField.dart';
import 'package:brainbloom/MyDropdownButton.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;


class RegistrationPage extends StatelessWidget {


  final TextEditingController usernameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController dateOfBirthController = TextEditingController();
  final TextEditingController genderController = TextEditingController();
  final TextEditingController professionController = TextEditingController();
  late String educationLevel;
  late String desiredCourse;
  late String courseLevel;

  Future<void> _register() async {

    String username = usernameController.text;
    final url = 'https://zs1zk36dyj.execute-api.eu-west-1.amazonaws.com/Prod/userList?username=$username'; // Remplacez YOUR_API_ENDPOINT par l'URL de votre API Gateway
    print(username);
    final response = await http.put(
      Uri.parse(url),
      body: json.encode({
        'username': usernameController.text,
        'password': passwordController.text,
        'date_of_birth': dateOfBirthController.text,
        'gender': genderController.text,
        'profession': professionController.text,
        'level_of_education': educationLevel,
        'desired_course': desiredCourse,
        'level_of_course': courseLevel,
      }),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      print(response.request);
      print(response.body);
      print(response.statusCode);
      // Enregistrement réussi
      print('Enregistrement réussi!');
    } else {
      // Échec de l'enregistrement
      print(response.request);
      print(response.body);
      print(response.statusCode);

    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registration'),
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
                  'Registration',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: usernameController,
                    hintText: 'Username',
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: passwordController,
                    hintText: 'Password',
                    hasError: false,
                    passwordField: true,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: dateOfBirthController,
                    hintText: 'Date of Birth',
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: genderController,
                    hintText: 'Gender',
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyTextField(
                    textEditingController: professionController,
                    hintText: 'Profession',
                    hasError: false,
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                child : MyDropdownButton(
                  hint: 'Education Level',
                  items: ['High School', 'Bachelor Degree', 'Master Degree', 'PhD'],
                  hasError: false,
                  onChanged: (value) {
                    educationLevel = value;
                  },
                ),

                ),



                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyDropdownButton(
                    hint: 'Desired Course',
                    items: [
                      "Data Science", "Web Development", "Business Analytics",
                      "Python Programming", "Artificial Intelligence", "Photography",
                      "Marketing", "History", "Psychology", "Sociology",
                      "Physics", "Biology", "Philosophy", "Environmental Science",
                      "Mathematics", "Cooking", "Music", "Fashion Design", "Languages",
                      "Graphic Design", "Digital Marketing", "Chemistry", "Astrophysics",
                      "Game Development", "Machine Learning", "Blockchain", "Finance",
                      "Health and Fitness", "Robotics", "Economics", "Cryptocurrency",
                      "Travel", "Creative Writing", "Philanthropy", "Film Production",
                      "Political Science", "Gardening", "Yoga", "Neuroscience",
                      "Mobile App Development", "Cybersecurity", "3D Printing", "Virtual Reality",
                      "Interior Design", "Culinary Arts", "Animation", "DIY Crafts",
                      "Space Exploration", "Renewable Energy", "Urban Planning", "Marine Biology",
                      "Art History", "Medicine", "Astronomy", "Geology", "Anthropology",
                      "Archaeology", "Computer Science", "Literature", "Sustainable Living",
                      "Social Media Management", "Ethical Hacking", "Public Speaking", "Business Strategy",
                      "Fashion Styling", "Game Design", "Quantum Mechanics", "Educational Technology",
                      "Human Rights", "Climate Change", "Wildlife Conservation", "Futurism",
                      "Data Visualization", "Biotechnology", "Sports Science", "Theater Arts",
                      "Mobile Photography", "User Experience Design", "Data Ethics", "Augmented Reality",
                      "Renewable Technology", "Bioinformatics", "Educational Psychology", "Behavioral Economics",
                      "Virtual Assistant Development", "Science Fiction Literature", "Blockchain Applications",
                      "Personal Finance Management", "Mental Health Awareness", "Cryptocurrency Trading", "Health Informatics",
                      "Environmental Sustainability", "Fintech Innovations", "Green Architecture", "Marine Conservation",
                      "Social Entrepreneurship", "Inclusive Design", "Mindfulness Practices", "Remote Sensing Technology",
                      "Aerospace Engineering", "Quantum Computing", "Natural Language Processing", "Disaster Management",
                      "Quantum Biology", "Social Justice Issues", "Renewable Energy Policy", "Molecular Gastronomy",
                      "Ethical Fashion", "Community Gardening", "Home Automation", "DIY Home Decor",
                      "Artificial General Intelligence", "Exoplanet Exploration", "Behavioral Ecology",
                      "Renewable Energy Entrepreneurship",
                      "Neuroaesthetics", "Educational Gamification", "Biohacking", "Sustainable Fashion Design",
                      "Space Tourism", "Cognitive Neuroscience", "Edible Insect Farming", "Personalized Medicine"
                    ],
                    hasError: false,
                    onChanged: (value) {
                      desiredCourse = value;
                    },
                  ),
                ),
                SizedBox(height: 20.0),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.6,
                  child: MyDropdownButton(
                    hint: 'Course Level',
                    items: ['Beginner', 'Intermediate', 'Advanced'],
                    hasError: false,
                    onChanged: (value) {
                      courseLevel = value;
                    },
                  ),
                ),

                SizedBox(height: 20.0),
                ElevatedButton(
                  onPressed: () {
                    // Add code to handle registration
                    _register();
                  },
                  child: Text('Register'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:url_launcher/url_launcher.dart';
import 'package:brainbloom/login_page.dart';

void main() {
  runApp(MaterialApp(
    home: LoginPage(),
  ));
}

class MainPage extends StatefulWidget {
  final String username;
  final String desiredCourse;
  final String level_of_course;
  final String level_of_education;

  MainPage({
    Key? key,
    required this.username,
    required this.desiredCourse,
    required this.level_of_course,
    required this.level_of_education,
  }) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  List<Course> recommendedCourses = [];
  List<Course> randomCourses = [];
  List<Course> clickedCourses = [];
  List<Course> otherRecommendedCourses = []; // New list for other recommended courses

  @override
  void initState() {
    super.initState();
    fetchRecommendedCourses(widget.username);
    fetchRandomCoursesFromLink();
  }

  Future<void> fetchRecommendedCourses(String username) async {
    final uri = Uri.parse('http://127.0.0.1:5000/recommandation-skills/$username');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> coursesJson = json.decode(response.body);

      setState(() {
        recommendedCourses = coursesJson
            .map((courseJson) => Course.fromJson(courseJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load recommended courses');
    }
  }

  Future<void> fetchRandomCoursesFromLink() async {
    final link = 'http://127.0.0.1:5000/cours-dynamo';
    final response = await http.get(Uri.parse(link));

    if (response.statusCode == 200) {
      List<dynamic> coursesJson = json.decode(response.body);

      setState(() {
        randomCourses = coursesJson
            .map((courseJson) => Course.fromJson(courseJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load random courses from link');
    }
  }

  void addClickedCourse(Course course) {
    setState(() {
      clickedCourses.add(course);
    });
    fetchOtherRecommendedCourses(course.courseUrl); // Fetch other recommended courses when a course is clicked
  }

  Future<void> fetchOtherRecommendedCourses(String courseUrl) async {
    final uri = Uri.parse('http://127.0.0.1:5000/recommandation-url/$courseUrl');
    final response = await http.get(uri);

    if (response.statusCode == 200) {
      List<dynamic> coursesJson = json.decode(response.body);

      setState(() {
        otherRecommendedCourses = coursesJson
            .map((courseJson) => Course.fromJson(courseJson))
            .toList();
      });
    } else {
      throw Exception('Failed to load other recommended courses');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        title: Text('Login'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          Padding(
            padding: const EdgeInsets.only(left: 2.0),
            child: IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ProfilePage(
                      username: widget.username,
                      desiredCourse: widget.desiredCourse,
                      level_of_course: widget.level_of_course,
                      level_of_education: widget.level_of_education,
                      clickedCourses: clickedCourses, // Pass clickedCourses to ProfilePage
                      otherRecommendedCourses: otherRecommendedCourses, // Pass otherRecommendedCourses to ProfilePage
                    ),
                  ),
                );
              },
              padding: EdgeInsets.only(right: 50.0),
            ),
          ),
        ],
      ),
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(56.0, kToolbarHeight + 56.0, 56.0, 56.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(right: 56.0),
                      child: Text(
                        'Recommended Courses',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: recommendedCourses.map((course) {
                      return CourseTile(
                        title: course.courseName,
                        url: course.courseUrl,
                        onTap: () {
                          addClickedCourse(course); // Add clicked course to clickedCourses
                          _launchURL(course.courseUrl); // Launch URL
                        },
                      );
                    }).toList(),
                  ),
                  SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Padding(
                      padding: EdgeInsets.only(right: 56.0),
                      child: Text(
                        'Random Courses',
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Column(
                    children: randomCourses.map((course) {
                      return CourseTile(
                        title: course.courseName,
                        url: course.courseUrl,
                        onTap: () {
                          addClickedCourse(course); // Add clicked course to clickedCourses
                          _launchURL(course.courseUrl); // Launch URL
                        },
                      );
                    }).toList(),
                  ),
                  if (otherRecommendedCourses.isNotEmpty)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20),
                        Text(
                          'Other courses in the same field:',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: otherRecommendedCourses.map((course) {
                            return CourseTile(
                              title: course.courseName,
                              url: course.courseUrl,
                              onTap: () {
                                addClickedCourse(course); // Add clicked course to clickedCourses
                                _launchURL(course.courseUrl); // Launch URL
                              },
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class CourseTile extends StatelessWidget {
  final String title;
  final String url;
  final VoidCallback onTap; // Callback for onTap

  CourseTile({required this.title, required this.url, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5.0),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
      ),
      child: ListTile(
        title: Text(title),
        onTap: onTap, // Call the onTap callback
      ),
    );
  }
}

class Course {
  final String courseName;
  final String courseUrl;

  Course({required this.courseName, required this.courseUrl});

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      courseName: json['course_name'],
      courseUrl: json['course_url'],
    );
  }
}

class ProfilePage extends StatefulWidget {
  final String username;
  final String desiredCourse;
  final String level_of_course;
  final String level_of_education;
  final List<Course> clickedCourses; // Receive clickedCourses
  final List<Course> otherRecommendedCourses; // Receive otherRecommendedCourses

  ProfilePage({
    required this.username,
    required this.desiredCourse,
    required this.level_of_course,
    required this.level_of_education,
    required this.clickedCourses, // Receive clickedCourses
    required this.otherRecommendedCourses, // Receive otherRecommendedCourses
  });

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Profile'),
        backgroundColor: Colors.transparent, // Make the app bar transparent
        elevation: 0, // Remove app bar shadow
      ),
      extendBodyBehindAppBar: true, // Allow background to extend behind app bar
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: kToolbarHeight),
                Text(
                  'Username: ${widget.username}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  'Desired Course: ${widget.desiredCourse}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  'Level of Course: ${widget.level_of_course}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 10),
                Text(
                  'Level of Education: ${widget.level_of_education}',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(height: 20),
                Text(
                  'My Courses:',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: widget.clickedCourses.map((course) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 5.0),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          border: Border.all(color: Colors.grey),
                        ),
                        child: InkWell(
                          onTap: () => _launchURL(course.courseUrl),
                          child: Text(
                            course.courseName,
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),

              ],
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _launchURL(String url) async {
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    throw "Unable to open the URL: $url";
  }
}

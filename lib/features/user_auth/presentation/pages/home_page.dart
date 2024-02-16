import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/profile.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/search_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/course1_details_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/course2_details_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/wishlist.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;

  List<String> courseImages = [
    'assets/images/course_1.jpg',
    'assets/images/course_2.png',
    'assets/images/course_3.png',
    'assets/images/course_4.png',
    'assets/images/course_5.png',
  ];

  List<String> courseTitles = [
    'Node.js, Express, MongoDB',
    'Flutter & Dart-The Complete Guide',
    'Learn JAVA Programming',
    'React JS - Complete Guide',
    'The Complete Python Developer',
  ];

  List<String> courseDescriptions = [
    'Jonas Schmedtmann',
    'Stephan Grider',
    'EdYoda Digital University',
    'Andrei Neagoie',
    'Yihua Zhang',
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });

    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => SearchPage()),
      );
    } else if (index == 3) { // Index 4 corresponds to the Profile icon
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => WishlistPage()),
      );
    }else if (index == 4) { // Index 4 corresponds to the Profile icon
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),
      );
    }
  }

  void _navigateToCourseDetailsPage(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          if (index == 0) {
            return Course1DetailsPage();
          } else if (index == 1) {
            return Course2DetailsPage();
          } else {
            // Handle other indices if needed
            return Container(); // Placeholder, you can return a different page or null
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Welcome, Aaditi Vaibhav Surve',
          style: TextStyle(color: Colors.white, fontSize: 17.0),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/images/home.jpg',
              height: 200,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Learning that fits',
                style: TextStyle(
                  color: Colors.white,
                  fontFamily: 'Montserrat',
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 7),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Skills for your present (and future)',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Learning for your career?',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(height: 7),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Answer two quick questions for recommendations that match your career goals.',
                style: TextStyle(color: Colors.white),
              ),
            ),
            const SizedBox(height: 25),
            const Padding(
              padding: EdgeInsets.only(left: 16.0),
              child: Text(
                'Recommended for you',
                style: TextStyle(color: Colors.white, fontSize: 22.0, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: List.generate(
                  courseImages.length,
                      (index) => GestureDetector(
                    onTap: () {
                      _navigateToCourseDetailsPage(index);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 300,
                            height: 200,
                            decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(10.0),
                            ),
                            child: Image.asset(
                              courseImages[index],
                              width: 300,
                              height: 180,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            courseTitles[index],
                            style: TextStyle(color: Colors.white, fontSize: 20.0),
                          ),
                          Text(
                            courseDescriptions[index],
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        selectedIconTheme: const IconThemeData(color: Colors.white),
        selectedLabelStyle: const TextStyle(color: Colors.white),
        unselectedIconTheme: const IconThemeData(color: Colors.grey),
        unselectedLabelStyle: const TextStyle(color: Colors.grey),
        iconSize: 26.0,
        selectedFontSize: 14.0,
        unselectedFontSize: 12.0,
        currentIndex: 0,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Featured'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: 'My Learning'),
          BottomNavigationBarItem(
              icon: Icon(Icons.heart_broken), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

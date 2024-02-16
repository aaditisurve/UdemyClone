import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/login_page.dart';

class ProfilePage extends StatelessWidget {
  void _signOut(BuildContext context) async {
    try {
      await FirebaseAuth.instance.signOut(); // Sign out the user
      // Navigate to the login page
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => LoginPage()));
    } catch (e) {
      print('Error signing out: $e');
      // Handle sign-out error
      // Show a snackbar, toast, or dialog to inform the user about the error
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.black,
      ),
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 20),
            CircleAvatar(
              radius: 75,
              backgroundColor: Colors.black,
              child: Icon(
                Icons.account_circle,
                size: 150,
                color: Colors.white,
              ),
            ),
            SizedBox(height: 10),
            Text(
              'Aaditi',
              style: TextStyle(fontSize: 24, color: Colors.white),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.account_box,
                  size: 20,
                  color: Colors.grey,
                ),
                SizedBox(width: 10),
                Text(
                  '2021.aaditi.surve@ves.ac.in',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ],
            ),
            SizedBox(height: 10),
            Text(
              'Become an instructor',
              style: TextStyle(fontSize: 16, color: Colors.purpleAccent),
            ),
            SizedBox(height: 20),
            OptionWidget(text: 'Download options'),
            OptionWidget(text: 'Video playback options'),
            OptionWidget(text: 'Career goal'),
            OptionWidget(text: 'Account Security'),
            OptionWidget(text: 'Email notification preferences'),
            OptionWidget(text: 'Learning reminders'),
            OptionWidget(text: 'About Udemy'),
            OptionWidget(text: 'About Udemy Business'),
            OptionWidget(text: 'Frequently asked questions'),
            OptionWidget(text: 'Share the Udemy App'),
            OptionWidget(text: 'Status'),
            // Add more OptionWidget instances for other options
            SizedBox(height: 15),
            ElevatedButton(
              onPressed: () {
                _signOut(context); // Call the sign-out method
              },
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.black), // Set button background color to black
              ),
              child: Text(
                'Sign Out',
                style: TextStyle(color: Colors.purpleAccent, fontSize: 18.0, fontWeight: FontWeight.bold),
              ),
            ),

            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}

class OptionWidget extends StatelessWidget {
  final String text;

  const OptionWidget({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.black,
      ),
      child: Row(
        children: [
          Expanded(
            child: Text(
              text,
              style: TextStyle(fontSize: 18, color: Colors.white),
            ),
          ),
          Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Course2DetailsPage extends StatefulWidget {
  @override
  _Course2DetailsPageState createState() => _Course2DetailsPageState();
}

class _Course2DetailsPageState extends State<Course2DetailsPage> {
  final CollectionReference wishlistCollection =
  FirebaseFirestore.instance.collection('Wishlist');
  late VideoPlayerController _controller;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://youtu.be/1ukSR1GRtMU?si=gspKKqj3p1YdVTpl'),
    )..initialize().then((_) {
      setState(() {}); // Update the state once the video is initialized
    });

    _youtubeController = YoutubePlayerController(
      initialVideoId: '1ukSR1GRtMU',
      flags: YoutubePlayerFlags(
        autoPlay: false,
      ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    _youtubeController.dispose();
    super.dispose();
  }

  void addToWishlist(BuildContext context) async {
    try {
      // Check if the course already exists in the wishlist
      QuerySnapshot querySnapshot = await wishlistCollection.where('course_name', isEqualTo: 'Flutter & Dart - The Complete Guide [2024 Edition]').get();
      if (querySnapshot.docs.isNotEmpty) {
        // Course already exists in the wishlist
        showErrorMessage(context, 'Course already exists in the wishlist');
        return;
      }

      // If the course does not exist, add it to the wishlist
      await wishlistCollection.add({
        'course_name': 'Flutter & Dart - The Complete Guide [2024 Edition]',
        'author': 'Academind by Maximilian Schwarz',
        'price': 29.99,
        'ratings': 4.5,
      });

      // Show success message using ScaffoldMessenger
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Course added to wishlist')),
      );
    } catch (e) {
      // Show error message using ScaffoldMessenger
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to add course to wishlist: $e')),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter & Dart', style: TextStyle(color: Colors.white),),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image of the course
              Stack(
                alignment: Alignment.center,
                children: [
                  Image.asset(
                    'assets/images/course_2.png',
                    width: MediaQuery.of(context).size.width,
                    height: 200,
                    fit: BoxFit.cover,
                  ),
                  GestureDetector(
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AlertDialog(
                            content: Container(
                              width: double.infinity,
                              child: YoutubePlayer(
                                controller: _youtubeController,
                                showVideoProgressIndicator: true,
                                progressIndicatorColor: Colors.red,
                                progressColors: ProgressBarColors(
                                  playedColor: Colors.red,
                                  handleColor: Colors.redAccent,
                                ),
                                onReady: () {
                                  _youtubeController.play();
                                },
                              ),
                            ),
                          );
                        },
                      );
                    },
                    child: Icon(
                      Icons.play_circle_outline,
                      size: 50,
                      color: Colors.black,
                    ),
                  ),
                  Positioned(
                    bottom: 8,
                    child: Text(
                      'Preview this course',
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 17,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 20),
              // Title of the course
              Text(
                'Flutter & Dart - The Complete Guide [2024 Edition]',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              // Description of the course
              Text(
                'A Complete Guide to the Flutter SDK &amp; Flutter Framework for building native iOS and Android apps',
                style: TextStyle(fontSize: 18, color: Colors.grey[500]),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  Text(
                    'Created by ',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    'Academind by Maximilian Schwarz',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.purpleAccent,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 5),
              // Bestseller box
              Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Color(0xFFFFF9C4), // Customize the color as needed
                  borderRadius: BorderRadius.circular(5),
                ),
                child: Text(
                  'Bestseller',
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
              ),
              SizedBox(height: 5),
              // Rating of the course with star icons
              Row(
                children: [
                  Text(
                    '4.5', // Rating value
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                      width: 5), // Add space between rating number and stars
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star, color: Colors.yellow),
                  Icon(Icons.star_half, color: Colors.yellow),
                ],
              ),
              SizedBox(height: 5),
              Text(
                '(72965 ratings) 293964 students',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 25),
              // Price of the course
              Text(
                '\$29.99',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
              // Buy Now button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Implement Buy Now functionality
                  },
                  child: Text(
                    'Buy Now',
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                    ),
                    backgroundColor: Colors.purpleAccent,
                  ),
                ),
              ),
              SizedBox(height: 10),
              // Add to Cart button
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    // Add the course to the cart
                    addToWishlist(context);

                    // Show success message
                    showSuccessMessage(context, 'Course added to wishlist');
                  },
                  child: Text(
                    'Add to Wishlist',
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(2),
                      side: BorderSide(
                        color: Colors.white, // Border color
                        width: 2, // Border width
                      ),
                    ),
                    backgroundColor: Colors.black,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  void showSuccessMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Success'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
  void showErrorMessage(BuildContext context, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Error'),
          content: Text(message),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

}

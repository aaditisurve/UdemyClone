import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class Course1DetailsPage extends StatefulWidget {
  @override
  _Course1DetailsPageState createState() => _Course1DetailsPageState();
}

class _Course1DetailsPageState extends State<Course1DetailsPage> {
  final CollectionReference wishlistCollection =
  FirebaseFirestore.instance.collection('Wishlist');
  late VideoPlayerController _controller;
  late YoutubePlayerController _youtubeController;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.networkUrl(
      Uri.parse('https://youtu.be/yEHCfRWz-EI?si=gpoEN2MAhqrzbZCT'),
    )..initialize().then((_) {
      setState(() {}); // Update the state once the video is initialized
    });


    _youtubeController = YoutubePlayerController(
      initialVideoId: 'yEHCfRWz-EI',
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
      QuerySnapshot querySnapshot = await wishlistCollection.where('course_name', isEqualTo: 'Node.js, Express, MongoDB & More: The Complete Bootcamp 2024').get();
      if (querySnapshot.docs.isNotEmpty) {
        // Course already exists in the wishlist
        showErrorMessage(context, 'Course already exists in the wishlist');
        return;
      }

      // If the course does not exist, add it to the wishlist
      await wishlistCollection.add({
        'course_name': 'Node.js, Express, MongoDB & More: The Complete Bootcamp 2024',
        'author': 'Jonas Schmedtmann',
        'price': 19.99,
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
        title: Text('Node.js, Express, MongoDB', style: TextStyle(color: Colors.white)),
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
                    'assets/images/course_1.jpg',
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
                'Node.js, Express, MongoDB & More: The Complete Bootcamp 2024',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 5),
              // Description of the course
              Text(
                'Master Node by building a real-world RESTful API and web app (with authentication, Node.js security, payments & more)',
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
                    'Jonas Schmedtmann',
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
                '(22,383 ratings) 136,141 students',
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 25),
              // Price of the course
              Text(
                '\$19.99',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 10),
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

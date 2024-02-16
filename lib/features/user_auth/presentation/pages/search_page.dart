import 'package:flutter/material.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/home_page.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/profile.dart';
import 'package:flutter_firebase/features/user_auth/presentation/pages/wishlist.dart';

class SearchPage extends StatefulWidget {
  @override
  _SearchPageState createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  List<String> boxTexts = [
    'Python',
    'Java',
    'Dart',
    'Flutter',
    'React',
    'Angular',
    'C++',
    'Ruby',
    'Swift',
    'Kotlin',
    'HTML',
    'CSS'
  ];

  List<String> categories = [
    'Development',
    'Business',
    'Design',
    'Technology',
    'Finance',
    'Education',
    'Health',
    'Food',
    'Sports',
    'Entertainment'
  ];

  List<String> filteredCourses = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: TextField(
          onChanged: (value) {
            // Filter courses based on search query
            setState(() {
              filteredCourses = boxTexts
                  .where((course) =>
                  course.toLowerCase().contains(value.toLowerCase()))
                  .toList();
            });
          },
          style: TextStyle(color: Colors.white),
          decoration: InputDecoration(
            hintText: 'Search',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Top Searches',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 4,
              children: List.generate(
                filteredCourses.isNotEmpty
                    ? filteredCourses.length
                    : boxTexts.length,
                    (index) {
                  String text = filteredCourses.isNotEmpty
                      ? filteredCourses[index]
                      : boxTexts[index];
                  return Container(
                    margin: EdgeInsets.all(8),
                    width: 60, // Adjust the width here
                    height: 20 + (text.length * 2.0), // Adjust the height based on text length
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Center(
                      child: Text(
                        text,
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'Browse Categories',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
          ),
          SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: categories.length,
              itemBuilder: (context, index) {
                String category = categories[index];
                return ListTile(
                  title: Text(
                    category,
                    style: TextStyle(color: Colors.white),
                  ),
                  trailing: Icon(Icons.arrow_forward_ios,
                      color: Colors.white),
                );
              },
            ),
          ),
        ],
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
        currentIndex: 1, // Set the index for the "Search" option
        onTap: (index) {
          // Handle bottom navigation bar taps
          if (index == 0) { // Check if "Featured" icon is tapped (assuming it's at index 0)
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => HomePage()),
            );
          }else if(index==3){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => WishlistPage()),
            );
          }else if(index==4){
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ProfilePage()),
            );
          }
        },
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Featured'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(
              icon: Icon(Icons.school), label: 'My Learning'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: 'Wishlist'),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: SearchPage(),
  ));
}

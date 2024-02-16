
import 'package:flutter/material.dart';

class CartPage extends StatefulWidget {
  final List<String> cartItems;

  CartPage(this.cartItems);

  @override
  _CartPageState createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Shopping Cart', style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.black,
      ),
      body: Container(
        color: Colors.black, // Set background color for the Scaffold
        child: ListView.builder(
          itemCount: widget.cartItems.length,
          itemBuilder: (context, index) {
            final String courseName = widget.cartItems[index];

            return Dismissible(
              key: Key(courseName),
              direction: DismissDirection.endToStart,
              background: Container(
                color: Colors.red,
                alignment: Alignment.centerRight,
                padding: EdgeInsets.only(right: 16.0),
                child: Icon(Icons.delete, color: Colors.white),
              ),
              onDismissed: (direction) {
                setState(() {
                  widget.cartItems.removeAt(index);
                });

                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("$courseName removed from cart"),
                    duration: Duration(seconds: 2),
                  ),
                );
              },
              child: ListTile(
                title: Text(courseName, style: TextStyle(color: Colors.white)),
              ),
            );
          },
        ),
      ),
    );
  }
}

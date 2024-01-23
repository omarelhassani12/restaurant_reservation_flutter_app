import 'package:flutter/material.dart';

import 'details_food_type.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'The WULI Restaurant',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              'Choose a type of food',
              style: TextStyle(
                fontSize: 12,
                color: Color.fromARGB(255, 168, 168, 168),
              ),
            ),
          ],
        ),
        actions: <Widget>[
          // Add a search icon
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              // Handle search icon press
            },
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16.0),
        children: <Widget>[
          FoodTypeCard(
            title: 'Chinese Food',
            subtitle: 'Delicious Chinese dishes',
            onTap: () {
              _navigateToDetails(context, 'Chinese Food');
            },
          ),
          FoodTypeCard(
            title: 'Egyptian Food',
            subtitle: 'Authentic Egyptian flavors',
            onTap: () {
              _navigateToDetails(context, 'Egyptian Food');
            },
          ),
          FoodTypeCard(
            title: 'Italian Food',
            subtitle: 'Classic Italian cuisine',
            onTap: () {
              _navigateToDetails(context, 'Italian Food');
            },
          ),
          FoodTypeCard(
            title: 'Moroccan Food',
            subtitle: 'Rich Moroccan spices',
            onTap: () {
              _navigateToDetails(context, 'Moroccan Food');
            },
          ),
          FoodTypeCard(
            title: 'Turkish Food',
            subtitle: 'Traditional Turkish delights',
            onTap: () {
              _navigateToDetails(context, 'Turkish Food');
            },
          ),
          // Add more cards for other types of food
        ],
      ),
    );
  }

  void _navigateToDetails(BuildContext context, String foodType) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => FoodDetailsScreen(foodType: foodType),
      ),
    );
  }
}

class FoodTypeCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const FoodTypeCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      elevation: 3.0,
      child: ListTile(
        title: Text(title),
        subtitle: Text(subtitle),
        onTap: onTap,
      ),
    );
  }
}

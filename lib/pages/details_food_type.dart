import 'package:flutter/material.dart';

class FoodDetailsScreen extends StatefulWidget {
  final String foodType;

  const FoodDetailsScreen({Key? key, required this.foodType}) : super(key: key);

  @override
  _FoodDetailsScreenState createState() => _FoodDetailsScreenState();
}

class FoodItem {
  final String imagePath;
  final String title;
  final String subtitle;
  final String price;

  FoodItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
  });
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  late String selectedFoodType;
  late List<FoodItem> foodItems;

  @override
  void initState() {
    super.initState();
    selectedFoodType = 'Pate Meal'; // Set the initial selected food type
    foodItems = _getFoodItems(selectedFoodType);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'The WULI Restaurant',
              style: TextStyle(
                color: Colors.white,
              ),
            ),
            Text(
              widget.foodType,
              style: const TextStyle(
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
      body: Column(
        children: [
          // Horizontal scrolling buttons
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildButton('Pate Meal'),
                _buildButton('Rice Bowl'),
                _buildButton('Salad'),
                _buildButton('Pasta'),
                // Add more buttons as needed
              ],
            ),
          ),
          // Content for each button
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16.0),
              children: foodItems
                  .map((foodItem) => _buildContent(
                        foodItem.imagePath,
                        foodItem.title,
                        foodItem.subtitle,
                        foodItem.price,
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildButton(String text) {
    bool isSelected = selectedFoodType == text;
    return Container(
      width: 100, // Set the width for each button
      margin: const EdgeInsets.symmetric(horizontal: 5.0),
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedFoodType = text;
            foodItems = _getFoodItems(text);
          });
        },
        child: Text(
          text,
          style: TextStyle(
            color: isSelected ? Colors.white : Colors.grey,
            fontSize: isSelected ? 16.0 : 14.0,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(
      String imagePath, String title, String subtitle, String price) {
    return Card(
      color: Colors.black,
      child: SizedBox(
        height: 170,
        child: Stack(
          children: [
            Card(
              color: const Color.fromARGB(
                255,
                60,
                60,
                60,
              ), // Use grey color for the card
              elevation: 3.0,
              child: SizedBox(
                width: 300,
                height: 140,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        SizedBox(
                          width: 120, // Set the width for the image
                          height: 120, // Set the height for the image
                          child: Image.asset(imagePath, fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                subtitle,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                price,
                                style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.green,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 120,
              right: 25,
              child: Container(
                height: 40,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: Center(
                  child: IconButton(
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      // Handle button press
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  List<FoodItem> _getFoodItems(String foodType) {
    switch (foodType) {
      case 'Pate Meal':
        return [
          FoodItem(
            imagePath: 'assets/food.png',
            title: 'Pate Meal 1',
            subtitle: 'Monthly sales : 12',
            price: '\$15.99',
          ),
          FoodItem(
            imagePath: 'assets/food.png',
            title: 'Pate Meal 2',
            subtitle: 'Monthly sales : 12',
            price: '\$17.99',
          ),
        ];
      case 'Rice Bowl':
        return [
          FoodItem(
            imagePath: 'assets/food.png',
            title: 'Rice Bowl 1',
            subtitle: 'Monthly sales : 12',
            price: '\$12.99',
          ),
          FoodItem(
            imagePath: 'assets/food.png',
            title: 'Rice Bowl 2',
            subtitle: 'Monthly sales : 12',
            price: '\$14.99',
          ),
        ];
      case 'Salad':
        return [
          FoodItem(
            imagePath: 'assets/food.png',
            title: 'Salad 1',
            subtitle: 'Monthly sales : 12',
            price: '\$8.99',
          ),
          FoodItem(
            imagePath: 'assets/food.png',
            title: 'Salad 2',
            subtitle: 'Monthly sales : 12',
            price: '\$9.99',
          ),
        ];
      case 'Pasta':
        return [
          FoodItem(
            imagePath: 'assets/food.png',
            title: 'Pasta 1',
            subtitle: 'Monthly sales : 12',
            price: '\$14.99',
          ),
          FoodItem(
            imagePath: 'assets/food.png',
            title: 'Pasta 2',
            subtitle: 'Monthly sales : 12',
            price: '\$16.99',
          ),
        ];
      default:
        return [];
    }
  }
}

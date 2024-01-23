import 'package:flutter/material.dart';

import 'reserving_screen.dart';

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
  int itemCount;
  bool showMinusIcon;

  FoodItem({
    required this.imagePath,
    required this.title,
    required this.subtitle,
    required this.price,
    this.itemCount = 0,
    this.showMinusIcon = false,
  });
}

class FoodCard extends StatelessWidget {
  final FoodItem foodItem;
  final VoidCallback onMinusPressed;
  final VoidCallback onPlusPressed;

  FoodCard({
    required this.foodItem,
    required this.onMinusPressed,
    required this.onPlusPressed,
  });

  @override
  Widget build(BuildContext context) {
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
              ),
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
                          width: 120,
                          height: 120,
                          child: Image.asset(foodItem.imagePath,
                              fit: BoxFit.cover),
                        ),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                foodItem.title,
                                style: const TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              Text(
                                foodItem.subtitle,
                                style: const TextStyle(
                                  fontSize: 12,
                                  color: Colors.grey,
                                ),
                              ),
                              const SizedBox(height: 14),
                              Text(
                                foodItem.price,
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
              right: (foodItem.itemCount > 0) ? 30 : 40,
              child: Container(
                height: 40,
                decoration: BoxDecoration(
                  shape: (foodItem.itemCount > 0)
                      ? BoxShape.rectangle
                      : BoxShape.circle,
                  color: Colors.grey,
                  borderRadius: (foodItem.itemCount > 0)
                      ? BorderRadius.circular(20.0)
                      : null,
                ),
                child: Center(
                  child: GestureDetector(
                    onTap: () {},
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        if (foodItem.itemCount > 0)
                          IconButton(
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.white,
                            ),
                            onPressed: onMinusPressed,
                          ),
                        if (foodItem.itemCount > 0)
                          Text(
                            foodItem.itemCount.toString(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 16.0,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        IconButton(
                          icon: const Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                          onPressed: onPlusPressed,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _FoodDetailsScreenState extends State<FoodDetailsScreen> {
  late String selectedFoodType;
  late List<FoodItem> foodItems;
  List<FoodItem> selectedItems = [];

  @override
  void initState() {
    super.initState();
    selectedFoodType = 'Pate Meal';
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
          SizedBox(
            height: 50,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                _buildButton('Pate Meal'),
                _buildButton('Rice Bowl'),
                _buildButton('Salad'),
                _buildButton('Pasta'),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              padding: const EdgeInsets.all(16.0),
              children: foodItems
                  .map((foodItem) => FoodCard(
                        foodItem: foodItem,
                        onMinusPressed: () {
                          setState(() {
                            if (foodItem.itemCount > 0) {
                              foodItem.itemCount--;
                              if (foodItem.itemCount == 0) {
                                foodItem.showMinusIcon = false;
                                selectedItems.remove(foodItem);
                              }
                            }
                          });
                        },
                        onPlusPressed: () {
                          setState(() {
                            foodItem.itemCount++;
                            foodItem.showMinusIcon = true;
                            if (!selectedItems.contains(foodItem)) {
                              selectedItems.add(foodItem);
                            }
                          });
                        },
                      ))
                  .toList(),
            ),
          ),
        ],
      ),
      floatingActionButton: selectedItems.isNotEmpty
          ? FloatingActionButton(
              onPressed: () {
                _showSelectedItems(context);
              },
              backgroundColor: Colors.red,
              child: const Icon(
                Icons.shopping_cart,
                color: Colors.white,
              ),
            )
          : null,
    );
  }

  Widget _buildButton(String text) {
    bool isSelected = selectedFoodType == text;
    return Container(
      width: 100,
      margin: const EdgeInsets.symmetric(horizontal: 4),
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

  void _removeItem(FoodItem foodItem) {
    setState(() {
      foodItem.itemCount = 0;
      foodItem.showMinusIcon = false;
      selectedItems.remove(foodItem);
    });
  }

  void _showSelectedItems(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          color: Colors.black,
          child: Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: selectedItems.length * 2 - 1,
                  itemBuilder: (BuildContext context, int index) {
                    if (index.isOdd) {
                      return const Divider(
                        color: Colors.grey,
                        height: 1,
                      );
                    }

                    final itemIndex = index ~/ 2;
                    final foodItem = selectedItems[itemIndex];

                    return ListTile(
                      title: Row(
                        children: [
                          Text(
                            '${foodItem.title} X ${foodItem.itemCount}',
                            style: const TextStyle(color: Colors.white),
                          ),
                          const Spacer(),
                          IconButton(
                            icon: const Icon(Icons.remove_circle),
                            color: Colors.red,
                            onPressed: () {
                              _removeItem(foodItem);
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      ),
                      subtitle: Text(
                        'Price: \$${(foodItem.itemCount * double.parse(foodItem.price.replaceAll('\$', ''))).toStringAsFixed(2)}',
                        style: const TextStyle(color: Colors.grey),
                      ),
                    );
                  },
                ),
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  // Navigate to the next page
                  Navigator.of(context).push(_createPageRoute(selectedItems));
                },
                child: const Text('Confirm order'),
              ),
            ],
          ),
        );
      },
    );
  }

  PageRouteBuilder<void> _createPageRoute(List<FoodItem> selectedItems) {
    return PageRouteBuilder(
      pageBuilder: (context, animation, secondaryAnimation) {
        return AnimatedBuilder(
          animation: animation,
          builder: (context, child) {
            return ReservePlace(selectedItems: selectedItems);
          },
        );
      },
    );
  }
}

import 'package:flutter/material.dart';
import 'package:restaurant_reserve/pages/details_food_type.dart';

class ReservePlace extends StatefulWidget {
  final List<FoodItem> selectedItems;

  const ReservePlace({Key? key, required this.selectedItems}) : super(key: key);

  @override
  State<ReservePlace> createState() => _ReservePlaceState();
}

class _ReservePlaceState extends State<ReservePlace> {
  String selectedDateType =
      'Today'; // You can change the default selected date type

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildDateButton('Today'),
            _buildDateButton('Tomorrow'),
            _buildDateButton('Pick Date'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Container(),
    );
  }

  Widget _buildDateButton(String text) {
    bool isSelected = selectedDateType == text;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 8),
      child: TextButton(
        onPressed: () {
          setState(() {
            selectedDateType = text;
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
}

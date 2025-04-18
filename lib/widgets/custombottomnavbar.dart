import 'package:flutter/material.dart';

class CustomBottomNavBar extends StatelessWidget {
  final int selectedIndex;

  const CustomBottomNavBar({super.key, required this.selectedIndex});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isLight = theme.brightness == Brightness.light;
    final backgroundColor =
        isLight ?  Colors.grey[200] : theme.colorScheme.surface;

    return Container(
      decoration: BoxDecoration(
        color: backgroundColor,
        border: const Border(
          top: BorderSide(color: Colors.grey, width: 1),
        ),
      ),
      child: BottomNavigationBar(
        currentIndex: selectedIndex,
        selectedItemColor: theme.primaryColor,
        unselectedItemColor: Colors.grey,
        backgroundColor: backgroundColor,
        elevation: 3,
        items: const [
          BottomNavigationBarItem(icon: Padding(
            padding: EdgeInsets.only( top:8.0),
            child: Icon(Icons.home),
          ), label: ''),
          BottomNavigationBarItem(icon: Padding(
            padding: EdgeInsets.only( top:8.0),
            child: Icon(Icons.chat),
          ), label: ''),
          BottomNavigationBarItem(icon: Padding(
            padding: EdgeInsets.only( top:8.0),
            child: Icon(Icons.person),
          ), label: ''),
        ],
      ),
    );
  }
}

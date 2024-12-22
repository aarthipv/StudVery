import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'main.dart'; // Import MyHomePage
import 'delivery.dart'; // Import DeliveryPage
import 'theme_notifier.dart'; // Import the ThemeNotifier

class CommonAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isOrdererMode;

  CommonAppBar({required this.isOrdererMode});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          GestureDetector(
            onTap: () {
              if (!isOrdererMode) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => MyHomePage()),
                );
              }
            },
            child: Text(
              'Orderer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: isOrdererMode ? FontWeight.bold : FontWeight.normal,
                color: isOrdererMode ? Colors.blue : Colors.grey,
              ),
            ),
          ),
          SizedBox(width: 10),
          Text('|', style: TextStyle(color: Colors.grey)),
          SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              if (isOrdererMode) {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => DeliveryPage()),
                );
              }
            },
            child: Text(
              'Deliverer',
              style: TextStyle(
                fontSize: 18,
                fontWeight: isOrdererMode ? FontWeight.normal : FontWeight.bold,
                color: isOrdererMode ? Colors.grey : Colors.blue,
              ),
            ),
          ),
        ],
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: Icon(
            Provider.of<ThemeNotifier>(context).isDarkTheme
                ? Icons.dark_mode
                : Icons.light_mode,
          ),
          onPressed: () {
            Provider.of<ThemeNotifier>(context, listen: false).toggleTheme();
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
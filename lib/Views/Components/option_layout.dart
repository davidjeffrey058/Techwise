import 'package:flutter/material.dart';
import 'package:techwise_pub/Models/option.dart';

class OptionLayout extends StatelessWidget {
  final Options options;

  OptionLayout({super.key, required this.options});
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        switch (options.option) {
          case 'My Profile':
            print(options.option);
            break;
          case 'Change Password':
            print(options.option);
            break;
          case 'Payment Settings':
            print(options.option);
            break;
          case 'Notifications':
            print(options.option);
            break;
          case 'About Us':
            print(options.option);
            break;
          case 'Contact Us':
            print(options.option);
            break;
          case 'Game':
            Navigator.pushNamed(context, '/game_page');
            break;
        }
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                options.option,
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600]),
              ),
            ),
            Icon(
              Icons.navigate_next,
              color: Colors.grey[600],
            ),
          ],
        ),
      ),
    );
  }
}

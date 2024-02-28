import 'package:flutter/material.dart';

class Message extends StatelessWidget {
  final String imageUrl;
  final String title;
  final String description;
  final ElevatedButton? button;
  final bool isCentered;

  const Message({
    super.key,
    required this.imageUrl,
    required this.title,
    required this.description,
    this.button,
    this.isCentered = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        mainAxisAlignment: isCentered ? MainAxisAlignment.center : MainAxisAlignment.start,
        children: [
          SizedBox(
            height: 120,
            width: 120,
            child: Image(
              image: AssetImage(imageUrl),
              fit: BoxFit.contain,
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            title,
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 20,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.7,
            child: Text(
              description,
              textAlign: TextAlign.center,
            ),
          ),
          if(button != null)SizedBox(
            height: 40,
          ),
          if(button != null)SizedBox(
            width: double.infinity,
            height: 50,
            child: button
          )
        ],
      ),
    );
  }
}

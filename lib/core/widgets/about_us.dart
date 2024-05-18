import 'package:flutter/material.dart';

void showAboutUsDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text('About Us'),
        content: const SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text('This is the About Us section of the app.'),
              SizedBox(height: 10),
              Text(
                  'Our application aims to provide the best user experience...'),
              // Add more text or widgets as needed
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('Close'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}

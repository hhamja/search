import 'package:flutter/material.dart';
import 'package:search/auto_complete.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        color: Colors.blue,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: const Column(
          children: [
            SizedBox(height: 80),
            AutoComplete(),
          ],
        ),
      ),
    );
  }
}

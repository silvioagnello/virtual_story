import 'package:flutter/material.dart';
import 'package:virtual_story/tabs/home_tab.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        HomeTab(),
      ],
    );
  }
}

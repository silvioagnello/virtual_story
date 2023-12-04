import 'package:flutter/material.dart';
import 'package:virtual_story/tabs/home_tab.dart';
import 'package:virtual_story/tabs/categories_tab.dart';
import 'package:virtual_story/widgets/custom_drawer.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
      controller: _pageController,
      physics: const NeverScrollableScrollPhysics(),
      children: [
        Scaffold(
          //appBar: AppBar(),
          body: const HomeTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(iconTheme: const IconThemeData(color: Colors.white),
              title: const Text('Produtos', style: TextStyle(color: Colors.white),),
              centerTitle: true,
              backgroundColor: Theme.of(context).primaryColor),
          body: const CategoriesTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Container(color: Colors.amber),
        Container(color: Colors.brown),
      ],
    );
  }
}

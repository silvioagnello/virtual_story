import 'package:flutter/material.dart';
import 'package:virtual_story/tabs/home_tab.dart';
import 'package:virtual_story/tabs/categories_tab.dart';
import 'package:virtual_story/tabs/places_tab.dart';
import 'package:virtual_story/widgets/cart_button.dart';
import 'package:virtual_story/widgets/custom_drawer.dart';

import '../tabs/orders_tab.dart';

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
          floatingActionButton: const CartButton(),
        ),
        Scaffold(
          floatingActionButton: const CartButton(),
          appBar: AppBar(
              iconTheme: const IconThemeData(color: Colors.white),
              title: const Text(
                'Produtos',
                style: TextStyle(color: Colors.white),
              ),
              centerTitle: true,
              backgroundColor: Theme.of(context).primaryColor),
          body: const CategoriesTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(title: const Text('Lojas'), centerTitle: true),
          body: const PlacesTab(),
          drawer: CustomDrawer(pageController: _pageController),
        ),
        Scaffold(
          appBar: AppBar(title: const Text('Meus Pedidos'), centerTitle: true),
          body: const OrdersTab(),
          drawer: CustomDrawer(pageController: _pageController),
          floatingActionButton: const CartButton(),
        )
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_story/models/cart_model.dart';
import 'package:virtual_story/models/user_model.dart';
import 'package:virtual_story/screens/login_screen.dart';
import 'package:virtual_story/screens/order_screen.dart';
import 'package:virtual_story/tiles/cart_tile.dart';
import 'package:virtual_story/widgets/cart_price.dart';
import 'package:virtual_story/widgets/custom_message.dart';
import 'package:virtual_story/widgets/discount_card.dart';
import 'package:virtual_story/widgets/ship_card.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Meu carrinho'),
        actions: [
          Container(
            padding: const EdgeInsets.only(right: 8.0),
            alignment: Alignment.center,
            child: ScopedModelDescendant<CartModel>(
                builder: (context, child, model) {
              int p = model.products.length;
              return Text(
                "${p != 0 ? p : 'nenhum'} ${p > 1 ? 'Itens' : 'Item'}",
                style: const TextStyle(fontSize: 17.0),
              );
            }),
          )
        ],
      ),
      body: ScopedModelDescendant<CartModel>(
        builder: (context, child, model) {
          if (model.isLoading && UserModel.of(context).isLoggedIn()) {
            return const Center(child: CircularProgressIndicator());
          } else if (!UserModel.of(context).isLoggedIn()) {
            return CustomMensagem("Faça o login para adicionar produtos!", 0);
          } else if (model.products.isEmpty && model.products.length == 0) {
            return const Center(
              child: Text("Nenhum produto no Carrinho",
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center),
            );
          } else {
            return ListView(
              children: [
                Column(
                  children: model.products.map((e) {
                    return CartTile(cartProduct: e);
                  }).toList(),
                ),
                const DiscountCard(),
                const ShipCard(),
                CartPrice(
                  () async {
                    String? orderId = await model.finishOrder();
                    if (orderId != null) {
                      Navigator.of(context).pushReplacement(
                        MaterialPageRoute(
                          builder: (context) => OrderScreen(orderId: orderId),
                        ),
                      );
                    }
                  },
                ),
              ],
            );
          }
        },
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_story/models/cart_model.dart';

class CartPrice extends StatelessWidget {
  final VoidCallback buy;

  const CartPrice(this.buy, {super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: Container(
        padding: const EdgeInsets.all(16.0),
        child: ScopedModelDescendant<CartModel>(
          builder: (context, child, model) {

            double price = model.getProductsPrice();

            double discount = model.getDiscount();

            double? ship = model.getShipPrice();

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const Text('Resumo do Pedido',
                    textAlign: TextAlign.start,
                    style: TextStyle(fontWeight: FontWeight.w500)),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('SubTotal'),
                    Text('R\$ ${price.toStringAsFixed(2)}'),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Desconto '),
                    Text('R\$ -${discount.toStringAsFixed(2)}'),
                  ],
                ),
                const Divider(),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text('Entrega(Promocional)'),
                    Text('R\$ -${ship.toStringAsFixed(2)}'),
                  ],
                ),
                const Divider(),
                const SizedBox(height: 12.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Total',
                        style: TextStyle(
                            fontWeight: FontWeight.w500, fontSize: 16.0)),
                    Text('R\$ ${(price - ship - discount).toStringAsFixed(2)}',
                        style: TextStyle(color: Colors.blue, fontSize: 16.0)),
                  ],
                ),
                const SizedBox(height: 12.0),
                ElevatedButton(
                  onPressed: buy,
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor),
                  child: const Text(
                    'Finalizar Pedido',
                    style: TextStyle(color: Colors.white),
                  ),
                )
              ],
            );
          },
        ),
      ),
    );
  }
}

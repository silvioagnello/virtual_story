import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:virtual_story/datas/cart_product.dart';
import 'package:virtual_story/datas/product_data.dart';
import 'package:virtual_story/models/cart_model.dart';

class CartTile extends StatelessWidget {
  final CartProduct cartProduct;

  const CartTile({super.key, required this.cartProduct});

  @override
  Widget build(BuildContext context) {
    Widget _buildContent() {
      return Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
              width: 120.0,
              padding: const EdgeInsets.all(8.0),
              child: Image.network(cartProduct.productData!.images![0])),
          Expanded(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                      style: const TextStyle(
                          fontWeight: FontWeight.w500, fontSize: 17.0),
                      cartProduct.productData!.title!),
                  Text('Tamanho: ${cartProduct.size}',
                      style: const TextStyle(fontWeight: FontWeight.w300)),
                  Text(
                    'R\$ ${cartProduct.productData!.price?.toStringAsFixed(2)}',
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      IconButton(
                        onPressed:
                        cartProduct.quantity == 1
                            ? null
                            : () {
                                CartModel.of(context).decProduct(cartProduct);
                              },
                        icon: const Icon(Icons.remove, color: Colors.blue),
                      ),
                      Text(cartProduct.quantity.toString()),
                      IconButton(
                          onPressed: () {
                            CartModel.of(context).incProduct(cartProduct);
                          },
                          icon: const Icon(Icons.add, color: Colors.blue)),
                      TextButton(
                        onPressed: () {
                          CartModel.of(context).removeCartItem(cartProduct);
                        },
                        child: Text('Remover',
                            style: TextStyle(color: Colors.grey.shade500)),
                      )
                    ],
                  )
                ],
              ),
            ),
          )
        ],
      );
    }

    return Card(
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: cartProduct.productData == null
            ? FutureBuilder<DocumentSnapshot>(
                future: FirebaseFirestore.instance
                    .collection("categories")
                    .doc(cartProduct.category)
                    .collection('itens')
                    .doc(cartProduct.pid)
                    .get(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    cartProduct.productData =
                        ProductData.fromDocument(snapshot.data!);
                    return _buildContent();
                  } else {
                    return Container(
                      height: 70.0,
                      child: const CircularProgressIndicator(),
                      alignment: Alignment.center,
                    );
                  }
                })
            : _buildContent());
  }
}

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_story/models/user_model.dart';
import 'package:virtual_story/screens/home_screen.dart';
import 'package:virtual_story/screens/login_screen.dart';

import '../tiles/order_tile.dart';
import '../widgets/custom_message.dart';

class OrdersTab extends StatelessWidget {
  const OrdersTab({super.key});

  @override
  Widget build(BuildContext context) {
    if (UserModel.of(context).isLoggedIn()) {
      String? uid = UserModel.of(context).firebaseUser?.uid;
      return FutureBuilder<QuerySnapshot>(
        future: FirebaseFirestore.instance
            .collection("users")
            .doc(uid)
            .collection("orders")
            .get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data!.docs.length == 0) {
            return Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(Icons.add_shopping_cart,
                      size: 80.0, color: Theme.of(context).primaryColor),
                  const SizedBox(
                    height: 16.0,
                  ),
                  const Text(
                    "Carrinho vazio favor voltar!",
                    style:
                        TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    height: 16.0,
                  ),
                  ElevatedButton(
                      //style: raisedButtonStyle,
                      child: const Text("Voltar",
                          style: TextStyle(
                            fontSize: 18.0,
                          )),
                      onPressed: () {
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => const LoginScreen()));
                      })
                ],
              ),
            );
          } else {
            return ListView(
              children: snapshot.data!.docs
                  .map((doc) => OrderTile(orderId: doc.id))
                  .toList()
                  .reversed
                  .toList(),
            );
          }
        },
      );
    } else {
      return CustomMensagem("Faça o login para acompanhar!", 1);
    }
  }
}

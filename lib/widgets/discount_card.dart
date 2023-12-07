import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_story/models/cart_model.dart';

class DiscountCard extends StatelessWidget {
  const DiscountCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: const Text(
          'Cupom de Desconto',
          textAlign: TextAlign.start,
          style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey),
        ),
        leading: const Icon(Icons.card_giftcard),
        trailing: const Icon(Icons.add),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              initialValue: CartModel.of(context).couponCode ?? "",
              onFieldSubmitted: (text) {
                FirebaseFirestore.instance
                    .collection('coupons')
                    .doc(text)
                    .get()
                    .then(
                  (value) {
                    if (value.data() != null) {
                      CartModel.of(context)
                          .setCoupon(text, value.data()!['percent']);
                      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            "Desconto de ${value.data()!['percent']}% aplicado"),
                        backgroundColor: Theme.of(context).primaryColor,
                        duration: const Duration(seconds: 2),
                      ));
                    } else {
                      CartModel.of(context).setCoupon(null, 0);
                      const SnackBar(
                        content: Text("Cupom inexistente"),
                        backgroundColor: Colors.red,
                        duration: Duration(seconds: 2),
                      );
                    }
                  },
                );
              },
              decoration: const InputDecoration(
                  border: OutlineInputBorder(), hintText: 'Digite seu Cupom'),
            ),
          )
        ],
      ),
    );
  }
}

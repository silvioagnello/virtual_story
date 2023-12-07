import 'package:flutter/material.dart';

class ShipCard extends StatelessWidget {
  const ShipCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
      child: ExpansionTile(
        title: const Text('Calcular Frete',
            textAlign: TextAlign.start,
            style: TextStyle(fontWeight: FontWeight.w500, color: Colors.grey)),
        leading: const Icon(Icons.location_on),
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
                initialValue: "",
                decoration: const InputDecoration(
                    border: OutlineInputBorder(), hintText: 'Digite seu CEP')),
          )
        ],
      ),
    );
  }
}

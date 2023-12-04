import 'package:flutter/material.dart';
import 'package:virtual_story/datas/product_data.dart';
import 'package:virtual_story/screens/detail_screen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData data;

  const ProductTile(this.type, this.data, {super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => DetailScreen(product: data),
            ),
          );
        },
        child: Card(
          child: type == 'grid'
              ? Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    AspectRatio(
                      aspectRatio: 0.8,
                      child: Image.network(data.images![0], fit: BoxFit.cover),
                    ),
                    Expanded(
                      child: Container(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          children: [
                            Padding(
                                padding: const EdgeInsets.only(
                                    left: 2.0, bottom: 1.0),
                                child: Text(data.title!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500))),
                            Text(
                              "R\$ ${data.price?.toStringAsFixed(2)}",
                              style: TextStyle(
                                  color: Theme.of(context).primaryColor,
                                  fontSize: 17.0,
                                  fontWeight: FontWeight.bold),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                )
              : Row(
                  children: [
                    Flexible(
                        flex: 1,
                        child: Image.network(data.images![0],
                            fit: BoxFit.cover, height: 250)),
                    Flexible(
                        flex: 1,
                        child: Container(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              Text(
                                data.title!,
                                style: const TextStyle(fontWeight: FontWeight.w500),
                              ),
                              Text(
                                "R\$ ${data.price?.toStringAsFixed(2)}",
                                style: TextStyle(
                                    color: Theme.of(context).primaryColor,
                                    fontSize: 17.0,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ))
                  ],
                ),
        ));
  }
}

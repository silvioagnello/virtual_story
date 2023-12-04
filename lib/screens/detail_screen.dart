import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:virtual_story/datas/product_data.dart';

class DetailScreen extends StatefulWidget {

  final ProductData product;

  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState(product);
}

class _DetailScreenState extends State<DetailScreen> {
  String size = '';
  final ProductData product;
  final CarouselController _carouselController = CarouselController();
  _DetailScreenState(this.product);

  @override
  Widget build(BuildContext context) {
    final Color primaryColor = Theme.of(context).primaryColor;
    // var _carouselController;
    return Scaffold(
      appBar: AppBar(title: Text(product.title!), centerTitle: true),
      body: ListView(
        children: [
          AspectRatio(
            aspectRatio: 0.9,
            child: CarouselSlider(
              carouselController: _carouselController,
              options: CarouselOptions(
                enlargeCenterPage: true,
                autoPlay: false,
                aspectRatio: 1.0,
                enlargeStrategy: CenterPageEnlargeStrategy.height,
              ),
              items: product.images?.map((e) {
                return Image.network(e, fit: BoxFit.cover);
              }).toList(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(product.title!,
                    style: const TextStyle(
                        fontSize: 20.0, fontWeight: FontWeight.w200),
                    maxLines: 3),
                Text(product.description!, style: const TextStyle(fontSize: 16.0)),
                Text(
                  "R\$ ${product.price?.toStringAsFixed(2)}",
                  style: TextStyle(
                      fontSize: 22.0,
                      fontWeight: FontWeight.bold,
                      color: primaryColor),
                ),
                const SizedBox(height: 16.0),
                const Text('Tamanho',
                    style:
                        TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500)),
                SizedBox(
                  height: 34.0,
                  child: GridView(
                    padding: const EdgeInsets.symmetric(vertical: 4.0),
                    scrollDirection: Axis.horizontal,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 1,
                            mainAxisSpacing: 8.0,
                            childAspectRatio: 0.5),
                    children: product.sizes!.map(
                      (e) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              size = e;
                            });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              borderRadius:
                                  const BorderRadius.all(Radius.circular(4.0)),
                              border: Border.all(
                                  color: e == size
                                      ? primaryColor
                                      : Colors.grey.shade500,
                                  width: 3.0),
                            ),
                            width: 50.0,
                            alignment: Alignment.center,
                            child: Text(e),
                          ),
                        );
                      },
                    ).toList(),
                  ),
                ),
                const SizedBox(height: 16.0),
                SizedBox(
                  height: 44.0,
                  child: ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: primaryColor),
                    onPressed: size != '' ? () {} : null,
                    child: const Text(
                      'Adicionar ao carrinho',
                      style: TextStyle(fontSize: 18.0, color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}

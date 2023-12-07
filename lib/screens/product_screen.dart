import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_story/datas/product_data.dart';
import 'package:virtual_story/tiles/product_tile.dart';
import 'package:virtual_story/widgets/discount_card.dart';

class ProductScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  const ProductScreen({super.key, required this.snapshot});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(snapshot.get('title')),
          centerTitle: true,
          bottom: const TabBar(
            tabs: [Tab(icon: Icon(Icons.grid_on)), Tab(icon: Icon(Icons.list))],
            indicatorColor: Colors.white,
          ),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance
              .collection("categories")
              .doc(snapshot.id)
              .collection('itens')
              .get(),
          builder: (BuildContext context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return TabBarView(
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GridView.builder(
                    padding: const EdgeInsets.all(4.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            mainAxisSpacing: 4.0,
                            crossAxisSpacing: 4.0,
                            childAspectRatio: 0.65),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      ProductData data =
                          ProductData.fromDocument(snapshot.data!.docs[index]);
                      data.category = this.snapshot.id;
                      return ProductTile("grid", data);
                    },
                  ),
                  ListView.builder(
                    padding: const EdgeInsets.all(4),
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      ProductData data =
                          ProductData.fromDocument(snapshot.data!.docs[index]);
                      data.category = this.snapshot.id;
                      return ProductTile("list", data);
                    },
                  ),
                ],
              );
            }
          },
        ),
      ),
    );
  }
}

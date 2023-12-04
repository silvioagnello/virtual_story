import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:virtual_story/tiles/category_tile.dart';

class CategoriesTab extends StatelessWidget {
  const CategoriesTab({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<QuerySnapshot>(
      future: FirebaseFirestore.instance.collection("categories").get(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        } else {
          var dividedTiles = ListTile.divideTiles(
                  tiles: snapshot.data!.docs.map((doc) {
                    return CategoryTile(snapshot: doc);
                  }).toList(),
                  color: Colors.grey[500])
              .toList();
          return ListView(children: dividedTiles);
        }
      },
    );
  }
}

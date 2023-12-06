import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_story/datas/cart_product.dart';
import 'package:virtual_story/models/user_model.dart';

class CartModel extends Model {
  UserModel? user;

  List<CartProduct> products = [];

  CartModel(this.user){
    if(user!.isLoggedIn()){
    _loadCartItems();
    }
  }

  bool isLoading = false;

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(CartProduct cartProduct) {
    products.add(cartProduct);

    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.firebaseUser?.uid)
        .collection('cart')
        .add(cartProduct.toMap())
        .then((doc) {
      cartProduct.cid = doc.id;
    });

    notifyListeners();
  }

  void removeCartItem(CartProduct cartProduct) {
    FirebaseFirestore.instance
        .collection('users')
        .doc(user?.firebaseUser?.uid)
        .collection('cart')
        .doc(cartProduct.cid)
        .delete();
    products.remove(cartProduct);
    notifyListeners();
  }

  void incProduct(CartProduct cartProduct) {
    cartProduct.quantity++;
    FirebaseFirestore.instance.collection('users').doc(user?.firebaseUser?.uid)
        .collection('cart').doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void decProduct(CartProduct cartProduct) {
    cartProduct.quantity--;

    FirebaseFirestore.instance.collection('users').doc(user?.firebaseUser?.uid)
        .collection('cart').doc(cartProduct.cid)
        .update(cartProduct.toMap());
    notifyListeners();
  }

  void _loadCartItems() async {
    QuerySnapshot query = await FirebaseFirestore.instance.collection('users').doc(user?.firebaseUser?.uid)
        .collection('cart')
        .get();

    products = query.docs.map((doc) => CartProduct.fromDocument(doc)).toList();
    notifyListeners();
  }
}

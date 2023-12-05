import 'package:firebase_core/firebase_core.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_story/firebase_options.dart';
import 'package:virtual_story/models/cart_model.dart';
import 'package:virtual_story/models/user_model.dart';
import 'package:virtual_story/screens/cart_screen.dart';
import 'package:virtual_story/screens/home_screen.dart';
import 'package:flutter/material.dart';

// import 'package:virtual_story/screens/login_screen.dart';
// import 'package:virtual_story/screens/signup_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
      model: UserModel(),
      child: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          return ScopedModel<CartModel>(
            model: CartModel(model),
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Loja Virtual',
              theme: ThemeData(
                primarySwatch: Colors.blue,
                primaryColor: const Color.fromARGB(255, 4, 125, 141),
                //colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
                useMaterial3: true,
              ),
              home: HomeScreen(),
            ),
          );
        },
      ),
    );
  }
}

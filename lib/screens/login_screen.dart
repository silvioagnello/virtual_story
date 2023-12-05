import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_story/models/user_model.dart';
import 'package:virtual_story/screens/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formkey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Entrar'),
        centerTitle: true,
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(builder: (context) => const SignupScreen()),
              );
            },
            child: const Text('Criar Conta', style: TextStyle(fontSize: 15.0)),
          )
        ],
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return Form(
            key: _formkey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(hintText: 'E-mail'),
                  keyboardType: TextInputType.emailAddress,
                  validator: (text) {
                    if (text!.isEmpty || !text.contains('@')) {
                      return 'E-mail inválido';
                    }
                    return null;
                  },
                ),
                const SizedBox(
                  height: 16.0,
                ),
                TextFormField(
                    controller: _passController,
                    validator: (text) {
                      if (text!.isEmpty || text.length < 6) {
                        return 'Senha inválida';
                      }
                      return null;
                    },
                    decoration: const InputDecoration(hintText: 'Senha'),
                    obscureText: true),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      if (_emailController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Center(
                              child: Text("Insira seu email para recuperação!",
                                  style: TextStyle(color: Colors.black))),
                          backgroundColor: Colors.cyanAccent,
                          duration: Duration(seconds: 2)));
                      } else {
                        model.recoverPass(_emailController.text);
                        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          content: Center(child: Text("Confire seu email!")),
                          backgroundColor: Colors.black,
                          duration: Duration(seconds: 2),)
                        );
                        _emailController.text = '';
                      }
                    },
                    child: const Text('Esqueci minha senha'),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    if (_formkey.currentState!.validate()) {
                      model.signIn(
                          email: _emailController.text,
                          pass: _passController.text,
                          onSuccess: () => _onSuccess(),
                          onFail: () => _onFail());
                    }
                  },
                  child: const Text('Entrar',
                      style: TextStyle(
                        fontSize: 18.0,
                      )),
                )
              ],
            ),
          );
        },
      ),
    );
  }

  void _onSuccess() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(
          child: Text("Tudo certo ao Entrar",
              style: TextStyle(color: Colors.black))),
      backgroundColor: Colors.cyanAccent,
      duration: Duration(seconds: 2),
    ));
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(
          child:
              Text("Falha ao entrar!", style: TextStyle(color: Colors.black))),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
    Navigator.of(context).pop();
  }
}

import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:virtual_story/models/user_model.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passController = TextEditingController();
  final _addressController = TextEditingController();
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Criar Conta'),
        centerTitle: true,
      ),
      body: ScopedModelDescendant<UserModel>(
        builder: (context, child, model) {
          if (model.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          return Form(
            key: _formKey,
            child: ListView(
              padding: const EdgeInsets.all(16.0),
              children: [
                TextFormField(
                  controller: _nameController,
                  decoration: const InputDecoration(hintText: 'Nome completo'),
                  validator: (text) {
                    if (text!.isEmpty) {
                      return 'Digite um nome';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),
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
                const SizedBox(height: 16.0),
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
                Padding(
                  padding: const EdgeInsets.only(top: 18.0),
                  child: TextFormField(
                      controller: _addressController,
                      validator: (text) {
                        if (text!.isEmpty || text.length < 6) {
                          return 'Digite um endereço';
                        }
                        return null;
                      },
                      decoration: const InputDecoration(hintText: 'Endereço')),
                ),
                Padding(
                  padding: const EdgeInsets.all(18.0),
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Map<String, dynamic> userData = {
                          "name": _nameController.text,
                          "email": _emailController.text,
                          "address": _addressController.text,
                        };
                        model.signUp(
                          userData: userData,
                          pass: _passController.text,
                          onSuccess: () => _onSuccess(),
                          onFail: () => _onFail(),
                        );
                      }
                    },
                    child: const Text('Criar Conta',
                        style: TextStyle(
                          fontSize: 18.0,
                        )),
                  ),
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
      content: Center(child: Text("Criado com Sucesso!")),
      backgroundColor: Colors.cyanAccent,
      duration: Duration(seconds: 2),
    ));
    Navigator.of(context).pop();
  }

  void _onFail() {
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
      content: Center(child: Text("Falha ao criar!")),
      backgroundColor: Colors.redAccent,
      duration: Duration(seconds: 2),
    ));
  }
}

import 'package:flutter/material.dart';
import 'package:open_market/api/auth_api.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passWordController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Authentication"),
      ),
      body: Column(
        children: [
          TextField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            decoration: const InputDecoration(label: Text("Email")),
          ),
          TextField(
            obscureText: true,
            controller: _passWordController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(label: Text("password")),
          ),
          ElevatedButton(
              onPressed: () {
                AuthApi()
                    .login(_emailController.text, _passWordController.text);
              },
              child: const Text("Connexion")),
          ElevatedButton(
              onPressed: () {
                AuthApi()
                    .register(_emailController.text, _passWordController.text);
              },
              child: const Text("Register")),
          ElevatedButton(
              onPressed: () {
                AuthApi().withGoogle();
              },
              child: const Text("Connexion avec google"))
        ],
      ),
    );
  }
}

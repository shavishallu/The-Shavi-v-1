import 'package:flutter/material.dart';

class LoginPage extends StatelessWidget {
  
  const LoginPage({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[200],
      body: Center(
        child: ElevatedButton(
          onPressed: () {},
          child: Text('Show Login'),
        ),
      ),
    );
  }


}

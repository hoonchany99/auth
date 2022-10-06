import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class App extends StatelessWidget {
  final _firebaseAuth = FirebaseAuth.instance;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  final _fireStore = FirebaseFirestore.instance;

  final _contextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Auth & Store'),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: _emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            TextFormField(
              controller: _passwordController,
              decoration: const InputDecoration(labelText: 'Password'),
            ),
            ElevatedButton(onPressed: Register, child: Text('Register')),
            TextFormField(
              controller: _contextController,
              decoration: const InputDecoration(labelText: 'Context'),
            ),
            ElevatedButton(onPressed: Boxify, child: Text('Boxify'))
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    _emailController.dispose();
    _passwordController.dispose();
  }

  Future<void> Register() async {
    try {
      final User? user = (await _firebaseAuth.createUserWithEmailAndPassword(
        email: _emailController.text,
        password: _passwordController.text,
      ))
          .user;
      if (user != null) {
        print('Success');
      } else {
        print('Failed');
      }

      _emailController.text = '';
      _passwordController.text = '';
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }

  Future<void> Boxify() async {
    try {
      final user =
          _fireStore.collection('box').add({'name': _contextController.text});

      if (user != null) {
        print('Boxify Success');
      } else {
        print('Failed');
      }
      _contextController.text = '';
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
    Getify();
  }

  Future<void> Getify() async {
    try {
      final user =
          await _fireStore.collection('box').doc("ORlPgwMsc8brvRKmgfNK").get();

      if (user != null) {
        print("Getify Success");
        print(user.data()!['name']);
      } else {
        print('Failed');
      }
    } catch (e) {
      print(e);
      Get.snackbar('Error', e.toString(), snackPosition: SnackPosition.BOTTOM);
    }
  }
}

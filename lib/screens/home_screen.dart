// ignore_for_file: prefer_const_constructors
// ignore_for_file: prefer_const_literals_to_create_immutables

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tracker_application/widgets/transactions_cards.dart';
import '../widgets/add_transaction_form.dart';
import '../widgets/hero_card.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var isLogoutLoading = false;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  logOut() async {
    setState(() {
      isLogoutLoading = true;
    });
    await FirebaseAuth.instance.signOut();
    Navigator.of(context)
        .pushReplacement(MaterialPageRoute(builder: (context) => LoginView()));
    setState(() {
      isLogoutLoading = false;
    });
  }

  _dialoBuilder(BuildContext context) {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            content: AddTransactionForm(),
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue.shade900,
        onPressed: (() {
          _dialoBuilder(context);
        }),
        child: Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title:
        Text("Hello !!",
          style: TextStyle(color: Colors.white,
          fontWeight: FontWeight.w800,
          fontSize: 24),
        ),
        actions: [
          IconButton(
            onPressed: () {
              logOut();
            },
            icon: isLogoutLoading
                ? CircularProgressIndicator()
                : Icon(
                    Icons.exit_to_app_outlined,
                    color: Colors.white,
                  ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            HeroCard(userId: userId),
            TransactionsCard(),
          ],
        ),
      ),
    );
  }
}

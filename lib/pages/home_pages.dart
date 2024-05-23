import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:project_tabungan/components/drawer.dart';
import 'package:project_tabungan/components/plus_button.dart';
import 'package:project_tabungan/components/top_card.dart';
import 'package:project_tabungan/components/transaction.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String balance = '150000';
  String masuk = '37000';
  String sisa = '117000';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Text("TABUNGAN KU"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        elevation: 0,
      ),
      drawer: MyDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          children: [
            TopNewCard(
              balance: balance,
              masuk: masuk,
              sisa: sisa,
            ),
            Expanded(
              child: Column(
                children: [
                  Center(
                    child: Column(children: [
                      SizedBox(
                        height: 20,
                      ),
                      MyTransaction(itemName: 'Sepatu', price: 10000),
                      SizedBox(height: 20),
                      MyTransaction(itemName: 'Sepatu', price: 15000),
                    ]),
                  )
                ],
              ),
            ),
            PlusButton()
          ],
        ),
      ),
    );
  }
}

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class MyTransaction extends StatefulWidget {
  const MyTransaction({Key? key}) : super(key: key);

  @override
  State<MyTransaction> createState() => _MyTransactionState();
}

class _MyTransactionState extends State<MyTransaction> {
  List _listData = [];
  bool _loading = true;

  Future<void> _getData() async {
    try {
      final response =
          await http.get(Uri.parse('http://192.168.200.81/tabungan/read.php'));
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          _listData = data;
          _loading = false;
        });
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    _getData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Transaction"),
      ),
      body: _loading
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _listData.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(_listData[index]['nama_transaksi']),
                    subtitle: Text(_listData[index]['harga']),
                  ),
                );
              },
            ),
    );
  }
}

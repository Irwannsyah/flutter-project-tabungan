import 'package:flutter/material.dart';

class MyTransaction extends StatelessWidget {
  const MyTransaction({Key? key, required this.itemName, required this.price});

  final String itemName;
  final int price;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.all(10),
        color: Colors.grey[200],
        height: 50,
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                itemName,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              RichText(
                text: TextSpan(
                  text: price > 0 ? '+' : '', // Teks tambahan "+" jika harga positif
                  style: TextStyle(
                    color: price > 0 ? Colors.green : Colors.red, // Warna hijau untuk harga positif dan merah untuk harga negatif
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                  children: <TextSpan>[
                    TextSpan(
                      text: price.abs().toString(), // Menggunakan nilai absolut untuk harga
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
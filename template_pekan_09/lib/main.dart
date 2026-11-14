import 'package:flutter/material.dart';
import 'halaman_login.dart';

void main() {
  runApp(AplikasiPenjualan());
}

class AplikasiPenjualan extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penjualan UMKM Bandung',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        fontFamily: 'Roboto',
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.indigo,
        ),
      ),
      home: HalamanLogin(),
    );
  }
}

import 'package:flutter/material.dart';
import 'halaman_dashboard.dart';

class HalamanLogin extends StatefulWidget {
  @override
  State<HalamanLogin> createState() {
    return _HalamanLoginState();
  }
}

class _HalamanLoginState extends State<HalamanLogin> {
  final TextEditingController namaController = TextEditingController(text: 'Khairul Ihdhar');

  void prosesLogin() {
    String nama = namaController.text.trim();
    if (nama.isEmpty) {
      nama = 'Kasir Bandung';
    }
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) {
          return HalamanDashboard(namaPengguna: nama);
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Kasir Toko'),
        centerTitle: true,
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Icon(
                Icons.storefront,
                size: 80,
                color: Colors.indigo,
              ),
              SizedBox(height: 16),
              Text(
                'Selamat Datang',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 6),
              Text(
                'Sentra UMKM Kota Bandung',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                ),
              ),
              SizedBox(height: 32),
              TextField(
                controller: namaController,
                decoration: InputDecoration(
                  labelText: 'Nama Kasir / Pengguna',
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(Icons.person),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: prosesLogin,
                icon: Icon(Icons.login),
                label: Text('Masuk ke Dashboard'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 14),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
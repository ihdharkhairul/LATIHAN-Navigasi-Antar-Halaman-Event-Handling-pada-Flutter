import 'package:flutter/material.dart';

class TabProfil extends StatelessWidget {
  final String namaPengguna;
  final int jumlahProduk;
  final int totalTransaksi;
  final VoidCallback onLogout;

  TabProfil({
    required this.namaPengguna,
    required this.jumlahProduk,
    required this.totalTransaksi,
    required this.onLogout,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: CircleAvatar(
              radius: 45,
              backgroundColor: Colors.indigo.shade100,
              child: Icon(
                Icons.person,
                size: 50,
                color: Colors.indigo,
              ),
            ),
          ),
          SizedBox(height: 12),
          Text(
            namaPengguna,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Kasir Aktif Kota Bandung',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.grey.shade600),
          ),
          SizedBox(height: 24),
          Card(
            child: Padding(
              padding: EdgeInsets.all(16.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Unit Toko'),
                      Text(
                        'Sentra UMKM Bandung',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Jumlah Produk'),
                      Text(
                        '$jumlahProduk Item',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('Total Transaksi Selesai'),
                      Text(
                        '$totalTransaksi Penjualan',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.green.shade700,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: 24),
          ElevatedButton.icon(
            onPressed: onLogout,
            icon: Icon(Icons.logout),
            label: Text('Keluar dari Akun'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade700,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 12),
            ),
          ),
        ],
      ),
    );
  }
}

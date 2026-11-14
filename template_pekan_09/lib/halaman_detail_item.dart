import 'package:flutter/material.dart';
import 'models/item_penjualan.dart';

class HalamanDetailItem extends StatefulWidget {
  final ItemPenjualan item;

  HalamanDetailItem({required this.item});

  @override
  State<HalamanDetailItem> createState() {
    return _HalamanDetailItemState();
  }
}

class _HalamanDetailItemState extends State<HalamanDetailItem> {
  Widget buildProductBanner(String foto) {
    return Container(
      height: 180,
      width: double.infinity,
      padding: EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.indigo.shade50,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Image.asset(
        foto,
        fit: BoxFit.contain,
        errorBuilder: (context, error, stackTrace) {
          return Center(
            child: Icon(
              Icons.image_outlined,
              size: 64,
              color: Colors.indigo,
            ),
          );
        },
      ),
    );
  }

  void navigasiKembali() {
    Navigator.pop(context);
  }

  void prosesPenjualan() {
    if (widget.item.stok > 0) {
      setState(() {
        widget.item.stok -= 1;
      });
      Navigator.pop(
        context,
        'Terjual 1 unit ${widget.item.nama} (Rp ${widget.item.harga})',
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Produk Penjualan'),
      ),
      body: Padding(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildProductBanner(widget.item.foto),
            SizedBox(height: 16),
            Card(
              elevation: 2,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.item.nama,
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Chip(
                      label: Text(widget.item.kategori),
                      backgroundColor: Colors.indigo.shade50,
                    ),
                    Divider(height: 20),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Harga Satuan:', style: TextStyle(fontSize: 15)),
                        Text(
                          'Rp ${widget.item.harga}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.green.shade700,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Stok Tersedia:', style: TextStyle(fontSize: 15)),
                        Text(
                          '${widget.item.stok} unit',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: widget.item.stok > 0
                                ? Colors.black87
                                : Colors.red,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 14),
                    Text(
                      'Deskripsi Produk:',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text(
                      widget.item.deskripsi,
                      style: TextStyle(
                        color: Colors.grey.shade800,
                        height: 1.4,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Spacer(),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: navigasiKembali,
                    child: Text('Kembali'),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
                SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: widget.item.stok > 0 ? prosesPenjualan : null,
                    child: Text(
                      widget.item.stok > 0 ? 'Catat Penjualan' : 'Stok Habis',
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.indigo,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
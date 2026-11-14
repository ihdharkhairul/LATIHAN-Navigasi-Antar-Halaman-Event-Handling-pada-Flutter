import 'package:flutter/material.dart';
import '../models/item_penjualan.dart';

class TabKatalog extends StatelessWidget {
  final List<ItemPenjualan> daftarItem;
  final Function(ItemPenjualan) onPilihItem;

  TabKatalog({
    required this.daftarItem,
    required this.onPilihItem,
  });

  Widget buildProductCard(ItemPenjualan item) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 2,
      child: InkWell(
        onTap: () {
          onPilihItem(item);
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(8),
                color: Colors.indigo.shade50,
                width: double.infinity,
                child: Image.asset(
                  item.foto,
                  fit: BoxFit.contain,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.nama,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Rp ${item.harga}',
                    style: TextStyle(color: Colors.green.shade700),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.all(12),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
        childAspectRatio: 0.72,
      ),
      itemCount: daftarItem.length,
      itemBuilder: (context, index) {
        return buildProductCard(daftarItem[index]);
      },
    );
  }
}
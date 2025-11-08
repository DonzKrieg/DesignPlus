import 'package:flutter/material.dart';
import 'package:designplus/shared/theme.dart';

class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> notifications = [
      {
        'title': 'Pesanan #DP12345 sedang diproses',
        'subtitle': 'Pesanan Anda telah diterima dan sedang dikemas.',
        'time': '5 menit yang lalu',
        'icon': Icons.shopping_bag_outlined,
        'color': kPrimaryColor,
      },
      {
        'title': 'Pembayaran berhasil',
        'subtitle': 'Transaksi Anda sebesar Rp120.000 telah dikonfirmasi.',
        'time': '1 jam yang lalu',
        'icon': Icons.check_circle_outline,
        'color': Colors.green,
      },
      {
        'title': 'Promo spesial hari ini!',
        'subtitle': 'Dapatkan diskon 30% untuk semua produk media promosi.',
        'time': '2 jam yang lalu',
        'icon': Icons.local_offer_outlined,
        'color': Colors.orange,
      },
      {
        'title': 'Pesanan #DP12299 telah dikirim',
        'subtitle': 'Pesanan Anda sedang dalam perjalanan.',
        'time': 'Kemarin',
        'icon': Icons.local_shipping_outlined,
        'color': Colors.blue,
      },
    ];

    return Scaffold(
      backgroundColor: kBackgroundColor,
      appBar: AppBar(
        backgroundColor: kWhiteColor,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'Notifikasi',
          style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 18),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black),
          onPressed: () {
            Navigator.pop(context); //
          },
        ),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notif = notifications[index];
          return Container(
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: kWhiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: ListTile(
              leading: Container(
                height: 42,
                width: 42,
                decoration: BoxDecoration(
                  color: notif['color'].withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(notif['icon'], color: notif['color'], size: 24),
              ),
              title: Text(
                notif['title'],
                style: blackTextStyle.copyWith(
                  fontWeight: medium,
                  fontSize: 14,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text(
                    notif['subtitle'],
                    style: greyTextStyle.copyWith(fontSize: 12),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    notif['time'],
                    style: greyTextStyle.copyWith(fontSize: 11),
                  ),
                ],
              ),
              isThreeLine: true,
              onTap: () {
              },
            ),
          );
        },
      ),
    );
  }
}

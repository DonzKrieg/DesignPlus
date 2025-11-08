import 'package:designplus/shared/theme.dart';
import 'package:flutter/material.dart';

class ReviewCard extends StatelessWidget {
  final String username;
  final String avatarImg;
  final List<String> reviewImg;
  final String reviewMsg;
  final DateTime reviewDate;

  ReviewCard({
    super.key,
    required this.username,
    required this.avatarImg,
    List<String>? reviewImg,
    this.reviewMsg = 'Tidak ada pesan',
    DateTime? reviewDate,
  }) : reviewDate = reviewDate ?? DateTime.now(),
       reviewImg = reviewImg ?? const <String>[];

  String _getMonthName(int month) {
    const months = [
      'Januari',
      'Februari',
      'Maret',
      'April',
      'Mei',
      'Juni',
      'Juli',
      'Agustus',
      'September',
      'Oktober',
      'November',
      'Desember',
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(radius: 20, backgroundImage: AssetImage(avatarImg)),
              SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    username,
                    style: blackTextStyle.copyWith(
                      fontSize: 14,
                      fontWeight: bold,
                    ),
                  ),
                  SizedBox(height: 2),
                  Text(
                    '${reviewDate.day.toString()}, ${_getMonthName(reviewDate.month)} ${reviewDate.year.toString()}',
                    style: secondaryTextStyle.copyWith(fontSize: 12),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.more_vert),
                onPressed: () {
                  // more
                },
                color: kSecondaryColor,
              ),
            ],
          ),
          SizedBox(height: 8),
          Text(reviewMsg, style: blackTextStyle.copyWith(fontSize: 12)),
          SizedBox(height: 8),
          if (reviewImg.isNotEmpty)
            SizedBox(
              height: 80,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: reviewImg.length,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.only(right: 8),
                    child: Container(
                      width: 80,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                          image: AssetImage(reviewImg[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}

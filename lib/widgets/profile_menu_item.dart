import 'package:designplus/shared/theme.dart';
import 'package:flutter/material.dart';

class ProfileMenuItem extends StatelessWidget {
  final String title;
  final String value;
  final VoidCallback? onTap;

  const ProfileMenuItem({
    super.key,
    required this.title,
    required this.value,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 12),
      decoration: BoxDecoration(
        border: Border(bottom: BorderSide(color: kLightGreyColor)),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: blackTextStyle.copyWith(fontWeight: semiBold, fontSize: 12),
          ),
          SizedBox(width: 30),
          Flexible(
            child: GestureDetector(
              onTap: onTap,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Flexible(
                    child: Text(
                      value,
                      style: greyTextStyle.copyWith(fontSize: 12),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                  SizedBox(width: 4),
                  Icon(Icons.chevron_right, color: kGreyColor, size: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

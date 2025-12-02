import 'package:designplus/shared/theme.dart';
import 'package:flutter/material.dart';

class EditProfileFieldPage extends StatefulWidget {
  final String title;
  final String initialValue;
  final String hint;
  final String description;

  const EditProfileFieldPage({
    super.key,
    required this.title,
    required this.initialValue,
    required this.hint,
    required this.description,
  });

  @override
  State<EditProfileFieldPage> createState() => _EditProfileFieldPageState();
}

class _EditProfileFieldPageState extends State<EditProfileFieldPage> {
  late TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController(text: widget.initialValue);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteColor,
      appBar: AppBar(
        actionsPadding: EdgeInsets.only(right: 24),
        backgroundColor: kWhiteColor,
        elevation: 0,
        leadingWidth: 80,
        leading: Container(
          margin: EdgeInsets.only(left: 24),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xffE9EBFC),
              borderRadius: BorderRadius.circular(12),
            ),
            child: IconButton(
              icon: Icon(
                Icons.arrow_back_ios_new,
                color: kPrimaryColor,
                size: 20,
              ),
              onPressed: () => Navigator.pop(context),
            ),
          ),
        ),
        title: Text(
          'Ubah ${widget.title}',
          style: blackTextStyle.copyWith(fontWeight: bold, fontSize: 18),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.description,
              style: greyTextStyle.copyWith(fontSize: 13),
            ),
            SizedBox(height: 24),
            Text(
              widget.title,
              style: blackTextStyle.copyWith(fontWeight: medium),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _controller,
              decoration: InputDecoration(
                hintText: widget.hint,
                hintStyle: greyTextStyle.copyWith(fontSize: 16),
                filled: true,
                fillColor: Color(0xffE9EBFC),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8),
                  borderSide: BorderSide.none,
                ),
                suffixIcon: _controller.text.isNotEmpty
                    ? IconButton(
                        icon: Icon(Icons.close, color: kGreyColor),
                        onPressed: () => setState(() => _controller.clear()),
                      )
                    : null,
              ),
              onChanged: (_) => setState(() {}),
            ),
            SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _controller.text.isEmpty
                    ? null
                    : () {
                        // Simpan perubahan
                        Navigator.pop(context, _controller.text);
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: kPrimaryColor,
                  foregroundColor: kBlackColor,
                  padding: EdgeInsets.symmetric(vertical: 14),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Text(
                  'Simpan',
                  style: blackTextStyle.copyWith(
                    fontWeight: bold,
                    fontSize: 16,
                    color: _controller.text.isEmpty ? kGreyColor : kWhiteColor,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

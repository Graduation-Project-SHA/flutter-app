import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class Sendingthecard extends StatefulWidget {
  final String? syndicateCardPath;
  final Function(String) onImagePicked;
  final String label;


  const Sendingthecard({
    super.key,
    required this.syndicateCardPath,
    required this.onImagePicked,
    required this.label,
  });

  @override
  State<Sendingthecard> createState() => _SendingthecardState();
}

class _SendingthecardState extends State<Sendingthecard> {
  bool _isPicking = false;
  Future<void> _pickImage() async {
    if (_isPicking) return;
    setState(() => _isPicking = true);
    try {
      final picker = ImagePicker();
      final XFile? image = await picker.pickImage(
          imageQuality: 25,
          source: ImageSource.camera);

      if (image != null) {
        widget.onImagePicked(image.path);
      }
    } finally {
      setState(() => _isPicking = false);
    }
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 30),
        Text(
          'لماذا ارسل كارنيه النقابة؟',
          style: TextStyle(
            fontSize: 24.sp,
            fontWeight: FontWeight.w700,
          ),
        ),

        SizedBox(height: 30),

        GestureDetector(
          onTap: _pickImage,
          child: Container(
            height: 160.h,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey),
            ),
            child: widget.syndicateCardPath == null
                ? Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.camera_alt, size: 40),
                SizedBox(height: 8),
                Text("اضغط لتصوير كارنيه النقابة"),
              ],
            )
                : ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.file(
                File(widget.syndicateCardPath!),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:io';
import 'package:flutter/material.dart';

class PhotoPreview extends StatelessWidget {
  final File? imageFile;
  const PhotoPreview({super.key, this.imageFile});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 12,
            offset: Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(18),
        child: imageFile == null
            ? Center(
                child: Icon(
                  Icons.camera_alt_outlined,
                  size: 48,
                  color: Colors.grey.shade400,
                ),
              )
            : Image.file(imageFile!, fit: BoxFit.cover),
      ),
    );
  }
}

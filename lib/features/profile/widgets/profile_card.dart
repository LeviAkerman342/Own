import 'dart:io';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:own/core/storage/hive_storage.dart';

class ProfileCard extends StatefulWidget {
  const ProfileCard({super.key});

  @override
  State<ProfileCard> createState() => _ProfileCardState();
}

class _ProfileCardState extends State<ProfileCard> {
  File? _imageFile;
  String? _name;
  String? _email;

  @override
  void initState() {
    super.initState();
    _name = HiveStorage.getUserName();
    _email = Hive.box('authBox').get('email');
    final photoPath = HiveStorage.getUserPhoto();
    if (photoPath != null) _imageFile = File(photoPath);
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.gallery);
    if (picked != null) {
      await HiveStorage.setUserPhoto(picked.path);
      setState(() => _imageFile = File(picked.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: CircleAvatar(
                radius: 38,
                backgroundImage: _imageFile != null
                    ? FileImage(_imageFile!)
                    : const AssetImage('assets/images/avatar_placeholder.png')
                          as ImageProvider,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _name ?? "Имя не указано",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _email ?? "Email не найден",
                    style: const TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

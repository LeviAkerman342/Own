import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:own/features/transactions/domain/entities/note_entity.dart';
import 'package:own/features/transactions/presentation/cubit/notes_cubit.dart';
import 'package:own/features/transactions/widgets/category_dropdown.dart';
import 'package:own/features/transactions/widgets/photo_preview.dart';
import 'package:uuid/uuid.dart';

class AddTransactionScreen extends StatefulWidget {
  const AddTransactionScreen({super.key});

  @override
  State<AddTransactionScreen> createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _form = GlobalKey<FormState>();
  final _amountCtrl = TextEditingController();
  final _commentCtrl = TextEditingController();
  String _category = 'Еда';
  File? _image;
  final _picker = ImagePicker();

  Future<void> _pickPhoto() async {
    final p = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 70,
    );
    if (p != null) setState(() => _image = File(p.path));
  }

  void _save() async {
    if (!_form.currentState!.validate()) return;

    final cubit = context.read<TransactionsCubit>();
    final entity = TransactionEntity(
      id: const Uuid().v4(),
      amount: double.tryParse(_amountCtrl.text.replaceAll(',', '.')) ?? 0.0,
      category: _category,
      comment: _commentCtrl.text.isEmpty ? null : _commentCtrl.text,
      photoPath: _image?.path,
      date: DateTime.now(),
      user: 'Я',
    );

    await cubit.add(entity);
    if (context.mounted) Navigator.of(context).pop();
  }

  @override
  void dispose() {
    _amountCtrl.dispose();
    _commentCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF6F7FB),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.black),
        title: const Text('Новая трата', style: TextStyle(color: Colors.black)),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _form,
          child: ListView(
            children: [
              GestureDetector(
                onTap: _pickPhoto,
                child: PhotoPreview(imageFile: _image),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountCtrl,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                decoration: const InputDecoration(labelText: 'Сумма'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Введите сумму' : null,
              ),
              const SizedBox(height: 12),
              CategoryDropdown(
                value: _category,
                onChanged: (v) => setState(() => _category = v),
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _commentCtrl,
                decoration: const InputDecoration(labelText: 'Комментарий'),
                maxLines: 3,
              ),
              const SizedBox(height: 20),
              FilledButton(
                onPressed: _save,
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 14),
                  child: Text(
                    'Сохранить',
                    style: TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

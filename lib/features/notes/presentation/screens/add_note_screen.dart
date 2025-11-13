import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:own/features/analytics/widgets/back_button_widget.dart';
import 'package:own/features/notes/widgets/category_dropdown.dart';
import 'package:uuid/uuid.dart';
import '../../domain/entities/note_entity.dart';
import '../providers/notes_provider.dart';

class AddNoteScreen extends ConsumerStatefulWidget {
  const AddNoteScreen({super.key});

  @override
  ConsumerState<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends ConsumerState<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleCtrl = TextEditingController();
  final _amountCtrl = TextEditingController();
  String? _category;
  String _currency = 'MDL';
  File? _imageFile;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final picked = await picker.pickImage(source: ImageSource.camera);
    if (picked != null) setState(() => _imageFile = File(picked.path));
  }

  void _saveNote() {
    if (!_formKey.currentState!.validate()) return;

    final note = NoteEntity(
      id: const Uuid().v4(),
      title: _titleCtrl.text,
      amount: double.parse(_amountCtrl.text),
      category: _category ?? 'Прочее',
      currency: _currency,
      date: DateTime.now(),
      imagePath: _imageFile?.path,
    );

    ref.read(notesProvider.notifier).addNote(note);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: scheme.surface,
      appBar: AppBar(
        title: const Text('Новая трата'),
        leading: const BackButtonWidget(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              TextFormField(
                controller: _titleCtrl,
                decoration: const InputDecoration(labelText: 'Описание'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Введите описание' : null,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _amountCtrl,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Сумма'),
                validator: (v) =>
                    v == null || v.isEmpty ? 'Введите сумму' : null,
              ),
              const SizedBox(height: 12),
              CategoryDropdown(
                value: _category,
                onChanged: (val) => setState(() => _category = val),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: _currency,
                decoration: const InputDecoration(labelText: 'Валюта'),
                items: const [
                  DropdownMenuItem(value: 'MDL', child: Text('MDL')),
                  DropdownMenuItem(value: 'USD', child: Text('USD')),
                  DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                ],
                onChanged: (v) => setState(() => _currency = v!),
              ),
              const SizedBox(height: 20),
              if (_imageFile != null)
                Image.file(_imageFile!, height: 120, fit: BoxFit.cover),
              const SizedBox(height: 10),
              OutlinedButton.icon(
                onPressed: _pickImage,
                icon: const Icon(Icons.camera_alt_rounded),
                label: const Text('Добавить фото чека'),
              ),
              const SizedBox(height: 24),
              FilledButton(
                onPressed: _saveNote,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 52),
                ),
                child: const Text('Сохранить'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

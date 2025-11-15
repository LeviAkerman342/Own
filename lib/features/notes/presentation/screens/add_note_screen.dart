import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:own/features/notes/widgets/back_button_widget.dart';
import 'package:uuid/uuid.dart';

import 'package:own/features/analytics/widgets/analytics_pie_chart_block.dart';
import 'package:own/features/notes/widgets/category_dropdown.dart';

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
        elevation: 0,
        backgroundColor: scheme.surface,
      ),

      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
        child: Form(
          key: _formKey,
          child: ListView(
            physics: const BouncingScrollPhysics(),
            children: [
              // CARD: INPUTS
              _GlassSection(
                child: Column(
                  children: [
                    _GlassTextField(
                      controller: _titleCtrl,
                      label: 'Описание',
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Введите описание' : null,
                    ),
                    const SizedBox(height: 16),

                    _GlassTextField(
                      controller: _amountCtrl,
                      label: 'Сумма',
                      keyboard: TextInputType.number,
                      validator: (v) =>
                          v == null || v.isEmpty ? 'Введите сумму' : null,
                    ),
                    const SizedBox(height: 16),

                    CategoryDropdown(
                      value: _category,
                      onChanged: (val) => setState(() => _category = val),
                    ),

                    const SizedBox(height: 16),

                    DropdownButtonFormField<String>(
                      value: _currency,
                      decoration: const InputDecoration(
                        labelText: 'Валюта',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16)),
                        ),
                      ),
                      items: const [
                        DropdownMenuItem(value: 'MDL', child: Text('MDL')),
                        DropdownMenuItem(value: 'USD', child: Text('USD')),
                        DropdownMenuItem(value: 'EUR', child: Text('EUR')),
                      ],
                      onChanged: (v) => setState(() => _currency = v!),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // PHOTO PICKER
              _GlassSection(
                child: Column(
                  children: [
                    if (_imageFile != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(20),
                        child: Image.file(
                          _imageFile!,
                          height: 150,
                          width: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      ),

                    const SizedBox(height: 16),

                    FilledButton.tonalIcon(
                      onPressed: _pickImage,
                      icon: const Icon(Icons.camera_alt_rounded),
                      label: const Text('Добавить фото чека'),
                      style: FilledButton.styleFrom(
                        minimumSize: const Size(double.infinity, 52),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // SAVE BUTTON
              FilledButton(
                onPressed: _saveNote,
                style: FilledButton.styleFrom(
                  minimumSize: const Size(double.infinity, 58),
                  textStyle: const TextStyle(fontSize: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(22),
                  ),
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

// --- UI COMPONENTS ---

class _GlassSection extends StatelessWidget {
  final Widget child;
  const _GlassSection({required this.child});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: scheme.surface.withOpacity(0.7),
        borderRadius: BorderRadius.circular(26),
        border: Border.all(color: scheme.outlineVariant.withOpacity(0.3)),
        boxShadow: [
          BoxShadow(
            color: scheme.shadow.withOpacity(0.08),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: child,
    );
  }
}

class _GlassTextField extends StatelessWidget {
  final TextEditingController controller;
  final String label;
  final TextInputType? keyboard;
  final String? Function(String?)? validator;

  const _GlassTextField({
    required this.controller,
    required this.label,
    this.keyboard,
    this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboard,
      decoration: InputDecoration(
        labelText: label,
        filled: true,
        fillColor: Colors.transparent,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(18),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
      ),
    );
  }
}

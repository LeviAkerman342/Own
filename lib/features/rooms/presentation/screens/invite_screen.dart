import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:math' show Random;

class InviteScreen extends StatefulWidget {
  const InviteScreen({super.key});

  @override
  State<InviteScreen> createState() => _InviteScreenState();
}

class _InviteScreenState extends State<InviteScreen> {
  late String inviteCode;
  final String inviteLink = "https://own.app/join/room/";
  final TextEditingController _descriptionController = TextEditingController();

  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    inviteCode = _generateCode();
    _descriptionController.text = "Семейный бюджет"; // значение по умолчанию
  }

  @override
  void dispose() {
    _descriptionController.dispose();
    super.dispose();
  }

  String _generateCode() {
    const chars = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    final random = Random();
    final code = List.generate(
      12,
      (_) => chars[random.nextInt(chars.length)],
    ).join();
    return '${code.substring(0, 4)}-${code.substring(4, 8)}-${code.substring(8)}';
  }

  Future<void> _requestContactsPermission() async {
    final status = await Permission.contacts.request();

    if (status.isGranted) {
      setState(() => isLoading = true);
      try {
        final fetched = await FlutterContacts.getContacts(
          withProperties: true,
          withPhoto: true,
          withThumbnail: true,
        );

        setState(() {
          contacts = fetched.where((c) => c.phones.isNotEmpty).toList();
          filteredContacts = contacts;
        });
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Ошибка загрузки контактов: $e")),
        );
      } finally {
        setState(() => isLoading = false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text("Доступ к контактам запрещён"),
          action: SnackBarAction(
            label: "Настройки",
            onPressed: openAppSettings,
          ),
        ),
      );
    }
  }

  void _copyLink() {
    final description = _descriptionController.text.trim().isEmpty
        ? "Комната трат"
        : _descriptionController.text.trim();

    final fullLink = "$inviteLink$inviteCode";
    final message =
        "Присоединяйся к комнате «$description»!\n\nКод: $inviteCode\nСсылка: $fullLink";

    Clipboard.setData(ClipboardData(text: message));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text("Ссылка + описание скопированы!"),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _search(String query) {
    setState(() {
      filteredContacts = query.isEmpty
          ? contacts
          : contacts
                .where(
                  (c) =>
                      c.displayName.toLowerCase().contains(query.toLowerCase()),
                )
                .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Пригласить Участника",
          style: TextStyle(fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Поделись Кодом / Ссылкой",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // ПОЛЕ ОПИСАНИЯ
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(
                hintText:
                    "Например: Семейный бюджет, Поездка в горы, Квартира на троих...",
                labelText: "Описание комнаты",
                prefixIcon: const Icon(Icons.edit_note_outlined),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),

            const SizedBox(height: 20),

            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 40,
                  vertical: 28,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.grey.shade300),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                    ),
                  ],
                ),
                child: Text(
                  inviteCode,
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    letterSpacing: 6,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 20),

            // КНОПКА КОПИРОВАТЬ (с описанием!)
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _copyLink,
                icon: const Icon(Icons.link),
                label: const Text("Скопировать ссылку с описанием"),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF5E7CFF),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),
            const Text(
              "Или выбери из контактов",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),

            // Загрузка контактов
            if (contacts.isEmpty && !isLoading)
              Center(
                child: ElevatedButton.icon(
                  onPressed: _requestContactsPermission,
                  icon: const Icon(Icons.contacts_outlined),
                  label: const Text("Загрузить контакты"),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey[300],
                    foregroundColor: Colors.black87,
                  ),
                ),
              ),

            if (contacts.isNotEmpty)
              TextField(
                onChanged: _search,
                decoration: InputDecoration(
                  hintText: "Поиск по имени",
                  prefixIcon: const Icon(Icons.search),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),

            const SizedBox(height: 16),

            Expanded(
              child: isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredContacts.isEmpty && contacts.isNotEmpty
                  ? const Center(child: Text("Ничего не найдено"))
                  : ListView.builder(
                      itemCount: filteredContacts.length,
                      itemBuilder: (ctx, i) {
                        final contact = filteredContacts[i];
                        final phone = contact.phones.isNotEmpty
                            ? contact.phones.first.number
                            : "Нет номера";

                        return Card(
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundImage: contact.photo != null
                                  ? MemoryImage(contact.photo!)
                                  : null,
                              child: contact.photo == null
                                  ? Text(
                                      contact.displayName.isNotEmpty
                                          ? contact.displayName[0].toUpperCase()
                                          : "?",
                                    )
                                  : null,
                            ),
                            title: Text(contact.displayName ?? "Без имени"),
                            subtitle: Text(phone),
                            trailing: ElevatedButton(
                              onPressed: () {
                                final desc =
                                    _descriptionController.text.trim().isEmpty
                                    ? "комнате трат"
                                    : "«${_descriptionController.text.trim()}»";
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Приглашение в $desc отправлено ${contact.displayName}",
                                    ),
                                  ),
                                );
                              },
                              style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF5E7CFF),
                              ),
                              child: const Text(
                                "Пригласить",
                                style: TextStyle(fontSize: 13),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
            ),

            const Padding(
              padding: EdgeInsets.only(top: 16),
              child: Text(
                "Участник увидит только данные этой комнаты",
                style: TextStyle(color: Colors.grey, fontSize: 12),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

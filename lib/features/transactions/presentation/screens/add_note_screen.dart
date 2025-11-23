import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AddNoteScreen extends StatefulWidget {
  const AddNoteScreen({super.key});

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final TextEditingController _amountController = TextEditingController(
    text: '0',
  );
  final TextEditingController _commentController = TextEditingController();
  String selectedCategory = 'Еда';

  final List<Map<String, dynamic>> categories = [
    {'name': 'Еда', 'icon': Icons.restaurant, 'color': Colors.green},
    {'name': 'Транспорт', 'icon': Icons.directions_car, 'color': Colors.blue},
    {'name': 'Покупки', 'icon': Icons.shopping_bag, 'color': Colors.purple},
    {'name': 'Развлечения', 'icon': Icons.movie, 'color': Colors.orange},
    {'name': 'Жилье', 'icon': Icons.home, 'color': Colors.brown},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F7FF),
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.close, color: Colors.black87),
          onPressed: () => context.pop(),
        ),
        title: const Text(
          'Новая трата',
          style: TextStyle(color: Colors.black87, fontWeight: FontWeight.w600),
        ),
        centerTitle: true,
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16),
            child: Icon(Icons.more_vert, color: Colors.black54),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            const SizedBox(height: 20),

            // СУММА — КАК НА МАКЕТЕ
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(24),
                border: Border.all(color: const Color(0xFFE3F2FD), width: 3),
                boxShadow: [
                  BoxShadow(
                    // ignore: deprecated_member_use
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 20,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: _amountController,
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      style: const TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        hintText: '0',
                        hintStyle: TextStyle(fontSize: 48, color: Colors.grey),
                      ),
                    ),
                  ),
                  const Text(
                    '₽',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // ТРИ КНОПКИ: Скан, Голос, Галерея
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildActionButton(
                  Icons.camera_alt,
                  'Скан чека',
                  onTap: () async {
                    final amount = await context.push<double>(
                      '/receipt-scanner',
                    );
                    if (amount != null && amount > 0) {
                      setState(() {
                        _amountController.text = amount.toStringAsFixed(0);
                      });
                    }
                  },
                ),
                _buildActionButton(Icons.mic, 'Голосом'),
                _buildActionButton(Icons.photo_library, 'Галерея'),
              ],
            ),

            const SizedBox(height: 32),

            // КАТЕГОРИЯ
            _buildTextField(
              label: 'Категория',
              hint: selectedCategory,
              trailing: const Icon(
                Icons.keyboard_arrow_down,
                color: Colors.grey,
              ),
              onTap: () {
                // Пока заглушка
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('Выбор категории — скоро!')),
                );
              },
            ),

            const SizedBox(height: 16),

            // КОММЕНТАРИЙ
            _buildTextField(
              label: 'Комментарий',
              hint: 'Например: Продукты в Пятерочке',
              controller: _commentController,
            ),

            const SizedBox(height: 32),

            // КАТЕГОРИИ ВНИЗУ — ГОРИЗОНТАЛЬНАЯ ПРОКРУТКА
            SizedBox(
              height: 90,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (_, __) => const SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final cat = categories[index];
                  final isSelected = selectedCategory == cat['name'];
                  return GestureDetector(
                    onTap: () => setState(() => selectedCategory = cat['name']),
                    child: Column(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? cat['color'].withOpacity(0.15)
                                : Colors.grey[100],
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            cat['icon'],
                            size: 28,
                            color: isSelected ? cat['color'] : Colors.grey[600],
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          cat['name'],
                          style: TextStyle(
                            fontSize: 12,
                            color: isSelected ? cat['color'] : Colors.grey[600],
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            const Spacer(),

            // КНОПКА СОХРАНИТЬ — БОЛЬШАЯ ГАЛОЧКА
            Padding(
              padding: const EdgeInsets.only(bottom: 30),
              child: FloatingActionButton.extended(
                onPressed: () {
                  context.pop();
                },
                backgroundColor: const Color(0xFF5E7CFF),
                elevation: 10,
                icon: const Icon(Icons.check, size: 32),
                label: const Text(
                  'СОХРАНИТЬ',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
    IconData icon,
    String label, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.08),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Icon(icon, size: 28, color: Colors.black87),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required String hint,
    Widget? trailing,
    TextEditingController? controller,
    VoidCallback? onTap,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(fontSize: 16, color: Colors.black54),
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  // ignore: deprecated_member_use
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                ),
              ],
            ),
            child: Row(
              children: [
                Expanded(
                  child: Text(
                    controller?.text.isNotEmpty == true
                        ? controller!.text
                        : hint,
                    style: TextStyle(
                      fontSize: 17,
                      color: controller?.text.isNotEmpty == true
                          ? Colors.black87
                          : Colors.grey[500],
                    ),
                  ),
                ),
                if (trailing != null) trailing,
              ],
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.teal,
        useMaterial3: true,
      ),
      home: const RectangleScreen(),
    );
  }
}

class RectangleScreen extends StatefulWidget {
  const RectangleScreen({super.key});

  @override
  State<RectangleScreen> createState() => _RectangleScreenState();
}

class _RectangleScreenState extends State<RectangleScreen> {
  // Контроллеры для полей
  final _wController = TextEditingController();
  final _hController = TextEditingController();
  final _cController = TextEditingController();

  // Начальные значения
  double _currentWidth = 150;
  double _currentHeight = 150;
  Color _currentColor = Colors.teal;

  // Функция для «умного» поиска цвета
  void _drawShape() {
    setState(() {
      // Пытаемся считать числа, если пусто или текст — ставим 100
      _currentWidth = double.tryParse(_wController.text) ?? 100;
      _currentHeight = double.tryParse(_hController.text) ?? 100;

      // Логика подбора цвета
      String colorInput = _cController.text.toLowerCase().trim();
      _currentColor = _getColorFromString(colorInput);
    });
  }

  Color _getColorFromString(String name) {
    switch (name) {
      case 'red': return Colors.red;
      case 'blue': return Colors.blue;
      case 'green': return Colors.green;
      case 'yellow': return Colors.yellow;
      case 'orange': return Colors.orange;
      case 'pink': return Colors.pink;
      case 'black': return Colors.black;
      case 'purple': return Colors.purple;
      default: return Colors.teal; // Цвет по умолчанию
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Shape Master 2.0'),
        centerTitle: true,
        backgroundColor: Colors.teal.withOpacity(0.1),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Блок ввода ширины
            _buildInputField(_wController, 'Ширина (Width)', Icons.reorder),
            const SizedBox(height: 15),

            // Блок ввода высоты
            _buildInputField(_hController, 'Высота (Height)', Icons.height),
            const SizedBox(height: 15),

            // Блок ввода цвета
            _buildInputField(_cController, 'Цвет (например: red, blue)', Icons.color_lens),

            const SizedBox(height: 30),

            // Кнопка Calculate
            ElevatedButton.icon(
              onPressed: _drawShape,
              icon: const Icon(Icons.play_arrow),
              label: const Text('CALCULATE & DRAW', style: TextStyle(fontSize: 16)),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.all(15),
                backgroundColor: Colors.teal,
                foregroundColor: Colors.white,
              ),
            ),

            const SizedBox(height: 40),

            // Результат
            Center(
              child: Column(
                children: [
                  Text(
                    'Размер: ${_currentWidth.toInt()} x ${_currentHeight.toInt()}',
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  ),
                  const SizedBox(height: 15),
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 400),
                    width: _currentWidth,
                    height: _currentHeight,
                    decoration: BoxDecoration(
                      color: _currentColor,
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: _currentColor.withOpacity(0.4),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        )
                      ],
                    ),
                    child: const Center(
                      child: Icon(Icons.view_in_ar, color: Colors.white, size: 30),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Вспомогательный виджет для красивых полей ввода
  Widget _buildInputField(TextEditingController controller, String label, IconData icon) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: Colors.teal),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
        filled: true,
        fillColor: Colors.grey[50],
      ),
      keyboardType: label.contains('Цвет') ? TextInputType.text : TextInputType.number,
    );
  }
}
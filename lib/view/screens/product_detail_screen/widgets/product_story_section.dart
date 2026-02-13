import 'package:jewellery/core/theme/app_imports.dart';

class ProductStorySection extends StatelessWidget {
  const ProductStorySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: const Text(
        "Designed in limited quantities, the Eclipse Signature Ring embodies modern restraint and timeless precision. Each piece is individually finished to reflect depth and presence.",
        style: TextStyle(fontSize: 15, height: 1.6, color: Colors.white70),
      ),
    );
  }
}

import 'package:jewellery/core/theme/app_imports.dart';

class ProductCraftSection extends StatelessWidget {
  const ProductCraftSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 40),
      child: Column(
        children: const [
          CraftRow(title: "Material", value: "18k Gold"),
          CraftRow(title: "Finish", value: "Matte Polished"),
          CraftRow(title: "Weight", value: "8.5g"),
          CraftRow(title: "Care", value: "Avoid Chemicals"),
        ],
      ),
    );
  }
}

class CraftRow extends StatelessWidget {
  final String title;
  final String value;

  const CraftRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(title, style: const TextStyle(color: Colors.white70)),
          Text(
            value,
            style: TextStyle(color: CustomColor.yellowPrimary, fontWeight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

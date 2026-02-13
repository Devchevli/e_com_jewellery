import 'package:jewellery/core/theme/app_imports.dart';

class ProductIdentitySection extends StatelessWidget {
  const ProductIdentitySection({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Eclipse Signature Ring",
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w600, color: Colors.white),
          ),

          const SizedBox(height: 12),

          Text(
            "₹ 18,499",
            style: TextStyle(
              fontSize: 20,
              color: CustomColor.yellowPrimary,
              fontWeight: FontWeight.w600,
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "Crafted for those who understand restraint.",
            style: TextStyle(fontSize: 15, color: Colors.white70),
          ),
        ],
      ),
    );
  }
}

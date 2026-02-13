import 'package:jewellery/core/theme/app_imports.dart';

class QuickActionsRow extends StatelessWidget {
  const QuickActionsRow({super.key});

  @override
  Widget build(BuildContext context) {
    final actions = ["Orders", "Wishlist", "Saved"];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: actions.map((title) {
          return Column(
            children: [
              Container(
                padding: const EdgeInsets.all(18),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: CustomColor.yellowPrimary.withOpacity(0.4)),
                ),
                child: Icon(Icons.circle, size: 12, color: CustomColor.yellowPrimary),
              ),
              const SizedBox(height: 12),
              Text(title, style: const TextStyle(color: Colors.white)),
            ],
          );
        }).toList(),
      ),
    );
  }
}

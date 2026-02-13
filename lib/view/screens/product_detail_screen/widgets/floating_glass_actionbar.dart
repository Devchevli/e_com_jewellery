import 'package:jewellery/core/theme/app_imports.dart';

class FloatingGlassActionBar extends StatelessWidget {
  const FloatingGlassActionBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 24,
      right: 24,
      bottom: 30,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 18),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          color: Colors.white.withOpacity(0.05),
          border: Border.all(color: CustomColor.yellowPrimary.withOpacity(0.4)),
        ),
        child: Center(
          child: Text(
            "Add to Cart",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: CustomColor.yellowPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

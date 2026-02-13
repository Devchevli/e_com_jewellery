import 'package:jewellery/core/theme/app_imports.dart';

class MiniCategoryCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(24),
      child: Stack(
        children: [
          Positioned.fill(child: Image.asset(CustomAssets.onboardingOne, fit: BoxFit.cover)),

          Positioned.fill(child: Container(color: Colors.black.withOpacity(0.4))),

          Positioned(
            bottom: 20,
            left: 20,
            child: Text(
              "Bracelets",
              style: TextStyle(color: CustomColor.yellowPrimary, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }
}

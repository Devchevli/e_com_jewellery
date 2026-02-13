import 'package:jewellery/core/theme/app_imports.dart';

class MemberStatusCard extends StatelessWidget {
  const MemberStatusCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Container(
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(28),
          gradient: LinearGradient(
            colors: [CustomColor.appPrimaryColor, CustomColor.appPrimaryColor.withOpacity(0.8)],
          ),
          border: Border.all(color: CustomColor.yellowPrimary.withOpacity(0.3)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Member Since", style: TextStyle(color: Colors.white70)),
            const SizedBox(height: 8),
            Text(
              "January 2026",
              style: TextStyle(
                fontSize: 18,
                color: CustomColor.yellowPrimary,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

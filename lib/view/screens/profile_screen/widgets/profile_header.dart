import 'package:jewellery/core/theme/app_imports.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 100),
      child: Column(
        children: [
          CircleAvatar(
            radius: 55,
            backgroundColor: CustomColor.yellowPrimary.withOpacity(0.2),
            child: const Icon(Icons.person, size: 60, color: Colors.white),
          ),
          const SizedBox(height: 20),
          const Text(
            "Dev Chevli",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w600, color: Colors.white),
          ),
          const SizedBox(height: 6),
          Text(
            "Premium Member",
            style: TextStyle(fontSize: 14, color: CustomColor.yellowPrimary, letterSpacing: 1.2),
          ),
        ],
      ),
    );
  }
}

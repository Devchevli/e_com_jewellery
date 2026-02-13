import 'package:flutter/material.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/view/screens/profile_screen/widgets/member_status_card.dart';
import 'package:jewellery/view/screens/profile_screen/widgets/profile_header.dart';
import 'package:jewellery/view/screens/profile_screen/widgets/profile_options.dart';
import 'package:jewellery/view/screens/profile_screen/widgets/quick_action_row.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.appSecondaryColor,
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(child: ProfileHeader()),

          SliverToBoxAdapter(child: MemberStatusCard()),

          SliverToBoxAdapter(child: QuickActionsRow()),

          SliverList(
            delegate: SliverChildListDelegate([
              ProfileOption(title: "Edit Profile"),
              ProfileOption(title: "Addresses"),
              ProfileOption(title: "Payment Methods"),
              ProfileOption(title: "Notifications"),
              ProfileOption(title: "Support"),
              const SizedBox(height: 40),
              ProfileOption(title: "Logout", isLogout: true),
              const SizedBox(height: 120),
            ]),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/core/widgets/custom_scroll.dart';
import 'package:jewellery/view/screens/wishlist_screen/widgets/empty_vault.dart';
import 'package:jewellery/view/screens/wishlist_screen/widgets/floating_wish_item.dart';
import 'package:jewellery/view/screens/wishlist_screen/widgets/wishlist_card.dart';

class WishlistScreen extends StatelessWidget {
  const WishlistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final items = List.generate(5, (index) => index);

    return Scaffold(
      backgroundColor: CustomColor.appSecondaryColor,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            pinned: true,
            centerTitle: true,
            title: const Text(
              "Your Vault",
              style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
            ),
          ),

          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 60),
            sliver: SliverList(
              delegate: SliverChildBuilderDelegate((context, index) {
                return AnimatedDismissibleCard(key: ValueKey(index), index: index);
              }, childCount: items.length),
            ),
          ),

          const SliverToBoxAdapter(child: SizedBox(height: 120)),
        ],
      ),
    );
  }
}

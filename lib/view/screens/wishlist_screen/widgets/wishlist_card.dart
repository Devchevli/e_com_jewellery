import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:jewellery/core/theme/app_imports.dart';

class WishlistLargeCard extends StatelessWidget {
  final int index;

  const WishlistLargeCard({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: Stack(
          children: [
            Image.asset(
              CustomAssets.onboardingThree,
              height: 320,
              width: double.infinity,
              fit: BoxFit.cover,
            ),

            Positioned.fill(
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [CustomColor.appSecondaryColor.withOpacity(0.95), Colors.transparent],
                  ),
                ),
              ),
            ),

            Positioned(
              bottom: 30,
              left: 24,
              right: 24,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Signature Ring",
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w600,
                      color: CustomColor.yellowPrimary,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    "Saved on 12 Jan 2026",
                    style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6)),
                  ),
                  const SizedBox(height: 12),
                  const Text("₹ 8,499", style: TextStyle(fontSize: 16, color: Colors.white)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnimatedDismissibleCard extends StatefulWidget {
  final int index;

  const AnimatedDismissibleCard({super.key, required this.index});

  @override
  State<AnimatedDismissibleCard> createState() => _AnimatedDismissibleCardState();
}

class _AnimatedDismissibleCardState extends State<AnimatedDismissibleCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _previewController;
  bool _isRemoving = false;

  @override
  void initState() {
    super.initState();

    _previewController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 250),
    );

    // Subtle swipe hint (staggered)
    Future.delayed(Duration(milliseconds: 600 + widget.index * 150), () {
      if (mounted) {
        _previewController.forward().then((_) {
          _previewController.reverse();
        });
      }
    });
  }

  @override
  void dispose() {
    _previewController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _previewController,
      builder: (context, child) {
        final previewOffset = -8 * _previewController.value;

        return Transform.translate(offset: Offset(previewOffset, 0), child: child);
      },
      child: Dismissible(
        key: ValueKey(widget.index),
        direction: DismissDirection.endToStart,
        background: Container(
          alignment: Alignment.centerRight,
          padding: const EdgeInsets.only(right: 30),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(28),
            color: Colors.red.withOpacity(0.15),
          ),
          child: const Icon(Icons.delete, color: Colors.red),
        ),
        confirmDismiss: (_) async {
          setState(() {
            _isRemoving = true;
          });

          await Future.delayed(const Duration(milliseconds: 200));
          return true;
        },
        child: AnimatedScale(
          scale: _isRemoving ? 5 : 1,
          duration: const Duration(milliseconds: 200),
          child: WishlistLargeCard(index: widget.index),
        ),
      ),
    );
  }
}

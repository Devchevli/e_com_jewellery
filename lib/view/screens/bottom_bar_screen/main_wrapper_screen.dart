import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/view/screens/categories_screen/categories_screen.dart';
import 'package:jewellery/view/screens/home_screen/home_screen.dart';
import 'package:jewellery/view/screens/profile_screen/profile_screen.dart';
import 'package:jewellery/view/screens/wishlist_screen/wishlist_screen.dart';

class MainWrapperScreen extends StatefulWidget {
  const MainWrapperScreen({super.key});

  @override
  State<MainWrapperScreen> createState() => _MainWrapperScreenState();
}

class _MainWrapperScreenState extends State<MainWrapperScreen> {
  int currentIndex = 0;

  final List<Widget> pages = [
    const HomeScreen(), // HomeScreen
    const CategoriesScreen(), // CategoriesScreen
    const WishlistScreen(), // WishlistScreen
    const ProfileScreen(), // ProfileScreen
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          IndexedStack(index: currentIndex, children: pages),

          /// Bottom Bar
          Positioned(left: 20, right: 20, bottom: 20, child: _bottomBar()),
        ],
      ),
    );
  }

  Widget _bottomBar() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(30),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 15, sigmaY: 15),
        child: Container(
          height: 70,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.08),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.white12),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _navItem(Icons.home_rounded, "Home", 0),
              _navItem(Icons.grid_view_rounded, "Categories", 1),
              _navItem(Icons.favorite_rounded, "Wishlist", 2),
              _navItem(Icons.person_rounded, "Profile", 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _navItem(IconData icon, String label, int index) {
    final bool isActive = currentIndex == index;

    return GestureDetector(
      onTap: () {
        setState(() {
          currentIndex = index;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: isActive
              ? const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)])
              : null,
        ),
        child: Row(
          children: [
            Icon(icon, size: 20, color: isActive ? Colors.black : Colors.white70),
            if (isActive) ...[
              const SizedBox(width: 6),
              Text(
                label,
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

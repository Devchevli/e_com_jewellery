import 'package:flutter/material.dart';
import 'package:jewellery/core/theme/app_imports.dart';

class MinimalSearchBar extends StatefulWidget {
  const MinimalSearchBar({super.key});

  @override
  State<MinimalSearchBar> createState() => _MinimalSearchBarState();
}

class _MinimalSearchBarState extends State<MinimalSearchBar> {
  bool isFocused = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 60),
      child: GestureDetector(
        onTap: () {
          setState(() {
            isFocused = true;
          });
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.search, size: 18, color: CustomColor.yellowPrimary),
                const SizedBox(width: 12),
                Expanded(
                  child: TextField(
                    autofocus: isFocused,
                    style: const TextStyle(color: Colors.white),
                    decoration: InputDecoration(
                      hintText: "Search rare pieces",
                      hintStyle: TextStyle(color: Colors.white.withOpacity(0.5)),
                      border: InputBorder.none,
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 12),

            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              height: 1,
              width: isFocused ? MediaQuery.of(context).size.width * 0.8 : 120,
              color: CustomColor.yellowPrimary.withOpacity(isFocused ? 0.8 : 0.3),
            ),
          ],
        ),
      ),
    );
  }
}

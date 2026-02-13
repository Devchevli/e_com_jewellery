// import 'package:flutter_animate/flutter_animate.dart';
// import 'package:jewellery/core/theme/app_imports.dart';
//
// class SlideShrinkCard extends StatefulWidget {
//   final int index;
//
//   const SlideShrinkCard({super.key, required this.index});
//
//   @override
//   State<SlideShrinkCard> createState() => _SlideShrinkCardState();
// }
//
// class _SlideShrinkCardState extends State<SlideShrinkCard> {
//   double scale = 1.0;
//
//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 40),
//       child: GestureDetector(
//         onHorizontalDragUpdate: (details) {
//           setState(() {
//             scale = 0.98;
//           });
//         },
//         onHorizontalDragEnd: (_) {
//           setState(() {
//             scale = 1.0;
//           });
//         },
//         child: AnimatedScale(
//           scale: scale,
//           duration: const Duration(milliseconds: 200),
//           child: ClipRRect(
//             borderRadius: BorderRadius.circular(28),
//             child: Stack(
//               children: [
//                 Image.asset(
//                   CustomAssets.onboardingOne,
//                   height: 320,
//                   width: double.infinity,
//                   fit: BoxFit.cover,
//                 ),
//
//                 Positioned.fill(
//                   child: Container(
//                     decoration: BoxDecoration(
//                       gradient: LinearGradient(
//                         begin: Alignment.bottomCenter,
//                         end: Alignment.topCenter,
//                         colors: [
//                           CustomColor.appSecondaryColor.withOpacity(0.95),
//                           Colors.transparent,
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//
//                 Positioned(
//                   bottom: 30,
//                   left: 24,
//                   right: 24,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Text(
//                         "Signature Ring",
//                         style: TextStyle(
//                           fontSize: 22,
//                           fontWeight: FontWeight.w600,
//                           color: CustomColor.yellowPrimary,
//                         ),
//                       ),
//
//                       const SizedBox(height: 6),
//
//                       Text(
//                         "Saved on 12 Jan 2026",
//                         style: TextStyle(fontSize: 13, color: Colors.white.withOpacity(0.6)),
//                       ),
//
//                       const SizedBox(height: 12),
//
//                       const Text("₹ 8,499", style: TextStyle(fontSize: 16, color: Colors.white)),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

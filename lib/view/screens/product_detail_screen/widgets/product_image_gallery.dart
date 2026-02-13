import 'package:jewellery/core/theme/app_imports.dart';

import 'full_Screen_image_viewer.dart';

class ProductImageGallery extends StatelessWidget {
  final List<String> images;
  final PageController pageController;

  const ProductImageGallery({super.key, required this.images, required this.pageController});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.75,
      child: PageView.builder(
        controller: pageController,
        itemCount: images.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                PageRouteBuilder(
                  pageBuilder: (_, __, ___) =>
                      FullScreenImageViewer(images: images, initialIndex: index),
                  transitionsBuilder: (_, animation, __, child) {
                    return FadeTransition(opacity: animation, child: child);
                  },
                ),
              );
            },
            child: Stack(
              fit: StackFit.expand,
              children: [
                Image.asset(images[index], fit: BoxFit.cover),

                /// Dark bottom gradient
                Positioned.fill(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                        colors: [
                          CustomColor.appSecondaryColor.withOpacity(0.9),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

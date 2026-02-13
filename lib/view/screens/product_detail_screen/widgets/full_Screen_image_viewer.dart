import 'package:jewellery/core/theme/app_imports.dart';

class FullScreenImageViewer extends StatefulWidget {
  final List<String> images;
  final int initialIndex;

  const FullScreenImageViewer({super.key, required this.images, required this.initialIndex});

  @override
  State<FullScreenImageViewer> createState() => FullScreenImageViewerState();
}

class FullScreenImageViewerState extends State<FullScreenImageViewer> {
  late PageController controller;

  @override
  void initState() {
    super.initState();
    controller = PageController(initialPage: widget.initialIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: PageView.builder(
        controller: controller,
        itemCount: widget.images.length,
        itemBuilder: (context, index) {
          return InteractiveViewer(child: Image.asset(widget.images[index], fit: BoxFit.contain));
        },
      ),
    );
  }
}

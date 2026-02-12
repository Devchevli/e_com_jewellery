import 'package:jewellery/core/theme/app_imports.dart';

class OnboardingProvider extends ChangeNotifier {
  final PageController pageController = PageController();
  int currentPage = 0;

  void setPage(int index) {
    currentPage = index;
    notifyListeners();
  }

  void nextPage() {
    if (currentPage < 2) {
      pageController.nextPage(duration: const Duration(milliseconds: 400), curve: Curves.ease);
    }
  }

  void skipToEnd() {
    pageController.jumpToPage(2);
  }
}

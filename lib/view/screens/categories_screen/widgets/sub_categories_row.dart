import 'package:jewellery/core/theme/app_imports.dart';

class SubCategoryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final sub = ["Gold", "Silver", "Minimal", "Bridal", "Statement"];

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 40),
      child: SizedBox(
        height: 40,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 24),
          itemCount: sub.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.only(right: 14),
              padding: const EdgeInsets.symmetric(horizontal: 18),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: CustomColor.yellowPrimary.withOpacity(0.4)),
              ),
              alignment: Alignment.center,
              child: Text(sub[index], style: const TextStyle(color: Colors.white)),
            );
          },
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:jewellery/provider/onboardingProvider/onboarding_provider.dart';
import 'package:jewellery/provider/splashScreenProvider/splash_provider.dart';
import 'package:jewellery/view/screens/splashScreen/splash_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690), // fixed
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MultiProvider(
          providers: [
            ChangeNotifierProvider(create: (_) => SplashProvider()),
            ChangeNotifierProvider(create: (_) => OnboardingProvider()),
          ],
          child: MaterialApp(
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              final scale = MediaQuery.of(
                context,
              ).textScaler.clamp(minScaleFactor: 0.8, maxScaleFactor: 1.2);

              return MediaQuery(
                data: MediaQuery.of(context).copyWith(textScaler: scale),
                child: child!,
              );
            },
            home: SplashScreen(),
          ),
        );
      },
    );
  }
}

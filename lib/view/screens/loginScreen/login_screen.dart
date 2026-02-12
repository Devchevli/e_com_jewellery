import 'package:jewellery/core/theme/app_imports.dart';
import 'package:jewellery/core/widgets/custom_textfield.dart';
import 'package:jewellery/view/screens/bottom_bar_screen/main_wrapper_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin {
  bool isLogin = true;

  final TextEditingController firstName = TextEditingController();
  final TextEditingController lastName = TextEditingController();
  final TextEditingController email = TextEditingController();
  final TextEditingController address = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              gradient: RadialGradient(radius: 1.2, colors: [Color(0xff221E10), Color(0xff0A0904)]),
            ),
          ),

          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),

                    /// TITLE
                    CustomText(
                      isLogin ? "Welcome Back" : "Create Account",
                      fontSize: 38,
                      fontWeight: FontWeight.w600,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFFFE082), Color(0xFFD4AF37)],
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// TOGGLE
                    Center(
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white.withOpacity(0.05),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _buildToggleButton("Login", true),
                            _buildToggleButton("Sign Up", false),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),

                    /// FORM AREA WITH ANIMATION
                    AnimatedSwitcher(
                      duration: const Duration(milliseconds: 500),
                      transitionBuilder: (child, animation) {
                        return FadeTransition(
                          opacity: animation,
                          child: SlideTransition(
                            position: Tween<Offset>(
                              begin: const Offset(0.1, 0),
                              end: Offset.zero,
                            ).animate(animation),
                            child: child,
                          ),
                        );
                      },
                      child: isLogin ? _loginForm() : _signupForm(),
                    ),

                    const SizedBox(height: 30),

                    InkWell(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => MainWrapperScreen()),
                        );
                      },
                      child: Container(
                        height: 55,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          color: Colors.white.withOpacity(0.08),
                          border: Border.all(color: Colors.white24),
                        ),
                        child: const Center(
                          child: CustomText(
                            letterSpacing: 3,
                            "Continue with Google",
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String text, bool loginValue) {
    bool isSelected = isLogin == loginValue;

    return GestureDetector(
      onTap: () {
        setState(() {
          isLogin = loginValue;
        });
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: isSelected
              ? const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)])
              : null,
        ),
        child: CustomText(text, color: isSelected ? Colors.black : Colors.white70),
      ),
    );
  }

  Widget _loginForm() {
    return Column(
      key: const ValueKey("login"),
      children: [
        CustomTextField(
          label: "Email Address",
          controller: email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        CustomTextField(label: "Address", controller: address),
        const SizedBox(height: 30),
        _submitButton("Login"),
      ],
    );
  }

  Widget _signupForm() {
    return Column(
      key: const ValueKey("signup"),
      children: [
        CustomTextField(label: "First Name", controller: firstName),
        const SizedBox(height: 20),
        CustomTextField(label: "Last Name", controller: lastName),
        const SizedBox(height: 20),
        CustomTextField(
          label: "Email Address",
          controller: email,
          keyboardType: TextInputType.emailAddress,
        ),
        const SizedBox(height: 20),
        CustomTextField(label: "Address", controller: address),
        const SizedBox(height: 30),
        _submitButton("Sign Up"),
      ],
    );
  }

  Widget _submitButton(String text) {
    return Container(
      height: 55,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        gradient: const LinearGradient(colors: [Color(0xFFD4AF37), Color(0xFFB8860B)]),
      ),
      child: Center(
        child: CustomText(text, color: Colors.black, fontWeight: FontWeight.bold),
      ),
    );
  }
}

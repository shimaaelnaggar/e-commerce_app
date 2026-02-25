import 'package:ecommerce_app/core/widgets/brand_name.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/features/auth/widgets/custom_text_form_field.dart';
import 'package:ecommerce_app/features/auth/widgets/toggle_button.dart';
import 'package:flutter/material.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isLogin = true;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    super.dispose();
  }

  void _submit() {
    if (isLogin) {
      print("Login");
    } else {
      print("Create Account");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 20),

                Center(child: BrandName(fontSize: 28)),

                const SizedBox(height: 40),

                buildToggle(),

                const SizedBox(height: 30),

                if (!isLogin)
                  CustomTextFormField(
                    label: "Name",
                    hint: "Enter your name",
                    controller: nameController,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter your name";
                      }
                      return null;
                    },
                  ),
                // if (!isLogin) const SizedBox(height: 16),
                CustomTextFormField(
                  label: "Email",
                  hint: "Enter your email",
                  controller: emailController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your email";
                    }
                    return null;
                  },
                ),

                CustomTextFormField(
                  label: "Password",
                  hint: "Enter your password",
                  controller: passwordController,
                  obscureText: true,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Please enter your password";
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 30),

                SizedBox(
                  height: 45,
                  child: CustomButton(
                    onPressed: _submit,
                    text: isLogin ? "Login" : "Create Account",
                  ),
                ),

                const SizedBox(height: 20),

                buildSocialButtons(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildToggle() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ToggleButton(
          selected: isLogin,
          text: "Login",
          onTap: () {
            setState(() {
              isLogin = true;
            });
          },
        ),
        const SizedBox(width: 10),
        ToggleButton(
          selected: !isLogin,
          text: "Sign Up",
          onTap: () {
            setState(() {
              isLogin = false;
            });
          },
        ),
      ],
    );
  }

  Widget buildSocialButtons() {
    return Column(
      children: [
        const Text("Or continue with", style: TextStyle(color: Colors.white)),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.g_mobiledata, size: 30, color: Colors.white),
            SizedBox(width: 20),
            Icon(Icons.facebook, size: 30, color: Colors.white),
          ],
        ),
      ],
    );
  }
}

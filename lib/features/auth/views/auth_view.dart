import 'package:ecommerce_app/core/routing/routes.dart';
import 'package:ecommerce_app/core/widgets/brand_name.dart';
import 'package:ecommerce_app/core/widgets/custom_button.dart';
import 'package:ecommerce_app/features/auth/cubit/auth_cubit.dart';
import 'package:ecommerce_app/features/auth/widgets/custom_text_form_field.dart';
import 'package:ecommerce_app/features/auth/widgets/toggle_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AuthView extends StatefulWidget {
  const AuthView({super.key});

  @override
  State<AuthView> createState() => _AuthViewState();
}

class _AuthViewState extends State<AuthView> {
  bool isLogin = true;
  bool isPasswordHidden = true;
  bool isConfirmPasswordHidden = true;
  final _formKey = GlobalKey<FormState>();

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
    if (_formKey.currentState!.validate()) {
      if (isLogin) {
        final name = nameController.text.trim();
        final password = passwordController.text.trim();
        context.read<AuthCubit>().login(name, password);
      } else {
        // final name = nameController.text.trim();
        // final email = emailController.text.trim();
        // final password = passwordController.text.trim();
        // context.read<AuthCubit>().signup(name, email, password);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          nameController.clear();
          passwordController.clear();
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text("Login successful!"),
              backgroundColor: Colors.green,
            ),
          );
          Navigator.pushNamedAndRemoveUntil(
            context,
            Routes.home,
            (route) => false,
          );
        } else if (state is AuthFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text("Login failed: ${state.message}"),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.black,
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(24),
              child: Form(
                key: _formKey,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const SizedBox(height: 20),

                      Center(child: BrandName(fontSize: 28)),

                      const SizedBox(height: 40),

                      buildToggle(),

                      const SizedBox(height: 30),

                      CustomTextFormField(
                        label: "Name",
                        hint: "Enter your name",
                        controller: nameController,
                        textInputAction: TextInputAction.next,
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Please enter your name";
                          }
                          return null;
                        },
                      ),
                      if (!isLogin)
                        CustomTextFormField(
                          label: "Email",
                          hint: "Enter your email",
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Email is required";
                            }

                            final emailRegex = RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            );

                            if (!emailRegex.hasMatch(value)) {
                              return "Enter a valid email address";
                            }

                            return null;
                          },
                        ),

                      CustomTextFormField(
                        label: "Password",
                        hint: "Enter your password",
                        controller: passwordController,
                        obscureText: isPasswordHidden,
                        keyboardType: TextInputType.visiblePassword,
                        textInputAction: TextInputAction.done,
                        suffixIcon: IconButton(
                          icon: Icon(
                            isPasswordHidden
                                ? Icons.visibility_off
                                : Icons.visibility,
                            color: Colors.grey[400],
                          ),
                          onPressed: () {
                            setState(() {
                              isPasswordHidden = !isPasswordHidden;
                            });
                          },
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return "Password is required";
                          }

                          if (value.length < 6) {
                            return "Password must be at least 6 characters";
                          }

                          // if (!RegExp(r'[A-Z]').hasMatch(value)) {
                          //   return "Password must contain at least one uppercase letter";
                          // }

                          // if (!RegExp(r'[0-9]').hasMatch(value)) {
                          //   return "Password must contain at least one number";
                          // }

                          return null;
                        },
                      ),
                      if (!isLogin)
                        CustomTextFormField(
                          label: "Confirm Password",
                          hint: "Re-enter your password",
                          obscureText: isConfirmPasswordHidden,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          suffixIcon: IconButton(
                            icon: Icon(
                              isConfirmPasswordHidden
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                              color: Colors.grey[400],
                            ),
                            onPressed: () {
                              setState(() {
                                isConfirmPasswordHidden =
                                    !isConfirmPasswordHidden;
                              });
                            },
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return "Please confirm your password";
                            }

                            if (value != passwordController.text) {
                              return "Passwords do not match";
                            }

                            return null;
                          },
                        ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: const Text(
                              "Forgot Password?",
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 30),

                      SizedBox(
                        height: 45,
                        child: state is AuthLoading
                            ? Center(
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : CustomButton(
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
          ),
        );
      },
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

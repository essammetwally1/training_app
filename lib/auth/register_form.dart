import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:training_app/components/custom_elevetedbutton.dart';
import 'package:training_app/components/custom_textfeild.dart';
import 'package:training_app/models/user_model.dart';
import 'package:training_app/services/firebase_service.dart';
import 'package:training_app/utilis.dart';

class RegisterForm extends StatefulWidget {
  final VoidCallback? onLoginPressed;
  final VoidCallback? onForgotPasswordPressed;
  final VoidCallback? onCreateAccountPressed;
  final Function(bool)? move;

  const RegisterForm({
    super.key,
    this.onLoginPressed,
    this.onForgotPasswordPressed,
    this.onCreateAccountPressed,
    this.move,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * .1),
          CustomTextField(
            iconPathName: 'profile',
            hintText: 'Enter your user name',
            isPassword: false,
            isEmail: false,
            controller: nameController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter Your Name';
              } else {
                return null;
              }
            },
          ),

          SizedBox(height: 24),

          // Email Field
          CustomTextField(
            iconPathName: 'mail',
            hintText: 'Enter your email',
            isPassword: false,
            isEmail: true,
            controller: emailController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter e-mail';
              } else if (!value.contains('@gmail.com')) {
                return 'Enter valid e-mail';
              } else {
                return null;
              }
            },
          ),

          SizedBox(height: 24),

          // Password Field
          CustomTextField(
            controller: passwordController,
            hintText: 'Password',
            iconPathName: 'password',
            isPassword: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter password';
              } else if (value.length < 9) {
                return 'Password must be at least 9 characters';
              } else if (!RegExp(r'^(?=.*[a-z])').hasMatch(value)) {
                return 'Password must contain lowercase letter';
              } else if (!RegExp(r'^(?=.*[A-Z])').hasMatch(value)) {
                return 'Password must contain uppercase letter';
              } else if (!RegExp(r'^(?=.*[0-9])').hasMatch(value)) {
                return 'Password must contain number';
              } else if (!RegExp(
                r'^(?=.*[!@#$%^&*(),.?":{}|<>])',
              ).hasMatch(value)) {
                return 'Password must contain special character';
              } else {
                return null;
              }
            },
          ),

          SizedBox(height: 24),

          // confirm password Field
          CustomTextField(
            controller: confirmPasswordController,
            hintText: 'Confirm Password',
            iconPathName: 'password',
            isPassword: true,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter confirm password';
              } else if (value != passwordController.text) {
                return 'Passwords do not match';
              } else {
                return null;
              }
            },
          ),

          SizedBox(height: 24),

          // phone number Field
          CustomTextField(
            controller: phoneController,
            hintText: 'Phone Number',
            iconPathName: 'phone',
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter phone number';
              } else if (!value.startsWith('+2')) {
                return 'Phone number must start with +2';
              } else if (!RegExp(r'^\+2[0-9]{11}$').hasMatch(value)) {
                return 'Enter valid phone number (+2 followed by 11 digits)';
              } else {
                return null;
              }
            },
          ),

          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Already Have Account ?',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                ),
              ),
              TextButton(
                onPressed: () {
                  widget.move!(true);
                },
                child: Text(
                  'Login',
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 16),

          // Create Account Button
          CustomElevetedButton(
            isLoading: isLoading,
            text: 'Create Account',
            onPressed: register,
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }

  Future<void> register() async {
    if (globalKey.currentState!.validate()) {
      if (isLoading) return;

      setState(() {
        isLoading = true;
      });

      try {
        final UserModel user = await FirebaseService.register(
          name: nameController.text.trim(),
          password: passwordController.text.trim(),
          email: emailController.text.trim(),
        );
        log(user.toString());

        // Provider.of<UserProvider>(
        //   context,
        //   listen: false,
        // ).updateCurrentUser(user);

        // Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
        Utilis.showSuccessMessage('Register Success');
        widget.move!(true);
      } catch (error) {
        log('Registration error: ${error.toString()}');

        String errorMessage = 'Registration failed. Please try again.';

        if (error is FirebaseAuthException) {
          switch (error.code) {
            case 'email-already-in-use':
              errorMessage = 'This email is already registered.';
              break;
            case 'invalid-email':
              errorMessage = 'Please enter a valid email address.';
              break;
            case 'operation-not-allowed':
              errorMessage = 'Email/password accounts are not enabled.';
              break;
            case 'weak-password':
              errorMessage = 'Password is too weak.';
              break;
            default:
              errorMessage = error.message ?? 'Registration failed.';
          }
        } else if (error is FirebaseException) {
          errorMessage = error.message ?? 'Firebase error occurred.';
        }

        Utilis.showErrorMessage(errorMessage);
      } finally {
        if (mounted) {
          setState(() {
            isLoading = false;
          });
        }
      }
    }
  }

  // void register() {
  //   if (globalKey.currentState!.validate()) {
  //     if (passwordController.text != confirmPasswordController.text) {
  //       Utilis.showErrorMessage('Passwords do not match');
  //       return;
  //     }
  //     registerUser();
  //   }
  // }
}

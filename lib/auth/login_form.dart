import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:training_app/components/custom_elevetedbutton.dart';
import 'package:training_app/components/custom_textfeild.dart';
import 'package:training_app/provider/user_provider.dart';
import 'package:training_app/screens/home_screen.dart';
import 'package:training_app/services/firebase_service.dart';
import 'package:training_app/utilis.dart';

class LoginForm extends StatefulWidget {
  final VoidCallback? onLoginPressed;
  final VoidCallback? onForgotPasswordPressed;
  final VoidCallback? onCreateAccountPressed;
  final Function(bool)? move;

  const LoginForm({
    super.key,

    this.onLoginPressed,
    this.onForgotPasswordPressed,
    this.onCreateAccountPressed,
    this.move,
  });

  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  GlobalKey<FormState> globalKey = GlobalKey<FormState>();
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: globalKey,
      child: Column(
        children: [
          SizedBox(height: MediaQuery.sizeOf(context).height * .1),

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
            iconPathName: 'password',
            hintText: 'Enter your password',
            isPassword: true,
            isEmail: false,
            controller: passwordController,
            validator: (value) {
              if (value!.isEmpty) {
                return 'Enter password';
              } else if (value.length < 9) {
                return 'Enter valid password -more than 9 letters-';
              } else {
                return null;
              }
            },
          ),

          SizedBox(height: 24),

          // Login & Forgot Password Buttons Row
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: CustomElevetedButton(
                  isLoading: isLoading,

                  text: 'Login',
                  onPressed: login,
                ),
              ),
              SizedBox(width: 24),
              Expanded(
                child: CustomElevetedButton(
                  text: 'Forgot password!',
                  onPressed: () {},
                ),
              ),
            ],
          ),

          SizedBox(height: 24),

          Row(
            children: [
              Expanded(
                child: Divider(thickness: 2, indent: 50, color: Colors.grey),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10.0),
                child: Text(
                  'OR',
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),

              Expanded(
                child: Divider(thickness: 2, endIndent: 50, color: Colors.grey),
              ),
            ],
          ),

          SizedBox(height: 24),
          // login by google Account Button
          CustomElevetedButton(
            text: 'Login With Google',
            isGoogleButton: true,
            onPressed: () {},
          ),
          SizedBox(height: 16),

          // Create Account Button
          CustomElevetedButton(
            text: 'Create a new Account',
            onPressed: () {
              widget.move!(false);
              if (globalKey.currentState!.validate()) {
                HapticFeedback.lightImpact();
                Fluttertoast.showToast(msg: 'Login button pressed');
                widget.onLoginPressed?.call();
              }
            },
          ),
        ],
      ),
    );
  }

  Future<void> login() async {
    if (globalKey.currentState!.validate()) {
      if (isLoading) return;

      setState(() {
        isLoading = true;
      });

      try {
        final user = await FirebaseService.logIn(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );

        Provider.of<UserProvider>(context, listen: false).upDateUser(user);

        Utilis.showSuccessMessage('Login Success');

        Navigator.of(context).pushReplacementNamed(HomeScreen.routeName);
      } catch (error) {
        String errorMessage = 'Login failed. Please try again.';

        if (error is FirebaseAuthException) {
          switch (error.code) {
            case 'user-not-found':
              errorMessage = 'No user found with this email.';
              break;
            case 'wrong-password':
              errorMessage = 'Incorrect password. Please try again.';
              break;
            case 'invalid-email':
              errorMessage = 'Please enter a valid email address.';
              break;
            case 'user-disabled':
              errorMessage = 'This account has been disabled.';
              break;
            default:
              errorMessage = error.message ?? 'Login failed.';
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
}

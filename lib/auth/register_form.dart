import 'package:flutter/material.dart';
import 'package:training_app/components/custom_elevetedbutton.dart';
import 'package:training_app/components/custom_textfeild.dart';

class RegisterForm extends StatefulWidget {
  final TextEditingController? usernameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final VoidCallback? onLoginPressed;
  final VoidCallback? onForgotPasswordPressed;
  final VoidCallback? onCreateAccountPressed;
  final Function(bool)? move;

  const RegisterForm({
    super.key,
    this.usernameController,
    this.emailController,
    this.passwordController,
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
            controller: widget.usernameController,
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
            controller: widget.emailController,
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
            onPressed: () {
              if (globalKey.currentState!.validate()) {
                widget.move!(true);
              }
            },
          ),

          SizedBox(height: 24),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:training_app/components/custom_elevetedbutton.dart';
import 'package:training_app/components/custom_textfeild.dart';

class LoginForm extends StatefulWidget {
  final TextEditingController? usernameController;
  final TextEditingController? emailController;
  final TextEditingController? passwordController;
  final VoidCallback? onLoginPressed;
  final VoidCallback? onForgotPasswordPressed;
  final VoidCallback? onCreateAccountPressed;
  final Function(bool)? move;
  final bool isLoading;

  const LoginForm({
    super.key,
    this.usernameController,
    this.emailController,
    this.passwordController,
    this.onLoginPressed,
    this.onForgotPasswordPressed,
    this.onCreateAccountPressed,
    this.isLoading = false,
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
            iconPathName: 'password',
            hintText: 'Enter your password',
            isPassword: true,
            isEmail: false,
            controller: widget.passwordController,
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
                  text: 'Login',
                  onPressed: () {
                    if (globalKey.currentState!.validate()) {
                      HapticFeedback.lightImpact();
                      Fluttertoast.showToast(msg: 'Login button pressed');
                      widget.onLoginPressed?.call();
                    }
                    widget.move!(true);
                  },
                  isLoading: widget.isLoading,
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
}

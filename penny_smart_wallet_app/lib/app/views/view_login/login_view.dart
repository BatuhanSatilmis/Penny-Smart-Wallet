import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:penny_smart_wallet/app/routes/app_router.dart';
import 'package:penny_smart_wallet/app/views/view_forgot_password/forgot_password_view.dart';
import 'package:penny_smart_wallet/app/views/view_signup/signup_view.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage()
class LoginPageView extends StatefulWidget {
  const LoginPageView({Key? key}) : super(key: key);

  @override
  State<LoginPageView> createState() => _LoginPageViewState();
}

class _LoginPageViewState extends State<LoginPageView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _titleText(),
              const SizedBox(height: 40),
              _formFields(context),
              const SizedBox(height: 16),
              _signinButton(context),
              const SizedBox(height: 40),
              _signupButton(context),
            ],
          ),
        ),
      ),
    );
  }
}

Widget _titleText() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
    child: RichText(
      text: TextSpan(
        text: 'LOGIN',
        style: const TextStyle(
            color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
      ),
    ),
  );
}

Widget _formFields(context) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      const SizedBox(height: 8),
      TextFormField(
        showCursor: false,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: 'Enter your Email',
          hintStyle: TextStyle(color: Colors.grey.shade600),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade800,
              width: 2.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.deepPurple.shade900, width: 4.0),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.grey[900],
          filled: true,
          contentPadding: const EdgeInsets.all(19),
        ),
        style: TextStyle(color: Colors.grey[50], fontSize: 17),
      ),
      const SizedBox(height: 30),
      TextFormField(
        showCursor: false,
        obscureText: true,
        textCapitalization: TextCapitalization.sentences,
        decoration: InputDecoration(
          hintText: 'Enter your password',
          hintStyle: TextStyle(color: Colors.grey.shade600),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(
              style: BorderStyle.solid,
              color: Colors.grey.shade800,
              width: 2.5,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide:
                BorderSide(color: Colors.deepPurple.shade900, width: 4.0),
            borderRadius: BorderRadius.circular(12),
          ),
          fillColor: Colors.grey[900],
          filled: true,
          contentPadding: const EdgeInsets.all(19),
        ),
        style: TextStyle(color: Colors.grey[50], fontSize: 17),
      ),
      Container(
        padding: const EdgeInsets.symmetric(vertical: 10),
        alignment: Alignment.centerRight,
        child: InkWell(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => const ForgotPasswordView()),
            );
          },
          child: Text(
            'Forgot Password',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.deepPurple,
            ),
          ),
        ),
      ),
    ],
  );
}

Widget _signinButton(BuildContext context) {
  return Row(children: [
    Expanded(
      child: ZoomIn(
        duration: Duration(milliseconds: 600),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 5),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              stops: const [0.1, 1.0],
              colors: [
                Colors.deepPurple,
                Colors.deepPurple.shade800,
              ],
            ),
            borderRadius: BorderRadius.circular(12),
          ),
          child: ElevatedButton(
              style: ButtonStyle(
                elevation: MaterialStateProperty.all<double>(0),
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  Colors.transparent,
                ),
              ),
              onPressed: () {
                context.router.replace(BottomViewRoute());
              },
              child: const Text('Sign in',
                  style: TextStyle(color: Colors.white, fontSize: 16))),
        ),
      ),
    ),
  ]);
}

Widget _signupButton(BuildContext context) {
  return InkWell(
    onTap: (() {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const SignUpView()),
      );
    }),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          'Dont have an account?',
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(width: 5),
        const Text(
          'Sign up',
          style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 14,
              fontWeight: FontWeight.bold),
        ),
      ],
    ),
  );
}

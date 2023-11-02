import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

@RoutePage()
class SignUpView extends StatefulWidget {
  const SignUpView({Key? key}) : super(key: key);

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final TextEditingController _nameController = TextEditingController();

  String _email = "";
  String _password = "";
  String _name = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _titleText(),
                  const SizedBox(height: 30),
                  _formFields(),
                  const SizedBox(height: 30),
                  _signupButton(),
                  const SizedBox(height: 30),
                  _loginScreen(context)
                ],
              ),
            ),
            _backButton(context)
          ],
        ),
      ),
    );
  }

  Widget _titleText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: RichText(
        text: TextSpan(
          text: 'SIGN UP',
          style: const TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 40),
        ),
      ),
    );
  }

  Widget _formFields() {
    return Form(
      key: _formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8),
          TextFormField(
            controller: _nameController,
            showCursor: false,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Enter Your Name',
              hintStyle: TextStyle(color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey.shade800,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 3.0),
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: Colors.grey[900],
              filled: true,
              contentPadding: const EdgeInsets.all(19),
            ),
            style: TextStyle(color: Colors.grey[50], fontSize: 17),
            onChanged: (value) {
              setState(() {
                _name = value;
              });
            },
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _emailController,
            keyboardType: TextInputType.emailAddress,
            showCursor: false,
            textCapitalization: TextCapitalization.sentences,
            decoration: InputDecoration(
              hintText: 'Enter Your Email',
              hintStyle: TextStyle(color: Colors.grey.shade600),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide(
                  style: BorderStyle.solid,
                  color: Colors.grey.shade800,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 3.0),
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: Colors.grey[900],
              filled: true,
              contentPadding: const EdgeInsets.all(19),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Your Email";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _email = value;
              });
            },
            style: TextStyle(color: Colors.grey[50], fontSize: 17),
          ),
          const SizedBox(height: 30),
          TextFormField(
            controller: _passController,
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
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(color: Colors.deepPurple, width: 3.0),
                borderRadius: BorderRadius.circular(12),
              ),
              fillColor: Colors.grey[900],
              filled: true,
              contentPadding: const EdgeInsets.all(19),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Please Enter Your Password";
              }
              return null;
            },
            onChanged: (value) {
              setState(() {
                _password = value;
              });
            },
            style: TextStyle(color: Colors.grey[50], fontSize: 17),
          ),
        ],
      ),
    );
  }

  Widget _signupButton() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
                stops: const [0.0, 1.0],
                colors: [Colors.deepPurple, Colors.deepPurple.shade800],
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
                _signupWithEmailAndPassword();
              },
              child: const Text(
                'Sign Up',
                style: TextStyle(color: Colors.white, fontSize: 16),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _loginScreen(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
      },
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Already have an account?',
            style: TextStyle(
              fontSize: 15,
              color: Colors.grey.shade500,
            ),
          ),
          const SizedBox(width: 5),
          const Text(
            'Login',
            style: TextStyle(
                color: Colors.deepPurple,
                fontSize: 14,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget _backButton(BuildContext context) {
    return Positioned(
      top: 10,
      left: 0,
      child: InkWell(
        onTap: () {
          Navigator.pop(context);
        },
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Row(
            children: <Widget>[
              Container(
                padding: const EdgeInsets.only(left: 0, top: 10, bottom: 10),
                child:
                    Icon(Icons.keyboard_arrow_left, color: Colors.grey.shade50),
              ),
              Text('Back',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey.shade50))
            ],
          ),
        ),
      ),
    );
  }

  void _signupWithEmailAndPassword() async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: _email,
        password: _password,
      );

      if (userCredential.user != null) {
        await saveUserNameToFirestore(_nameController.text);
      }
    } catch (e) {
      print('Kayıt hatası: $e');
    }
  }

  Future<void> saveUserNameToFirestore(String userName) async {
    FirebaseFirestore.instance
        .collection('Users')
        .doc(_auth.currentUser!.uid)
        .set({
      'Name': userName,
    });
  }
}

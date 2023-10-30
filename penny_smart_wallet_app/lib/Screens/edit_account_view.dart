import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditAccountView extends StatefulWidget {
  const EditAccountView({Key? key}) : super(key: key);

  @override
  State<EditAccountView> createState() => _EditAccountViewState();
}

class _EditAccountViewState extends State<EditAccountView> {
  File? _selectedImage; // Variable to store the selected image

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
                  _changeAccountButton(),
                ],
              ),
            ),
            _backButton(context),
          ],
        ),
      ),
    );
  }

  Widget _titleText() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 0),
      child: Column(
        children: [
          Row(
            children: [
              RichText(
                text: TextSpan(
                  text: 'Edit Account',
                  style: const TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ),
              Spacer(),
              ClipOval(
                child: InkWell(
                  onTap: () async {
                    final pickedFile = await ImagePicker()
                        .pickImage(source: ImageSource.gallery);

                    if (pickedFile != null) {
                      setState(() {
                        _selectedImage = File(pickedFile.path);
                      });
                    }
                  },
                  child:
                      Image.asset("images/avatar.png", width: 60, height: 60),
                ),
              ),
            ],
          ),

          // Display the selected image
          if (_selectedImage != null)
            ClipOval(
              child: Image.file(
                _selectedImage!,
                width: 60,
                height: 60,
              ),
            ),
        ],
      ),
    );
  }

  Widget _formFields() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 8),
        TextFormField(
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
        ),
        const SizedBox(height: 30),
        TextFormField(
          showCursor: false,
          obscureText: true,
          textCapitalization: TextCapitalization.sentences,
          decoration: InputDecoration(
            hintText: 'Enter your Surname',
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
        ),
        const SizedBox(height: 30),
        TextFormField(
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
        ),
        const SizedBox(height: 30),
      ],
    );
  }

  Widget _changeAccountButton() {
    return Row(children: [
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
            onPressed: () {},
            child: const Text('Change',
                style: TextStyle(color: Colors.white, fontSize: 16)),
          ),
        ),
      ),
    ]);
  }

  Widget _backButton(BuildContext context) {
    return Positioned(
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
              Text(
                'Back',
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade50),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

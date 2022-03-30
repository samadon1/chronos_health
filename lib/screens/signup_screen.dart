import 'dart:typed_data';

import 'package:chronos_health/resources/auth_methods.dart';
import 'package:chronos_health/screens/dashboard_screen.dart';
import 'package:chronos_health/screens/doctor_screen/doctor_dashboard.dart';
import 'package:chronos_health/screens/login_screen.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:chronos_health/utils/utils.dart';
import 'package:chronos_health/widgets/text_field_input.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';

import 'home_screen.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({Key? key}) : super(key: key);

  @override
  _SignupScreenState createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _birthdateController = TextEditingController();
  final TextEditingController _hospitalController = TextEditingController();
  final TextEditingController _numberController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
// Dispose the controllers
  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _birthdateController.dispose();
    _hospitalController.dispose();
    _numberController.dispose();
    _emailController.dispose();
    _bioController.dispose();
    _passwordController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    if (mounted) {
      setState(() {
        _image = im;
      });
    }
  }

  void signupUser() async {
    _image ??= (await rootBundle.load('assets/images/profile.png'))
        .buffer
        .asUint8List();
    if (mounted) {
      setState(() {
        _isLoading = true;
      });
    }
    String res = await AuthMethods().signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        number: _numberController.text,
        insurance: _hospitalController.text,
        birthdate: _birthdateController.text,
        name: _nameController.text,
        file: _image!);
    if (res != "success") {
      showSnackBar(context, res);
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => const DoctorDashboard()));
    }
    setState(() {
      if (mounted) {
        _isLoading = false;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        //     child: ConstrainedBox(
        // constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: 32,
              ),
              // Our logo here
              Stack(
                children: [
                  _image != null
                      ? CircleAvatar(
                          radius: 64,
                          backgroundColor: Colors.white,
                          backgroundImage: MemoryImage(_image!))
                      : const CircleAvatar(
                          radius: 64,
                          backgroundColor: secondaryColor,
                          backgroundImage:
                              AssetImage("assets/images/profile.png"),
                        ),
                  Positioned(
                      top: 90,
                      left: 80,
                      child: IconButton(
                          onPressed: () {
                            selectImage();
                          },
                          icon: const Icon(
                            Icons.add_a_photo,
                            color: secondaryColor,
                          )))
                ],
              ),
              const SizedBox(
                height: 64,
              ),
              //Name TextField
              TextFieldInput(
                  hintText: " ",
                  labelText: "Full name",
                  textEditingController: _nameController,
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              //Name TextField
              TextFieldInput(
                  hintText: "30/12/2001",
                  labelText: "Date of birth",
                  textEditingController: _birthdateController,
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),

              //Name TextField
              TextFieldInput(
                  hintText: "",
                  labelText: "Your Hospital's name ",
                  textEditingController: _hospitalController,
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),
              TextFieldInput(
                  hintText: "",
                  labelText: "Bio",
                  textEditingController: _bioController,
                  textInputType: TextInputType.text),
              const SizedBox(
                height: 24,
              ),

              //Email TextField
              TextFieldInput(
                  hintText: "example@gmail.com",
                  labelText: "Email",
                  textEditingController: _emailController,
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 24,
              ),

              TextFieldInput(
                  hintText: "",
                  labelText: "Phone number",
                  textEditingController: _numberController,
                  textInputType: TextInputType.number),
              const SizedBox(
                height: 24,
              ),

              //Password TextField here
              TextFieldInput(
                  isPass: true,
                  labelText: "Password",
                  hintText: "6 characters",
                  textEditingController: _passwordController,
                  textInputType: TextInputType.emailAddress),
              const SizedBox(
                height: 24,
              ),

              //Log in Button TextField here
              InkWell(
                onTap: signupUser,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  child: _isLoading
                      ? const CircularProgressIndicator(
                          color: Colors.white,
                        )
                      : const Text(
                          "Sign Up",
                          style: TextStyle(color: Colors.white),
                        ),
                  decoration: const ShapeDecoration(
                      color: primaryColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(4)))),
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: const Text("Already have an account?"),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  Container(
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const LoginScreen()),
                        );
                      },
                      child: const Text(
                        " Log In",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, color: primaryColor),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 8),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              )
            ],
          ),
        ),
      )),
    );
  }
}

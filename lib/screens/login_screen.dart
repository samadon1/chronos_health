import 'package:chronos_health/resources/auth_methods.dart';
import 'package:chronos_health/screens/dashboard_screen.dart';
import 'package:chronos_health/screens/doctor_screen/doctor_dashboard.dart';
import 'package:chronos_health/screens/home_screen.dart';
import 'package:chronos_health/screens/signup_screen.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:chronos_health/utils/utils.dart';
import 'package:chronos_health/widgets/text_field_input.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _emailController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    bool _isLoading = false;
// Dispose the controllers
    @override
    void dispose() {
      super.dispose();
      _emailController.dispose();
      _passwordController.dispose();
    }

    void loginUser() async {
      setState(() {
        _isLoading = true;
      });
      String res = await AuthMethods().loginUser(
          email: _emailController.text, password: _passwordController.text);
      if (res == "success") {
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const DoctorDashboard()));
      } else {
        showSnackBar(context, res);
      }
      setState(() {
        _isLoading = false;
      });
    }

    return Scaffold(
      body: SafeArea(
          child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Flexible(
              child: Container(),
              flex: 2,
            ),
            // Our logo here
            Image.asset(
              "assets/images/logo.png",
            ),
            const SizedBox(
              height: 64,
            ),

            //Email TextField here
            TextFieldInput(
                labelText: 'Email',
                hintText: "",
                textEditingController: _emailController,
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),

            //Password TextField here
            TextFieldInput(
                labelText: 'Password',
                isPass: true,
                hintText: "",
                textEditingController: _passwordController,
                textInputType: TextInputType.emailAddress),
            const SizedBox(
              height: 24,
            ),

            //Log in Button TextField here
            InkWell(
              onTap: loginUser,
              child: Container(
                width: double.infinity,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(vertical: 12),
                child: _isLoading
                    ? const CircularProgressIndicator(
                        color: Colors.white,
                      )
                    : const Text(
                        "Log In",
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
            Flexible(
              child: Container(),
              flex: 2,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  child: const Text("Don't have an account?"),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                Container(
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignupScreen()),
                      );
                    },
                    child: const Text(
                      " Sign Up",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: primaryColor),
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 8),
                ),
                const SizedBox(
                  height: 62,
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}

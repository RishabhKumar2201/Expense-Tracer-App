import 'package:tracker_application/screens/dashboard.dart';
import 'package:tracker_application/screens/sign_up.dart';
import 'package:tracker_application/services/auth_service.dart';
import 'package:tracker_application/utils/appvalidator.dart';
import 'package:flutter/material.dart';

class LoginView extends StatefulWidget {
  LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  var isLoader = false;
  var authService = AuthService();

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });
      var data = {
        "email": _emailController.text,
        "password": _passwordController.text,
      };

      await authService.login(data, context);

      setState(() {
        isLoader = false;
      });
      //_showDialog(context);
    }
  }

  var appValidator = AppValidator();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF252634),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 80,
              ),
              SizedBox(
                width: 250,
                child: Text(
                  "Login Page",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 28,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _emailController,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                  _buildInputDecoration("Email Id", Icons.email_outlined),
                  validator: appValidator.validateEmail),
              SizedBox(
                height: 16,
              ),
              TextFormField(
                controller: _passwordController,
                  style: TextStyle(color: Colors.white),
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  decoration:
                  _buildInputDecoration("Enter Password", Icons.lock),
                  validator: appValidator.validatePassword),
              SizedBox(
                height: 40,
              ),
              SizedBox(
                height: 50,
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.amber,
                    textStyle: TextStyle(fontSize: 20),
                  ),
                  onPressed: () /*=> _submitForm(context)*/{
                    isLoader ? print("Loading") : _submitForm(context);
                  },
                  child: isLoader
                      ? Center(
                      child: Center(child: CircularProgressIndicator()))
                      : Text(
                    "Login",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => SignUpView()));
                },
                child: Text(
                  "Create a New Account !",
                  style: TextStyle(
                      color: Colors.amber,
                      fontSize: 20,
                      fontWeight: FontWeight.bold),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  InputDecoration _buildInputDecoration(String label, IconData suffixIcon) {
    return InputDecoration(
        fillColor: Color(0xAA494A59),
        filled: true,
        labelStyle: TextStyle(color: Color(0xFF949494)),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Color(0x35949494),
          ),
        ),
        focusedBorder:
        OutlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        labelText: label,
        suffixIcon: Icon(
          suffixIcon,
          color: Color(0xFF949494),
        ),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)));
  }
}

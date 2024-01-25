import 'package:tracker_application/screens/dashboard.dart';
import 'package:tracker_application/screens/login_screen.dart';
import 'package:tracker_application/services/auth_service.dart';
import 'package:tracker_application/utils/appvalidator.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final _userNameController = TextEditingController();

  final _emailController = TextEditingController();

  final _phoneController = TextEditingController();

  final _passwordController = TextEditingController();

  // Future<void> _showDialog(BuildContext context) {
  //   return showDialog<void>(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return AlertDialog(
  //           title: Text('Hello!'),
  //           content: Text('Form submitted successfully'),
  //           actions: <Widget>[
  //             TextButton(
  //               onPressed: () {
  //                 // Close the dialog box when this button is pressed
  //                 Navigator.of(context).pop();
  //               },
  //               child: Text('OK'),
  //             ),
  //           ],
  //         );
  //       });
  // }

  var authService = AuthService();
  var isLoader = false;

  Future<void> _submitForm(BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        isLoader = true;
      });

      var data = {
        "username": _userNameController.text,
        "email": _emailController.text,
        "password": _passwordController.text,
        "phone": _phoneController.text,
        "remainingAmount": 0,
        "totalCredit": 0,
        "totalDebit": 0
      };

      await authService.createUser(data, context);

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
      body: SingleChildScrollView(
        child: Padding(
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
                    "Create New Account",
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
                    controller: _userNameController,
                    style: TextStyle(color: Colors.white),
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration: _buildInputDecoration(
                        "Username", Icons.person_2_outlined),
                    validator: appValidator.validateUserName),
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
                    controller: _phoneController,
                    style: TextStyle(color: Colors.white),
                    keyboardType: TextInputType.phone,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    decoration:
                        _buildInputDecoration("Phone number: +91", Icons.call),
                    validator: appValidator.validatePhoneNumber),
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
                            "Create",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, color: Colors.white),
                          ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Text(
                    "Already Have an Account ? ",
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.white.withOpacity(0.8),
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.push(context,
                          MaterialPageRoute(builder: (context) => LoginView()));
                    },
                    child: Text(
                      "Login",
                      style: TextStyle(
                          color: Colors.amber,
                          fontSize: 20,
                          fontWeight: FontWeight.bold),
                    ),
                  )
                ])
              ],
            ),
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

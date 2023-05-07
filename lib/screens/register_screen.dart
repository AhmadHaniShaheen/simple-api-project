import 'package:api_secand_project/api/controllers/student_auth_api_controller.dart';
import 'package:api_secand_project/models/api_response.dart';
import 'package:api_secand_project/models/strudent.dart';
import 'package:flutter/material.dart';
import 'dart:developer' as devtool show log;

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late TextEditingController _fullNameEditingController;
  late TextEditingController _emailEditingController;
  late TextEditingController _passwordEditingController;

  String _gender = "M";

  @override
  void initState() {
    super.initState();
    _fullNameEditingController = TextEditingController();
    _emailEditingController = TextEditingController();
    _passwordEditingController = TextEditingController();
  }

  @override
  void dispose() {
    _fullNameEditingController.dispose();
    _emailEditingController.dispose();
    _passwordEditingController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 33.0, vertical: 33),
        child: ListView(
          children: [
            const Text(
              'Create Account',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: _fullNameEditingController,
              keyboardType: TextInputType.name,
              decoration: const InputDecoration(
                hintText: 'Full Name',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _emailEditingController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                hintText: 'Email',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: _passwordEditingController,
              keyboardType: TextInputType.text,
              obscureText: true,
              obscuringCharacter: '*',
              decoration: const InputDecoration(
                hintText: 'Password',
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            const SizedBox(
              height: 16,
            ),
            ElevatedButton(
              onPressed: () {
                devtool.log(_gender);
                devtool.log(_emailEditingController.text);
                devtool.log(_passwordEditingController.text);
                preformRegister();
              },
              style: ElevatedButton.styleFrom(
                  minimumSize: const Size(double.infinity, 50)),
              child: const Text('REGISTER'),
            ),
          ],
        ),
      ),
    );
  }

  void preformRegister() {
    if (checkData()) {
      _register();
    }
  }

  void showSnackBar({required String message, bool error = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: error ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  bool checkData() {
    if (_fullNameEditingController.text.isNotEmpty &&
        _emailEditingController.text.isNotEmpty &&
        _emailEditingController.text.isNotEmpty) {
      return true;
    }
    showSnackBar(message: 'Enter required Data', error: true);
    return false;
  }

  void _register() async {
    ApiResponse apiResponse =
        await StudentAuthApiController().register(student);
    showSnackBar(message: apiResponse.message, error: !apiResponse.status);
    if (apiResponse.status) {
      // ignore: use_build_context_synchronously
      Navigator.pop(context);
    }
  }

  Student get student {
    Student student = Student();
    student.fullName = _fullNameEditingController.text;
    student.email = _emailEditingController.text;
    student.password = _passwordEditingController.text;
    student.gender = _gender;
    return student;
  }
}

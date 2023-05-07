import 'package:api_secand_project/screens/index_image.dart';
import 'package:api_secand_project/screens/launch_screen.dart';
import 'package:api_secand_project/screens/login_screen.dart';
import 'package:api_secand_project/screens/password/forget_password_screen.dart';
import 'package:api_secand_project/screens/register_screen.dart';
import 'package:api_secand_project/screens/upload_image.dart';
import 'package:api_secand_project/screens/users_screen.dart';
import 'package:api_secand_project/storage/sharedPrefController.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SharedPrefController().initPref();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/launch_screen',
      routes: {
        '/launch_screen': (context) => const LaunchScreen(),
        '/login_screen': (context) => const LoginScreen(),
        '/forget_password_screen': (context) => const ForgetPasswordScreen(),
        // '/rest_password_screen':(context)=>RestPasswordScreen(/*email: email*/),
        '/register_screen': (context) => const RegisterScreen(),
        '/users_screen': (context) => const UsersScreen(),
        '/index_image': (context) => const IndexImages(),
        '/upload_image': (context) => const UploadImage(),
      },
    );
  }
}

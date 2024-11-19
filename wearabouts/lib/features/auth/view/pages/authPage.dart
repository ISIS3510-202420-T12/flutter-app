import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:wearabouts/core/Viewframes/HomeFrame.dart';
import 'registerPage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final LocalAuthentication auth = LocalAuthentication();
  String errorMessage = '';

  void _authenticateUser() {
    final email = emailController.text;
    final password = passwordController.text;

    if (email == 'j.villatet@uniandes.edu.co') {
      if (password == 'julian') {
        setState(() {
          errorMessage = '';
        });
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeFrame()),
        );
      } else {
        setState(() {
          errorMessage = 'Wrong password';
        });
      }
    } else {
      setState(() {
        errorMessage = 'User not found';
      });
    }
  }

  Future<void> _authenticateWithBiometrics() async {
    bool authenticated = false;
    try {
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Error during authentication: $e';
      });
    }

    if (authenticated) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const HomeFrame()),
      );
    }
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const RegisterPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.lock, size: 80, color: Colors.black),
                  const SizedBox(height: 20),
                  const Text(
                    "Welcome to\nWearAbouts",
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 40),
                  TextField(
                    controller: emailController,
                    decoration: const InputDecoration(labelText: "Username"),
                  ),
                  const SizedBox(height: 20),
                  TextField(
                    controller: passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(labelText: "Password"),
                  ),
                  if (errorMessage.isNotEmpty) ...[
                    const SizedBox(height: 10),
                    Text(errorMessage,
                        style: const TextStyle(color: Colors.red)),
                  ],
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: _authenticateUser,
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          const Color(0xFFA5DBA7), // Color más oscuro
                      fixedSize: const Size(200, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Log in",
                      style: TextStyle(fontSize: 24, color: Colors.black),
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    "or",
                    style: TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                  const SizedBox(height: 10),
                  ElevatedButton(
                    onPressed: _navigateToRegister,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      side: const BorderSide(color: Colors.black54),
                      fixedSize: const Size(200, 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: const Text(
                      "Register",
                      style: TextStyle(fontSize: 24, color: Colors.black54),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              IconButton(
                icon: const Icon(Icons.fingerprint,
                    size: 60, color: Colors.blueGrey),
                onPressed: _authenticateWithBiometrics,
              ),
              const Text(
                "Sign in with your fingerprint",
                style: TextStyle(fontSize: 16, color: Colors.black54),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ],
      ),
    );
  }
}

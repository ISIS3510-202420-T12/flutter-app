import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart'; // Import local_auth
import 'package:wearabouts/core/Viewframes/HomeFrame.dart';
import 'package:wearabouts/core/theme/app_pallete.dart';
import 'package:wearabouts/features/home/view/pages/homePage.dart';
import 'package:wearabouts/features/auth/view/widgets/discoverNowButton.dart';

class FirstTimePage extends StatefulWidget {
  const FirstTimePage({super.key});

  @override
  State<FirstTimePage> createState() => _FirstTimePageState();
}

class _FirstTimePageState extends State<FirstTimePage> {
  final LocalAuthentication auth = LocalAuthentication();

  Future<void> _authenticate() async {
    bool authenticated = false;
    try {
      print('Attempting to authenticate...'); // Debug print
      authenticated = await auth.authenticate(
        localizedReason: 'Please authenticate to continue',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );
      print('Authenticated: $authenticated'); // Debug print
      if (authenticated) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const HomeFrame()),
        );
      }
    } catch (e) {
      // Handle error here
      print('Error during authentication: $e'); // Debug print
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const SizedBox(
            width: double.maxFinite,
            height: double.maxFinite,
            child: DecoratedBox(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('Assets/homebackground.jpeg'),
                  fit: BoxFit.cover,
                ),
                gradient: LinearGradient(
                  colors: [
                    Colors.transparent,
                    Colors.black,
                  ],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Colors.transparent,
                  Colors.black.withOpacity(0.7),
                ],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    "Discover your image",
                    style: TextStyle(
                      fontSize: 40,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 40),
                  DiscoverNowButton(
                    onTap: _authenticate, // Call _authenticate on tap
                  ),
                  const SizedBox(
                    height: 100,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DiscoverNowButton extends StatelessWidget {
  final VoidCallback onTap;

  const DiscoverNowButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(colors: [Pallete.color3, Pallete.color2]),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ElevatedButton(
        onPressed: onTap,
        style: ElevatedButton.styleFrom(
          fixedSize: const Size(350, 70),
          backgroundColor: Pallete.transparentColor,
          shadowColor: Pallete.transparentColor,
        ),
        child: const Text(
          "Discover now",
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}

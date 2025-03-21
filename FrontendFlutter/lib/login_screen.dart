import 'package:flutter/material.dart';
import 'report_type_screen.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'E-aduan Cianjur Kab',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              const Text(
                'SIAP MELAYANI SEPENUH HATI',
                style: TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 32),
              CircleAvatar(
                radius: 50,
                backgroundColor: Colors.grey,
                child: Image.asset(
                  'assets/images/logo-cianjur.png.png',
                  width: 100,
                  height: 100,
                ),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const ReportTypeScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor:
                      Colors.lightBlue, // Warna background biru muda
                  foregroundColor: Colors.white, // Warna tulisan putih
                  // side: BorderSide(color: Colors.white), // Border putih
                ),
                child: const Text('MASUK'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

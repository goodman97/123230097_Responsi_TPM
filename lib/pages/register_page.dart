import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  /// Menyimpan akun baru ke SharedPreferences.
  ///
  /// Setelah pendaftaran sukses, tampilkan snack bar dan kembali ke halaman login.
  Future<void> register() async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString('username', usernameController.text);
    await prefs.setString('password', passwordController.text);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Register berhasil')),
    );

    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    // Build tampilan halaman register dengan input username dan password.
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            TextField(
              controller: usernameController,
              decoration: const InputDecoration(
                labelText: 'Username',
              ),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: passwordController,
              obscureText: true,
              decoration: const InputDecoration(
                labelText: 'Password buat responsi ambil 097',
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: register,
              child: const Text('Register'),
            )
          ],
        ),
      ),
    );
  }
}
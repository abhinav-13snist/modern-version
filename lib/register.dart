import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegisterScreen extends StatefulWidget {
  final VoidCallback onLogin;  // Changed from Function(String)
  const RegisterScreen({Key? key, required this.onLogin}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String? _errorText;
  bool _isLoading = false;

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;
    if (_passwordController.text != _confirmPasswordController.text) {
      setState(() => _errorText = 'Passwords do not match');
      return;
    }

    setState(() {
      _errorText = null;
      _isLoading = true;
    });

    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );
      widget.onLogin();  // Removed the email parameter
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      setState(() => _errorText = e.message);
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SizedBox.expand(
            child: Image.asset(
                'images/assets/Screenshot 2025-04-20 123239.png',
                fit: BoxFit.cover),
          ),
          Container(color: Colors.black.withAlpha((255 * 0.3).toInt())),
          Center(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(32),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.black.withAlpha((255 * 0.2).toInt()),
                          blurRadius: 30,
                          offset: const Offset(0, 8)),
                    ],
                    border: Border.all(
                        color: Colors.white.withAlpha((255 * 0.3).toInt()),
                        width: 1.5)),
                padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 42),
                child: Form(
                  key: _formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                          'Register',
                          style: TextStyle(
                              fontSize: 36,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                              letterSpacing: 1.5)),
                      const SizedBox(height: 36),
                      TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(
                              labelText: 'Email',
                              errorText: _errorText,
                              labelStyle: const TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(12))),
                          keyboardType: TextInputType.emailAddress,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter email' : null),
                      const SizedBox(height: 16),
                      TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(
                              labelText: 'Password',
                              labelStyle: const TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(12))),
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Please enter password' : null),
                      const SizedBox(height: 16),
                      TextFormField(
                          controller: _confirmPasswordController,
                          decoration: InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: const TextStyle(color: Colors.white70),
                              enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white54),
                                  borderRadius: BorderRadius.circular(12)),
                              focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.white),
                                  borderRadius: BorderRadius.circular(12)),
                              errorBorder: OutlineInputBorder(
                                  borderSide: BorderSide(color: Colors.redAccent),
                                  borderRadius: BorderRadius.circular(12))),
                          obscureText: true,
                          style: const TextStyle(color: Colors.white),
                          validator: (value) =>
                          value == null || value.isEmpty ? 'Please confirm password' : null),
                      const SizedBox(height: 28),
                      SizedBox(
                        width: double.infinity,
                        height: 52,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: const Color(0xFF2a5298),
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(18)),
                                elevation: 9,
                                shadowColor: Colors.black26),
                            onPressed: _isLoading ? null : _register,
                            child: _isLoading
                                ? const CircularProgressIndicator(color: Colors.white)
                                : const Text(
                                'Register',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white))),
                      ),
                      TextButton(
                        onPressed: () => Navigator.pop(context),
                        child: const Text(
                            'Back to Login',
                            style: TextStyle(color: Colors.white70)),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
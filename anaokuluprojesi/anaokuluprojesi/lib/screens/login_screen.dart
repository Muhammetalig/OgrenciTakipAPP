import 'package:flutter/material.dart';
import '../utils/app_colors.dart'; // Import AppColors

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _login() {
    if (_formKey.currentState?.validate() ?? false) {
      final email = _emailController.text.toLowerCase();
      bool isTeacher = email.contains('teacher'); // Simple role determination

      // TODO: Implement actual authentication logic here
      print('Email: ${_emailController.text}');
      print('Password: ${_passwordController.text}');
      print('Role: ${isTeacher ? 'Teacher' : 'Parent'}');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text(
                'Giriş başarılı! ${isTeacher ? 'Öğretmen' : 'Veli'} paneline yönlendiriliyor...')),
      );

      // Navigate based on role
      if (isTeacher) {
        Navigator.of(context).pushReplacementNamed('/teacher_home');
      } else {
        Navigator.of(context).pushReplacementNamed('/parent_home');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Potentially use a color from the palette for AppBar background
      appBar: AppBar(
        title: const Text('Giriş Yap'),
        // backgroundColor: AppColors.primaryBlue, // Removed, handled by theme
      ),
      body: Center(
        // Center content vertically and horizontally
        child: SingleChildScrollView(
          // Allows scrolling if content overflows
          padding: const EdgeInsets.all(24.0),
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisAlignment:
                  MainAxisAlignment.center, // Center column content
              crossAxisAlignment:
                  CrossAxisAlignment.stretch, // Stretch widgets horizontally
              children: <Widget>[
                // Placeholder for App Logo/Name
                const Text(
                  '\ud83d\udc6b', // The emoji provided by the user
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: 80.0,
                      color: AppColors.primaryBlue), // Use theme color
                ),
                const SizedBox(height: 48.0),

                // Email/Username Field
                TextFormField(
                  controller: _emailController,
                  decoration: const InputDecoration(
                    labelText: 'E-posta veya Kullanıcı Adı',
                    prefixIcon: Icon(Icons.person_outline),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen e-posta veya kullanıcı adınızı girin';
                    }
                    // Basic email validation (optional)
                    // if (!value.contains('@')) {
                    //   return 'Geçerli bir e-posta adresi girin';
                    // }
                    return null;
                  },
                ),
                const SizedBox(height: 16.0),

                // Password Field
                TextFormField(
                  controller: _passwordController,
                  decoration: const InputDecoration(
                    labelText: 'Şifre',
                    prefixIcon: Icon(Icons.lock_outline),
                  ),
                  obscureText: true, // Hide password
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Lütfen şifrenizi girin';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 8.0), // Space before forgot password

                // Forgot Password Link (Optional)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {
                      // TODO: Implement forgot password logic
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                            content: Text(
                                'Şifremi Unuttum tıklandı (henüz aktif değil).')),
                      );
                    },
                    child: const Text('Şifremi Unuttum?'),
                  ),
                ),
                const SizedBox(height: 24.0), // Space before login button

                // Login Button
                ElevatedButton(
                  onPressed: _login,
                  child: const Text('GİRİŞ YAP'),
                ),
                // Optional: Add "Sign Up" link/button if needed
                // const SizedBox(height: 16.0),
                // TextButton(
                //   onPressed: () { /* Navigate to sign up screen */ },
                //   child: Text('Hesabınız yok mu? Kayıt Olun'),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

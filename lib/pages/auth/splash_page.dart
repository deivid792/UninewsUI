import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../core/app_colors.dart';
import '../../services/auth_service.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  final authService = AuthService();

  @override
  void initState() {
    super.initState();
    _checkAuthStatus();
  }

  Future<void> _checkAuthStatus() async {
    // Pequeno delay para melhor UX da tela splash
    await Future.delayed(const Duration(seconds: 2));

    if (mounted) {
      if (authService.isAuthenticated) {
        // Usuário autenticado, vai para Home
        Navigator.pushReplacementNamed(context, '/home');
      } else {
        // Usuário não autenticado, vai para Login
        Navigator.pushReplacementNamed(context, '/login');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.network(
              'https://via.placeholder.com/150x50?text=UniNews',
              height: 80,
              errorBuilder: (context, error, stackTrace) {
                return Icon(
                  Icons.newspaper,
                  size: 80,
                  color: AppColors.primary,
                );
              },
            ),
            const SizedBox(height: 30),
            Text(
              'UniNews',
              style: GoogleFonts.openSans(
                fontSize: 32,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              'Notícias da Universidade',
              style: GoogleFonts.openSans(
                fontSize: 14,
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 40),
            const CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
          ],
        ),
      ),
    );
  }
}

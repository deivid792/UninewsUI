import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app_colors.dart';
import 'pages/home_page.dart';
import 'pages/auth/splash_page.dart';
import 'pages/auth/login_page.dart';
import 'pages/auth/register_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialização do Supabase
  await Supabase.initialize(
    url: 'https://ywiwwkeawgursxbhyoav.supabase.co',
    anonKey: 'sb_publishable_NRwv2zb7DP4E8NrtvKbwsg_8rGV8uOl',
  );
  runApp(const UniNewsApp());
}

class UniNewsApp extends StatelessWidget {
  const UniNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniNews',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        scaffoldBackgroundColor: AppColors.background,
        useMaterial3: true,
      ),
      // Tela inicial: SplashPage faz a verificação de autenticação
      home: const SplashPage(),
      // Rotas nomeadas para navegação
      routes: {
        '/splash': (context) => const SplashPage(),
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/home': (context) => const HomePage(),
      },
    );
  }
}

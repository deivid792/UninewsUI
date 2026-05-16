import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app_colors.dart';
import 'pages/home_page.dart'; // IMPORTANTE: Importamos a HomePage que criamos

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialização do Supabase
  await Supabase.initialize(
    url: 'https://SUA_URL_AQUI.supabase.co',
    anonKey: 'SUA_KEY_ANON_AQUI',
  );

  runApp(const UniNewsApp());
}

class UniNewsApp extends StatelessWidget {
  const UniNewsApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'UniNews',
      debugShowCheckedModeBanner: false, // Remove a tarja de debug do canto da tela
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        scaffoldBackgroundColor: AppColors.background,
      ),
      // ANTES ESTAVA: home: const RegisterPage(),
      // AGORA FICA ASSIM:
      home: const HomePage(), // O app agora inicia no Menu Principal (aberto a todos)
    );
  }
}
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'core/app_colors.dart';
import 'pages/auth/register_page.dart'; // Vamos criar este agora

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inicialização do Supabase (Coloque suas chaves aqui depois)
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
      theme: ThemeData(
        textTheme: GoogleFonts.openSansTextTheme(),
        scaffoldBackgroundColor: AppColors.background,
      ),
      home: const RegisterPage(),
    );
  }
}
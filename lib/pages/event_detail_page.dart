import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/app_colors.dart';
import 'auth/login_page.dart';

class EventDetailPage extends StatelessWidget {
  final Map<String, String> event;

  const EventDetailPage({super.key, required this.event});

  void _verifyAndConfirm(BuildContext context) {
    final session = Supabase.instance.client.auth.currentSession;
    
    if (session == null) {
      // Se não estiver logado, redireciona para a tela de login
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Você precisa estar logado para se inscrever!")),
      );
      Navigator.push(context, MaterialPageRoute(builder: (_) => const LoginPage()));
    } else {
      // Se logado, procede com a lógica de sucesso
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Inscrição confirmada em: ${event['title']}!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes do Evento', style: GoogleFonts.openSans()),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
              decoration: BoxDecoration(
                color: AppColors.secondary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                event['category']!.toUpperCase(),
                style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 11),
              ),
            ),
            const SizedBox(height: 16),
            Text(
              event['title']!,
              style: GoogleFonts.openSans(fontSize: 22, fontWeight: FontWeight.bold, color: AppColors.primary),
            ),
            const Divider(height: 32),
            
            // Informações de Tempo e Espaço
            Row(
              children: [
                const Icon(Icons.calendar_today, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(event['date']!, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.access_time, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(event['time']!, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.location_on_outlined, color: AppColors.primary),
                const SizedBox(width: 12),
                Text(event['location']!, style: const TextStyle(fontSize: 16)),
              ],
            ),
            const Divider(height: 32),
            
            Text("Descrição", style: GoogleFonts.openSans(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(event['description']!, style: const TextStyle(fontSize: 15, height: 1.5)),
            const SizedBox(height: 24),
            
            // Palestrante / Responsável
            Text("Palestrante", style: GoogleFonts.openSans(fontSize: 16, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: CircleAvatar(backgroundColor: AppColors.accent, child: const Icon(Icons.person)),
              title: Text(event['speaker']!, style: const TextStyle(fontWeight: FontWeight.bold)),
              subtitle: Text(event['role']!),
            ),
            const SizedBox(height: 40),
            
            // Botão de Inscrição protegido
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => _verifyAndConfirm(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: const Text("Confirmar Presença", style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
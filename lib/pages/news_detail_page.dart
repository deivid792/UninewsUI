import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';

class NewsDetailPage extends StatelessWidget {
  final Map<String, String> news;

  const NewsDetailPage({super.key, required this.news});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Detalhes da Notícia', style: GoogleFonts.openSans()),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Tag do Departamento Emissor
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.secondary.withOpacity(0.2),
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                news['department']!.toUpperCase(),
                style: GoogleFonts.openSans(
                  color: AppColors.primary,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
            ),
            const SizedBox(height: 16),
            
            // Título Principal
            Text(
              news['title']!,
              style: GoogleFonts.openSans(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: AppColors.primary,
                height: 1.3,
              ),
            ),
            const SizedBox(height: 8),
            
            // Data de Publicação
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 14, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'Publicado em: ${news['date']!}',
                  style: GoogleFonts.openSans(color: Colors.grey, fontSize: 13),
                ),
              ],
            ),
            const Divider(height: 32, thickness: 1),
            
            // Conteúdo da Notícia
            Text(
              news['content']!,
              style: GoogleFonts.openSans(
                fontSize: 15,
                color: Colors.black87,
                height: 1.6,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
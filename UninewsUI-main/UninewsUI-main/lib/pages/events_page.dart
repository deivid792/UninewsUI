import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import 'event_detail_page.dart';

class EventsPage extends StatefulWidget {
  const EventsPage({super.key});

  @override
  State<EventsPage> createState() => _EventsPageState();
}

class _EventsPageState extends State<EventsPage> {
  String selectedFilter = 'Todos';

  // Simulando dados de eventos estruturados com base no padrão visual enviado
  final List<Map<String, String>> allEvents = [
    {
      'title': 'Palestra sobre Inteligência Artificial na Medicina',
      'description': 'In the garden of life, some things are just very sweet. This is one of them.',
      'speaker': 'Andi Antennae',
      'role': 'Transport at Suite Nectar',
      'category': 'Palestra',
      'date': '22 de abril de 2026',
      'time': '14:00 - 16:00',
      'location': 'Auditório Central'
    },
    {
      'title': 'Workshop de Desenvolvimento Mobile com Flutter',
      'description': 'Your expectations will fly sky high. I felt like I was soaring.',
      'speaker': 'Wanda Wingleton',
      'role': 'Lepidopterist at Butterfly',
      'category': 'Workshop',
      'date': '25 de abril de 2026',
      'time': '09:00 - 12:00',
      'location': 'Laboratório 04'
    }
  ];

  @override
  Widget build(BuildContext context) {
    // Filtra a lista com base no chip selecionado
    final filteredEvents = selectedFilter == 'Todos'
        ? allEvents
        : allEvents.where((e) => e['category'] == selectedFilter).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Eventos', style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // FILTROS ESTILO CHIPS (Adaptado do ícone de filtro da sua imagem)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: ['Todos', 'Palestra', 'Workshop'].map((filter) {
                final isSelected = selectedFilter == filter;
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: FilterChip(
                    label: Text(filter),
                    selected: isSelected,
                    selectedColor: AppColors.secondary.withOpacity(0.3),
                    checkmarkColor: AppColors.primary,
                    onSelected: (bool value) {
                      setState(() {
                        selectedFilter = filter;
                      });
                    },
                  ),
                );
              }).toList(),
            ),
          ),
          // LISTAGEM EM GRID RESPONSIVO PARA MOBILE (2 colunas se houver espaço ou lista vertical)
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 1, // Altere para 2 se quiser em duas colunas como no desktop
                mainAxisExtent: 180,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: filteredEvents.length,
              itemBuilder: (context, index) {
                final event = filteredEvents[index];
                return GestureDetector(
                  onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => EventDetailPage(event: event)),
                  ),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: AppColors.accent.withOpacity(0.5)),
                      boxShadow: const [
                        BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              event['title']!,
                              style: GoogleFonts.openSans(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.primary),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 8),
                            Text(
                              event['description']!,
                              style: GoogleFonts.openSans(color: Colors.black54, fontSize: 13),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              radius: 18,
                              backgroundColor: AppColors.secondary.withOpacity(0.2),
                              child: Icon(Icons.person, color: AppColors.primary, size: 18),
                            ),
                            const SizedBox(width: 10),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(event['speaker']!, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                                  Text(event['role']!, style: const TextStyle(color: Colors.grey, fontSize: 11), overflow: TextOverflow.ellipsis),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
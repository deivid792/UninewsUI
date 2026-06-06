import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../core/app_colors.dart';
import 'news_detail_page.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({super.key});

  @override
  State<NewsPage> createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  final _searchController = TextEditingController();
  String _searchQuery = '';

  // Dados fictícios baseados no ano letivo atual (2026)
  final List<Map<String, String>> _allNews = [
    {
      'title': 'Edital de monitoria 2026.1',
      'content': 'Estão abertas as inscrições para o programa de monitoria acadêmica do semestre 2026.1. Os alunos interessados devem preencher o formulário oficial anexado ao portal do aluno e cumprir os pré-requisitos de média global mínima de 7.0 na disciplina pretendida.',
      'date': '15 de Março de 2026',
      'department': 'Coordenação Geral de Graduação'
    },
    {
      'title': 'Resultado da primeira chamada do FIES',
      'content': 'O setor de bolsas e financiamentos divulgou a lista dos pré-selecionados na primeira chamada do FIES. Os candidatos aprovados devem comparecer ao bloco A para validação da documentação física até a próxima sexta-feira.',
      'date': '12 de Março de 2026',
      'department': 'Setor de Bolsas / ProUni / FIES'
    },
    {
      'title': 'Manutenção programada no portal acadêmico',
      'content': 'Aviso importante: O sistema do Portal do Aluno ficará indisponível neste sábado das 22h às 04h para atualização de servidores e melhorias na segurança do banco de dados.',
      'date': '08 de Março de 2026',
      'department': 'Núcleo de Tecnologia da Informação (NTI)'
    },
    {
      'title': 'Abertura de inscrições para o campeonato de e-Sports',
      'content': 'Estão abertas as inscrições para o torneio interuniversitário de e-Sports. Monte sua equipe de até 5 integrantes e inscreva-se para disputar as modalidades dispostas no regulamento oficial.',
      'date': '01 de Março de 2026',
      'department': 'Diretório Central dos Estudantes (DCE)'
    },
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Filtra as notícias com base no texto digitado (Ignora maiúsculas/minúsculas)
    final filteredNews = _allNews.where((news) {
      final titleLower = news['title']!.toLowerCase();
      final searchLower = _searchQuery.toLowerCase();
      return titleLower.contains(searchLower);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text('Notícias', style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // BARRA DE BUSCA (Estilo minimalista combinando com o app)
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
              decoration: InputDecoration(
                hintText: 'Buscar notícia (ex: monitoria)...',
                prefixIcon: const Icon(Icons.search, color: AppColors.primary),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear, color: Colors.grey),
                        onPressed: () {
                          _searchController.clear();
                          setState(() {
                            _searchQuery = '';
                          });
                        },
                      )
                    : null,
                filled: true,
                fillColor: AppColors.accent.withOpacity(0.2),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          // LISTAGEM DE NOTÍCIAS (Apenas com o título)
          Expanded(
            child: filteredNews.isEmpty
                ? Center(
                    child: Text(
                      'Nenhuma notícia encontrada.',
                      style: GoogleFonts.openSans(color: Colors.grey),
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: filteredNews.length,
                    separatorBuilder: (context, index) => const Divider(color: AppColors.accent),
                    itemBuilder: (context, index) {
                      final news = filteredNews[index];
                      return ListTile(
                        contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                        title: Text(
                          news['title']!,
                          style: GoogleFonts.openSans(
                            fontWeight: FontWeight.w600,
                            fontSize: 15,
                            color: Colors.black87,
                          ),
                        ),
                        trailing: const Icon(Icons.arrow_forward_ios, size: 16, color: AppColors.primary),
                        onTap: () {
                          // Direciona para a tela de detalhes da notícia
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NewsDetailPage(news: news),
                            ),
                          );
                        },
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
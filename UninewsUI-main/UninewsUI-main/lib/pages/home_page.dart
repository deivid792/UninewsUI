import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../core/app_colors.dart';
import '../services/auth_service.dart';
import 'events_page.dart';
import 'news_page.dart';
import 'news_detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final authService = AuthService();
  late Stream<AuthState> authStream;

  @override
  void initState() {
    super.initState();
    authStream = authService.authStateChanges;
  }

  // Lista simulada das notícias mais recentes (mostrando as lançadas em 2026)
  final List<Map<String, String>> _recentNews = const [
    {
      'title': 'Edital de monitoria 2026.1',
      'content':
          'Estão abertas as inscrições para o programa de monitoria acadêmica do semestre 2026.1. Os alunos interessados devem preencher o formulário oficial anexado ao portal do aluno e cumprir os pré-requisitos de média global mínima de 7.0 na disciplina pretendida.',
      'date': '15 de Março de 2026',
      'department': 'Coordenação Geral de Graduação',
    },
    {
      'title': 'Resultado da primeira chamada do FIES',
      'content':
          'O setor de bolsas e financiamentos divulgou a lista dos pré-selecionados na primeira chamada do FIES. Os candidatos aprovados devem comparecer ao bloco A para validação da documentação física até a próxima sexta-feira.',
      'date': '12 de Março de 2026',
      'department': 'Setor de Bolsas / ProUni / FIES',
    },
  ];

  Future<void> _logout() async {
    try {
      await authService.signOut();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Desconectado com sucesso'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
        Navigator.pushReplacementNamed(context, '/login');
      }
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Erro ao desconectar: $error'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'UniNews',
          style: GoogleFonts.openSans(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.primary),
      ),
      drawer: Drawer(
        child: Container(
          color: AppColors.primary,
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: AppColors.primary),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.network(
                        'https://via.placeholder.com/150x50?text=UniNews',
                        color: Colors.white,
                        height: 50,
                        errorBuilder: (context, error, stackTrace) {
                          return const Icon(
                            Icons.newspaper,
                            size: 50,
                            color: Colors.white,
                          );
                        },
                      ),
                      const SizedBox(height: 10),
                      if (authService.isAuthenticated)
                        Text(
                          authService.currentUser?.email ?? 'Usuário',
                          style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.ellipsis,
                        ),
                    ],
                  ),
                ),
              ),
              ListTile(
                leading: const Icon(Icons.home_outlined, color: Colors.white),
                title: Text(
                  'Página Inicial',
                  style: GoogleFonts.openSans(color: Colors.white),
                ),
                onTap: () => Navigator.pop(context),
              ),
              ListTile(
                leading: const Icon(
                  Icons.event_note_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Eventos',
                  style: GoogleFonts.openSans(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const EventsPage()),
                  );
                },
              ),
              ListTile(
                leading: const Icon(
                  Icons.newspaper_outlined,
                  color: Colors.white,
                ),
                title: Text(
                  'Notícias',
                  style: GoogleFonts.openSans(color: Colors.white),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NewsPage()),
                  );
                },
              ),
              const Divider(color: Colors.white24, height: 20),
              // Se o usuário NÃO está autenticado, mostra login e cadastro
              if (!authService.isAuthenticated) ...[
                ListTile(
                  leading: const Icon(
                    Icons.login_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Login',
                    style: GoogleFonts.openSans(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/login');
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.person_add_alt_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Cadastro',
                    style: GoogleFonts.openSans(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.pushReplacementNamed(context, '/register');
                  },
                ),
              ] else ...[
                // Se o usuário está autenticado, mostra logout
                ListTile(
                  leading: const Icon(
                    Icons.account_circle_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Perfil',
                    style: GoogleFonts.openSans(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    // TODO: Implementar página de perfil
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Página de perfil em desenvolvimento'),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout_outlined,
                    color: Colors.white,
                  ),
                  title: Text(
                    'Sair',
                    style: GoogleFonts.openSans(color: Colors.white),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    _logout();
                  },
                ),
              ],
            ],
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeroSection(context),
            _buildRecentNewsSection(context), // NOVA SEÇÃO INSERIDA AQUI
            _buildAboutSection(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeroSection(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Bem vindo ao UniNews",
            style: GoogleFonts.openSans(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "Fique por dentro dos eventos e avisos da sua universidade",
          ),
          const SizedBox(height: 15),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EventsPage()),
              );
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text(
              "Ver eventos",
              style: TextStyle(color: Colors.white),
            ),
          ),
          const Center(
            child: Icon(Icons.newspaper, size: 100, color: AppColors.secondary),
          ),
        ],
      ),
    );
  }

  // NOVA SEÇÃO: Exibe apenas os títulos das notícias mais recentes
  Widget _buildRecentNewsSection(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Divider(),
          const SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Últimas Notícias",
                style: GoogleFonts.openSans(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primary,
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const NewsPage()),
                  );
                },
                child: const Text(
                  "Ver todas",
                  style: TextStyle(
                    color: AppColors.secondary,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 5),
          ListView.separated(
            shrinkWrap:
                true, // Permite que a lista fique dentro do SingleChildScrollView
            physics:
                const NeverScrollableScrollPhysics(), // Desativa a rolagem interna da lista
            itemCount: _recentNews.length,
            separatorBuilder: (context, index) =>
                const Divider(color: AppColors.accent),
            itemBuilder: (context, index) {
              final news = _recentNews[index];
              return ListTile(
                contentPadding: EdgeInsets.zero,
                title: Text(
                  news['title']!,
                  style: GoogleFonts.openSans(
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                    color: Colors.black87,
                  ),
                ),
                trailing: const Icon(
                  Icons.arrow_forward_ios,
                  size: 14,
                  color: AppColors.primary,
                ),
                onTap: () {
                  // Redireciona direto para a tela de detalhes daquela notícia
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
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildAboutSection() {
    return Container(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          const Divider(),
          const SizedBox(height: 10),
          const Text(
            "Sobre o UniNews",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          _aboutItem(
            Icons.notifications_active,
            "Fique atualizado",
            "Receba notificações sobre eventos importantes.",
          ),
          _aboutItem(
            Icons.event,
            "Participe de eventos",
            "Descubra palestras e workshops.",
          ),
        ],
      ),
    );
  }

  Widget _aboutItem(IconData icon, String title, String sub) {
    return ListTile(
      leading: Icon(icon, color: AppColors.primary, size: 30),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
      subtitle: Text(sub),
    );
  }
}

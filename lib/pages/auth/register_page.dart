import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// Constantes de Cores solicitadas
const Color colorPrimary = Color(0xFF002D62); // 60%
const Color colorSecondary = Color(0xFFD4AF37); // 20%
const Color colorAccent = Color(0xFFD3D3D3); // 10%
const Color colorBackground = Colors.white;

final themeData = ThemeData(
  scaffoldBackgroundColor: colorBackground,
  textTheme: GoogleFonts.openSansTextTheme(),
  primaryColor: colorPrimary,
  colorScheme: ColorScheme.fromSeed(
    seedColor: colorPrimary,
    secondary: colorSecondary,
  ),
);

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();
  final _courseController = TextEditingController();
  bool _isLoading = false;

  Future<void> _signUp() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);
    try {
      // Cadastro no Supabase Auth
      final response = await Supabase.instance.client.auth.signUp(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
        data: {
          'full_name': _nameController.text.trim(),
          'course': _courseController.text.trim(),
        },
      );

      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Cadastro realizado! Verifique seu e-mail.')),
        );
      }
    } on AuthException catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(error.message), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Cadastro UniNews', style: GoogleFonts.openSans(fontWeight: FontWeight.bold)),
        backgroundColor: colorPrimary,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Icon(Icons.school, size: 80, color: colorSecondary),
              const SizedBox(height: 32),
              
              // Campo Nome
              _buildTextField(
                controller: _nameController,
                label: 'Nome Completo',
                icon: Icons.person_outline,
              ),
              const SizedBox(height: 16),

              // Campo E-mail
              _buildTextField(
                controller: _emailController,
                label: 'E-mail Institucional',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 16),

              // Campo Curso (Contexto UniNews)
              _buildTextField(
                controller: _courseController,
                label: 'Curso/Departamento',
                icon: Icons.book_outlined,
              ),
              const SizedBox(height: 16),

              // Campo Senha
              _buildTextField(
                controller: _passwordController,
                label: 'Senha',
                icon: Icons.lock_outline,
                isPassword: true,
              ),
              const SizedBox(height: 32),

              // Botão de Cadastro
              ElevatedButton(
                onPressed: _isLoading ? null : _signUp,
                style: ElevatedButton.styleFrom(
                  backgroundColor: colorPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
                child: _isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : Text(
                        'CADASTRAR',
                        style: GoogleFonts.openSans(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.2,
                        ),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required IconData icon,
    bool isPassword = false,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(icon, color: colorSecondary),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorAccent),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: colorPrimary, width: 2),
        ),
      ),
      validator: (val) => val == null || val.isEmpty ? 'Campo obrigatório' : null,
    );
  }
}
# Fluxo de Login com Flutter e Supabase

## 📋 Resumo das Implementações

Este documento descreve o fluxo de autenticação completo implementado no projeto UniNews com Flutter e Supabase.

---

## 🏗️ Arquitetura

### 1. **AuthService** (`lib/services/auth_service.dart`)

Serviço centralizado para gerenciar autenticação com Supabase.

**Métodos principais:**

- `signInWithEmail()` - Fazer login com e-mail e senha
- `signUpWithEmail()` - Registrar novo usuário
- `signOut()` - Fazer logout
- `resetPassword()` - Recuperação de senha
- `updateUser()` - Atualizar dados do usuário
- `isAuthenticated` - Verificar se usuário está logado
- `currentUser` - Obter usuário atual
- `authStateChanges` - Stream para monitorar mudanças de autenticação

### 2. **SplashPage** (`lib/pages/auth/splash_page.dart`)

Tela inicial que verifica o status de autenticação e redireciona para:

- **LoginPage** - se não autenticado
- **HomePage** - se autenticado

### 3. **LoginPage** (`lib/pages/auth/login_page.dart`)

Tela de login com:

- ✅ Validação de e-mail e senha
- ✅ Tratamento de erros traduzidos para português
- ✅ Visualização/ocultação de senha
- ✅ Indicador de carregamento
- ✅ Link para registro
- ✅ Link para recuperação de senha (placeholder)

### 4. **RegisterPage** (`lib/pages/auth/register_page.dart`)

Tela de cadastro com:

- ✅ Campos: Nome completo, e-mail, curso, senha e confirmar senha
- ✅ Validação de formulário completa
- ✅ Validação se as senhas conferem
- ✅ Tratamento de erros
- ✅ Visualização/ocultação de senhas

### 5. **HomePage** (`lib/pages/home_page.dart`)

Página principal com:

- ✅ Drawer dinâmico que muda baseado no status de autenticação
- ✅ Mostra e-mail do usuário no header do drawer (quando logado)
- ✅ Botão de logout
- ✅ Opções de login/cadastro (quando não logado)

---

## 🔄 Fluxo de Navegação

```
SplashPage (Verifica autenticação)
    ├─ Não autenticado → LoginPage
    │   ├─ Login bem-sucedido → HomePage (autenticado)
    │   └─ Cadastro → RegisterPage
    │       └─ Registrado → LoginPage
    └─ Autenticado → HomePage
        ├─ Navega para Eventos, Notícias, etc.
        └─ Logout → LoginPage
```

---

## 🚀 Como Usar

### 1. **Configurar Credenciais do Supabase**

No arquivo `lib/main.dart`, substitua as credenciais:

```dart
await Supabase.initialize(
  url: 'https://seu-projeto.supabase.co',
  anonKey: 'sua_chave_anonima_aqui',
);
```

Obtenha estas credenciais em:

- Dashboard Supabase → Settings → API

### 2. **Usar AuthService em Qualquer Widget**

```dart
import '../../services/auth_service.dart';

class MeuWidget extends StatefulWidget {
  @override
  State<MeuWidget> createState() => _MeuWidgetState();
}

class _MeuWidgetState extends State<MeuWidget> {
  final authService = AuthService();

  @override
  Widget build(BuildContext context) {
    if (authService.isAuthenticated) {
      final usuario = authService.currentUser;
      return Text('Olá ${usuario?.email}');
    } else {
      return Text('Não autenticado');
    }
  }
}
```

### 3. **Navegação por Rotas**

O projeto usa rotas nomeadas:

- `/login` - Página de login
- `/register` - Página de cadastro
- `/home` - Página principal
- `/splash` - Tela de splash

```dart
// Navegar para uma rota
Navigator.pushReplacementNamed(context, '/login');

// Ou com Navigator.push
Navigator.push(context, MaterialPageRoute(builder: (_) => LoginPage()));
```

---

## 🎨 Padrão de Design

Todos os componentes seguem:

- ✅ **Cores do AppColors**: Primary (Azul), Secondary (Dourado), Accent (Cinza)
- ✅ **Tipografia**: Google Fonts (Open Sans)
- ✅ **Validação de Formulário**: TextFormField com validators
- ✅ **Mensagens de Erro**: ScaffoldMessenger SnackBar
- ✅ **Carregamento**: CircularProgressIndicator durante requisições

---

## 📝 Validações Implementadas

### Login

- E-mail obrigatório e válido
- Senha obrigatória (mínimo 6 caracteres)
- Mensagens de erro customizadas

### Cadastro

- Nome obrigatório (mínimo 3 caracteres)
- E-mail obrigatório e válido
- Curso obrigatório
- Senha obrigatória (mínimo 6 caracteres)
- Confirmação de senha deve ser igual
- Detecta e-mail já cadastrado

---

## 🔐 Segurança

- ✅ Senhas nunca aparecem em logs
- ✅ Senhas não confirmadas são rejeitadas
- ✅ Tokens de autenticação gerenciados pelo Supabase
- ✅ Validação no lado do cliente e servidor

---

## 🐛 Tratamento de Erros

Os erros do Supabase são traduzidos para português:

```dart
"Invalid login credentials" → "E-mail ou senha incorretos"
"Email not confirmed" → "E-mail não confirmado..."
"User not found" → "Usuário não encontrado"
"already registered" → "Este e-mail já está cadastrado"
```

---

## 📱 Responsivo

Todos os componentes são responsivos usando:

- `SingleChildScrollView` - Para evitar overflow
- `MediaQuery` - Para adaptação de tamanhos
- `Column` e `Row` com `crossAxisAlignment` apropriado
- `SizedBox` para espaçamento consistente

---

## 🔄 Próximas Implementações

Para completar o fluxo, você pode adicionar:

1. **Recuperação de Senha**
   - Enviar link de reset para e-mail
   - Página para redefinir senha

2. **Autenticação Social**
   - Login com Google
   - Login com GitHub
   - Login com Facebook

3. **Two-Factor Authentication (2FA)**
   - Verificação por SMS
   - Autenticador de app

4. **Página de Perfil**
   - Editar dados do usuário
   - Mudar foto de perfil
   - Redefinir senha

5. **Email Verification**
   - Enviar e-mail de confirmação
   - Resend verification e-mail

---

## 📚 Referências

- [Documentação Supabase Flutter](https://supabase.com/docs/reference/flutter/introduction)
- [Documentação Flutter](https://flutter.dev/docs)
- [Google Fonts Package](https://pub.dev/packages/google_fonts)

---

**Versão:** 1.0.0  
**Data:** Maio 2026  
**Autor:** Seu Projeto UniNews

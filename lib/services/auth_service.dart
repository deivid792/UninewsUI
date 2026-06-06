import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  static final AuthService _instance = AuthService._internal();

  factory AuthService() {
    return _instance;
  }

  AuthService._internal();

  final _client = Supabase.instance.client;

  // Getter para o cliente Supabase
  SupabaseClient get client => _client;

  // Getter para o usuário atual
  User? get currentUser => _client.auth.currentUser;

  // Verificar se o usuário está autenticado
  bool get isAuthenticated => currentUser != null;

  // Stream de autenticação para reatividade
  Stream<AuthState> get authStateChanges => _client.auth.onAuthStateChange;

  /// Fazer login com e-mail e senha
  Future<AuthResponse> signInWithEmail({
    required String email,
    required String password,
  }) async {
    return await _client.auth.signInWithPassword(
      email: email.trim(),
      password: password.trim(),
    );
  }

  /// Registrar novo usuário
  Future<AuthResponse> signUpWithEmail({
    required String email,
    required String password,
    Map<String, dynamic>? data,
  }) async {
    return await _client.auth.signUp(
      email: email.trim(),
      password: password.trim(),
      data: data,
    );
  }

  /// Fazer logout
  Future<void> signOut() async {
    await _client.auth.signOut();
  }

  /// Redefinir senha
  Future<void> resetPassword({required String email}) async {
    await _client.auth.resetPasswordForEmail(email.trim());
  }

  /// Atualizar usuário
  Future<UserResponse> updateUser({
    String? email,
    String? password,
    Map<String, dynamic>? data,
  }) async {
    return await _client.auth.updateUser(
      UserAttributes(email: email, password: password, data: data),
    );
  }

  /// Obter os dados do usuário atual
  Map<String, dynamic>? getUserData() {
    return currentUser?.userMetadata;
  }

  /// Verificar se o email foi confirmado
  bool get isEmailConfirmed => currentUser?.emailConfirmedAt != null;

  /// Obter a sessão atual
  Session? get currentSession => _client.auth.currentSession;
}

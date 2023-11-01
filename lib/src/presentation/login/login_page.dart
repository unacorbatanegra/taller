// ignore_for_file: use_build_context_synchronously

import 'package:ff_annotation_route_library/ff_annotation_route_library.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller/src/presentation/widgets/widgets.dart';
import 'package:taller/src/utils/utils.dart';

@FFRoute(name: '/login')
class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;
  final formKey = GlobalKey<FormState>();
  final supa = getIt.get<SupabaseClient>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Iniciar sesión',
                style: TextStyle(fontSize: 24),
              ),
              const SizedBox(
                height: 24,
              ),
              CustomTextField(
                controller: emailController,
                label: 'Correo',
                required: true,
                autofocus: true,
                textCapitalization: TextCapitalization.none,
                autofillHints: const [AutofillHints.email],
                keyboardType: TextInputType.emailAddress,
                textInputAction: TextInputAction.next,
                hint: 'ingrese su correo',
              ),
              CustomTextField(
                controller: passwordController,
                label: 'Contraseña',
                obscureText: obscure,
                required: true,
                autofillHints: const [AutofillHints.password],
                textCapitalization: TextCapitalization.none,
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                hint: 'ingrese su contraseña',
                suffix: IconButton.filled(
                  onPressed: changeObscure,
                  icon: Icon(
                    icon(),
                  ),
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              CustomButton(
                onTap: onLogin,
                label: 'Iniciar sesión',
              ),
              gap16,
              TextButton(
                  onPressed: onRegister, child: const Text('Registrarme'))
            ],
          ),
        ),
      ),
    );
  }

  void changeObscure() => setState(() {
        obscure = !obscure;
      });

  IconData icon() {
    if (obscure) {
      return Icons.visibility_off;
    }
    return Icons.visibility;
  }

  void onLogin() async {
    if (!formKey.currentState!.validate()) {
      return;
    }

    final email = emailController.text.trim();
    final password = passwordController.text.trim();

    if (!mounted) return;
    if (!formKey.currentState!.validate()) return;
    try {
      context.showPreloader();
      final response = await supa.auth.signInWithPassword(
        password: password,
        email: email,
      );
      if (!mounted) return;
      await context.hidePreloader();
      if (response.session == null) return;
      if (!mounted) return;
      Navigator.of(context).pushNamedAndRemoveUntil(
        '/splash',
        (route) => false,
      );
    } on AuthException catch (e) {
      if (!mounted) return;
      await context.hidePreloader();
      if (!mounted) return;
      context.showErrorSnackBar(message: e.message);
    } on Exception catch (e) {
      if (!mounted) return;
      await context.hidePreloader();
      if (!mounted) return;
      context.showErrorSnackBar(message: 'from exception $e');
    }
    return;
  }

  void onRegister() => Navigator.pushNamed(
        context,
        '/signup',
      );
}

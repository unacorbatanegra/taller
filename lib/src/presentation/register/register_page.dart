// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller/src/presentation/widgets/widgets.dart';
import 'package:taller/src/utils/utils.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool obscure = true;
  final formKey = GlobalKey<FormState>();
  final supa = getIt.get<SupabaseClient>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Registrarme'),
      ),
      bottomSheet: SafeArea(
        child: Padding(
          padding: const EdgeInsets.only(
            right: 16,
            left: 16,
            bottom: 32,
          ),
          child: CustomButton(
            onTap: onSignUp,
            label: "Registrarme",
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formKey,
          child: Column(
            // mainAxisAlignment: MainAxisAlignment.center,
            children: [
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
                textInputAction: TextInputAction.done,
                onFieldSubmitted: (value) => onSignUp(),
                hint: 'ingrese su contraseña',
                suffix: IconButton.filled(
                  onPressed: changeObscure,
                  icon: Icon(
                    icon(),
                  ),
                ),
              ),
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

  void onSignUp() async {
    if (!formKey.currentState!.validate()) return;
    try {
      context.showPreloader();
      final r = await supa.auth.signUp(
        email: emailController.text.trim(),
        password: passwordController.text.trim(),
      );
      log.d(r.session);
      log.d(r.user);
    } on Exception catch (e) {
      await context.hidePreloader();
      if (!mounted) return;
      context.showErrorSnackBar(message: e.toString());
      return;
    }
    if (!mounted) return;
    await context.hidePreloader();
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/splash', (route) => false);
  }
}

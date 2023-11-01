import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller/src/presentation/widgets/widgets.dart';
import 'package:taller/src/routes/taller_routes.dart';

import '../../utils/utils.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({super.key});

  @override
  State<MenuPage> createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  final supabase = getIt.get<SupabaseClient>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
      ),
      body: Column(
        children: [
          ListTile(
            onTap: onProfile,
            leading: const Icon(Icons.person),
            title: const Text('Perfil'),
          ),
        ],
      ),
      bottomNavigationBar: ListTile(
        onTap: onSignOut,
        leading: const Icon(Icons.logout),
        title: const Text('Cerrar sesión'),
      ),
    );
  }

  void onSignOut() async {
    try {
      context.showPreloader();
      await supabase.auth.signOut();
      if (!mounted) return;
      await context.hidePreloader();
    } on Exception catch (e) {
      context.showErrorSnackBar(message: e.toString());
      return;
    }
    if (!mounted) return;
    Navigator.of(context).pushNamedAndRemoveUntil('/login', (route) => false);
  }

  void onProfile() => Navigator.of(context).pushNamed(RouteName.profile);
}

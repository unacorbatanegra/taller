import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller/src/presentation/conversations/conversations_page.dart';
import 'package:taller/src/presentation/menu/menu_page.dart';
import 'package:taller/src/utils/utils.dart';

import '../widgets/widgets.dart';

class RootPage extends StatefulWidget {
  const RootPage({super.key});

  @override
  State<RootPage> createState() => _RootPageState();
}

class _RootPageState extends State<RootPage> {
  final supa = getIt.get<SupabaseClient>();

  @override
  void initState() {
    // supa.auth.signOut();
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: currentIndex,
        children: const [
          ConversationsPage(),
          MenuPage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onChangedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Majes.chat_2_line),
            label: 'Conversations',
          ),
          BottomNavigationBarItem(
            label: 'Menu',
            icon: Icon(Icons.menu),
          ),
        ],
      ),
    );
  }

  void onChangedIndex(int value) {
    if (currentIndex == value) return;
    setState(() {
      currentIndex = value;
    });
  }
}

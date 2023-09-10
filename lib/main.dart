// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: false,
      ),
      home: const HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var contador = 0;

  void sumar() => setState(() => contador++);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.home),
        title: const Text("App 2 "),
        systemOverlayStyle: SystemUiOverlayStyle.light,
        actions: [
          CupertinoButton(
            onPressed: sumar,
            child: const Icon(
              Icons.plus_one,
              color: Colors.white,
            ),
          )
        ],
      ),
      body: Container(
        padding: const EdgeInsets.all(16),
        width: MediaQuery.of(context).size.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              width: 700,
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: List.generate(
                    50,
                    (index) => Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: 32,
                      height: 32,
                      color: Colors.red,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 64,
            ),
            MiComponente(
              label: 'El contador es: $contador',
              onTap: sumar,
            ),
          ],
        ),
      ),
    );
  }
}

class MiComponente extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  const MiComponente({
    Key? key,
    required this.label,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: const BoxDecoration(
          color: Color(0xFF1E415F),
          borderRadius: BorderRadius.all(
            Radius.circular(6),
          ),
        ),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 40),
        child: Text(
          label,
          style: const TextStyle(
              fontSize: 18, color: Colors.white, fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

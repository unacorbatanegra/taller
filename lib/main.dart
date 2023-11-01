// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:taller/src/presentation/widgets/widgets.dart';
import 'package:taller/src/routes/taller_routes.dart';
import 'package:taller/src/utils/utils.dart';

import 'src/routes/route_middleware.dart';

void main() async {
  // await dotenv.load();
  final supabase = await Supabase.initialize(
    // url: dotenv.get('SUPABASE_URL'),
    url: const String.fromEnvironment('SUPABASE_URL'),
    anonKey: const String.fromEnvironment('SUPABASE_KEY'),
  );
  WidgetsFlutterBinding.ensureInitialized();

  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarBrightness: Brightness.light,
    ),
  );

  SystemChrome.setPreferredOrientations(
    const [
      DeviceOrientation.portraitDown,
      DeviceOrientation.portraitUp,
    ],
  );

  getIt.registerSingleton(supabase.client);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // onTap: () => WidgetsBinding.instance.focusManager.primaryFocus?.unfocus(),
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: AppTheme.theme,
        initialRoute: RouteName.splash,
        debugShowCheckedModeBanner: false,
        onGenerateRoute: RouteMiddleware.generateRoute,

        // home: const HomePage(),
      ),
    );
  }
}

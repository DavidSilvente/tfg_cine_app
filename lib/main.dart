import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:cine_tfg_app/config/router/app_router.dart';
import 'package:cine_tfg_app/config/theme/app_theme.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:dcdg/dcdg.dart';


Future<void> main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    const ProviderScope(child: MyApp())
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final appRouter = ref.watch( goRouterProvider );

    initializeDateFormatting();

    return MaterialApp.router(
      routerConfig: appRouter,
      debugShowCheckedModeBanner: false,
      theme: AppTheme().themeData,
    );
  }
}
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/config/config.dart';
import 'package:tasks_app/presentation/providers/theme_provider.dart';


void main() async{
  await Environment.initEnvironment();
  runApp(const ProviderScope(child: MainApp()));
}
class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appRouter = ref.watch( goRouterProvider );
    final AppTheme appTheme = ref.watch( themeNotifierProvider );
    
    return 
    MaterialApp.router(
      routerConfig: appRouter,
      theme: appTheme.getTheme(),
      debugShowCheckedModeBanner: false,
    );
  }
}

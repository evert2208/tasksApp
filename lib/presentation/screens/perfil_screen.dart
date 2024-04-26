import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/presentation/providers/theme_provider.dart';


class PerfilScreen extends StatelessWidget {
  static const name = 'perfil-screen';
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {

    

    return Scaffold(
     
        appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: const Text('Seetings'),
          ),
      body: const _PerfilView(),
      
    );
  }
}


class _PerfilView extends ConsumerWidget {
  const _PerfilView();

  @override
  Widget build(BuildContext context, ref) {
    final isDarkmode = ref.watch( themeNotifierProvider ).isDarkmode;
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
        SwitchListTile(
          title: const Text('Theme Mode'),
          subtitle: Text(isDarkmode?'Dark':'Light'),
          value: isDarkmode,
          onChanged: (value){
            ref.read( themeNotifierProvider.notifier )
                .toggleDarkmode();
          },
        ),
      ]
    );
  }
}
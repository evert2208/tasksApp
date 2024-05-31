import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/presentation/providers/auth_provider.dart';
import 'package:tasks_app/presentation/providers/theme_provider.dart';
import 'package:tasks_app/presentation/shared/widgets/widgets.dart';


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
            title: const Text('Ajustes'),
          ),
      body: const _PerfilView(),
      
    );
  }
}


class _PerfilView extends ConsumerWidget {
  const _PerfilView();

  @override
  Widget build(BuildContext context, ref) {
    final textStyle = Theme.of(context).textTheme;
    final authState = ref.watch( authProvider );
    final isDarkmode = ref.watch( themeNotifierProvider ).isDarkmode;
    final nombre = authState.user?.user.nombre;
    final rol = authState.user?.role;
    return ListView(
      physics: const ClampingScrollPhysics(),
      children: [
         const SizedBox( height: 15 ),
         Padding( padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
         child: Text('Hola, $nombre', style: textStyle.titleMedium)
         ),
        // const SizedBox( height: 15 ),
         Padding( padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 16),
         child: Text(rol=='ADMIN_ROLE'? 'Administrador': 'Empleado', 
         style: textStyle.titleSmall)
         ),
          const SizedBox( height: 30 ),
        SwitchListTile(
          title: const Text('Modo'),
          subtitle: Text(isDarkmode?'Dark':'Light'),
          value: isDarkmode,
          onChanged: (value){
            ref.read( themeNotifierProvider.notifier )
                .toggleDarkmode();
          },
        ),
        const SizedBox( height: 30 ),

         Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: CustomFilledButton(
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
            text: 'Cerrar sesión'
          ),
        ),
      ]
    );
  }
}
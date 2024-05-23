import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:tasks_app/presentation/providers/key_storage_provider.dart';


class CustomAppbar extends ConsumerWidget {
  
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
     final keyValueStorageService = ref.watch(keyValueStorageServiceProvider);
    final titleStyle = Theme.of(context).textTheme.titleMedium;
    // final nombre = keyValueStorageService.getStorageNombre();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10 ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              
              const SizedBox( width: 4 ),
              Text('TasksIn', style: titleStyle ),
      
              const Spacer(),
      
              IconButton(onPressed: () {
                context.push('/home/0/perfil');
              }, 
              icon: const Icon(Icons.settings)
              )
            ],
          ),
        ),
      )
    );
  }
}
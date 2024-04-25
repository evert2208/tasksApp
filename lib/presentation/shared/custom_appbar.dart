import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';


class CustomAppbar extends ConsumerWidget {
  const CustomAppbar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final colors = Theme.of(context).colorScheme;
    final titleStyle = Theme.of(context).textTheme.titleMedium;

    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric( horizontal: 10 ),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              
              const SizedBox( width: 4 ),
              Text('Hello, Andres', style: titleStyle ),
      
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
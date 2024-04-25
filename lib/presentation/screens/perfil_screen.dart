import 'package:flutter/material.dart';


class PerfilScreen extends StatelessWidget {
  static const name = 'perfil-screen';
  const PerfilScreen({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
     
        appBar: AppBar(
            leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
            title: Text('Seetings'),
          ),
      body: const _PerfilScreen(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('user'),
        icon: const Icon( Icons.add ),
        onPressed: () {},
      ),
    );
  }
}


class _PerfilScreen extends StatelessWidget {
  const _PerfilScreen();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Perfil'));
  }
}
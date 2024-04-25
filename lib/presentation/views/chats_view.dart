import 'package:flutter/material.dart';


class ChatView extends StatelessWidget {
  const ChatView({super.key});

  @override
  Widget build(BuildContext context) {

    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      
      body: const _ChatView(),
      floatingActionButton: FloatingActionButton.extended(
        label: const Text('Chat'),
        icon: const Icon( Icons.add ),
        onPressed: () {},
      ),
    );
  }
}


class _ChatView extends StatelessWidget {
  const _ChatView();

  @override
  Widget build(BuildContext context) {
    return const Center(child: Text('Chats view'));
  }
}
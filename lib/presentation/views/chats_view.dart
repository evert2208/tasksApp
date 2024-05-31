import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';



class ChatView extends ConsumerWidget {

const ChatView({super.key});

 
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final users = ref.watch( taskProvider() );;
    final List<dynamic> users = [
      {'id': '2', 'name': 'TaskAssist', 'avatarUrl': 'https://example.com/avatar1.png'},
      // {'id': '1', 'name': 'Alice', 'avatarUrl': 'https://example.com/avatar1.png'},
      // {'id': '2', 'name': 'Bob', 'avatarUrl': 'https://example.com/avatar2.png'},
      // {'id': '3', 'name': 'Charlie', 'avatarUrl': 'https://example.com/avatar3.png'},
    ];
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: ListView.builder(
        itemCount: users.length,
        itemBuilder: (context, index) {
          final user = users[index];
          return ListTile(
            leading: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Container(
                  width: 15, 
                  height: 15, 
                  decoration: const BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            title: Text(user['name'], style: const TextStyle(
                fontSize: 20,
              ),),
            onTap: () =>  context.push('/chat/${ user['name'] }'),
          );
        },
      ),
    )
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
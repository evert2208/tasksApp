import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/domain/entities/message.dart';
import 'package:tasks_app/presentation/providers/chat_provider.dart';
import 'package:tasks_app/presentation/shared/widgets/chat/message_field.dart';
import 'package:tasks_app/presentation/shared/widgets/chat/my_message.dart';
import 'package:tasks_app/presentation/shared/widgets/chat/others_message.dart';


class ChatScreen extends ConsumerWidget {
  final String chatId;
  const ChatScreen({super.key, required this.chatId});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    
    return Scaffold(
      appBar: AppBar(
        leading: BackButton(
              onPressed: () {
                Navigator.pop(context);
              },
            ),
        title: Text(chatId),
        actions: [
         IconButton(
          icon: const Icon(Icons.phone), 
          onPressed: () {
            
            },),
          IconButton(
          icon: const Icon(Icons.video_call), 
          onPressed: () {
            
            },),
        ],
        // centerTitle: true,
      ),
    
      body: _ChatView(),
    );
  }
}

class _ChatView extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {

    final chat = ref.watch(chatProvider);

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                controller: chat.chatScrollController,
                itemCount: chat.messageList.length,
                itemBuilder: (context, index) {
               final message = chat.messageList[index];
               return (message.fromWho== FromWho.others)
               ? OtherMessageBubble(message: message)
               : MyMessageBubble(message: message);
              },)),
            
            //field texto
            MessageFildBox(
              onValue: (value)=>chat.sendMessage(value),
            ),
          ],
        ),
      ),
    );
  }
}
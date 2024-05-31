import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:tasks_app/config/config.dart';
import 'package:tasks_app/config/helpers/get_gemini.dart';
import 'package:tasks_app/domain/entities/message.dart';
import 'package:tasks_app/infrastructure/infrastructure.dart';

final chatProvider = ChangeNotifierProvider((ref) => ChatProvider());
late final KeyValueStorageService keyValueStorageService;
class ChatProvider extends ChangeNotifier {

  final chatScrollController = ScrollController();
  final getAnswer = GetAnswer();
  final getAnswerGemini = GetAnswerGemini(keyValueStorageService: keyValueStorageService);
  List<Message> messageList = [
    Message(text: 'Soy Taskin', fromWho: FromWho.others),
    Message(text: 'En que te puedo ayudar?', fromWho: FromWho.others),
  ];

  Future<void> sendMessage(String text) async {
    if(text.isEmpty) return;
    final newMessage = Message(text: text, fromWho: FromWho.me);
    messageList.add(newMessage);
    // if(text.endsWith('?')){
    //   otherReply();
    // }
    otherReply();
    notifyListeners();
    moveScrollToBotton();
  }

  Future<void> otherReply() async{
     final otherMessage = await getAnswerGemini.getAnswerGemini();
     messageList.add(otherMessage);
     notifyListeners();
     moveScrollToBotton();
  }

  Future<void> moveScrollToBotton() async{
    await Future.delayed(const Duration(microseconds: 100));
    chatScrollController.animateTo(
      chatScrollController.position.maxScrollExtent, 
      duration: const Duration(milliseconds: 300), 
      curve: Curves.easeOut
      );
  }
}
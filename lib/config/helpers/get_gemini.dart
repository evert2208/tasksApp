
import 'package:dio/dio.dart';
import 'package:tasks_app/config/config.dart';
import 'package:tasks_app/domain/entities/message.dart';
import 'package:tasks_app/infrastructure/infrastructure.dart';
import 'package:tasks_app/infrastructure/models/gemini_model.dart';



class GetAnswerGemini {
  final KeyValueStorageService keyValueStorageService;

  GetAnswerGemini({required this.keyValueStorageService});

  Future<Message> getAnswerGemini() async {
    final token = keyValueStorageService.getValue('token');
    final dio = Dio(
      BaseOptions(
        baseUrl: Environment.apiUrl,
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );
    final response = await dio.get('/chat/GeminiAi');
    final resp = GeminiModel.fromJsonMap(response.data);
   return resp.toMessageEntity(); 
  }
}
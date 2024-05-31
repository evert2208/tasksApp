
import 'package:dio/dio.dart';
import 'package:tasks_app/domain/entities/message.dart';
import 'package:tasks_app/infrastructure/models/response_model.dart';


class GetAnswer {
  final _dio = Dio();
  Future<Message> getAnswer() async{

    final response = await _dio.get('https://yesno.wtf/api');
    
    final resModel = ResponseModel.fromJsonMap(response.data);
    
    return resModel.toMessageEntity();
    
  }
}
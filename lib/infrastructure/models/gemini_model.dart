import 'package:tasks_app/domain/entities/message.dart';

class GeminiModel {
    final String answer;
  

    GeminiModel({
        required this.answer
       
    });

    factory GeminiModel.fromJsonMap(Map<String, dynamic> json) => GeminiModel(
        answer: json["answer"]
    );

    Map<String, dynamic> toJson() => {
        "answer": answer
    };

    Message toMessageEntity() => Message(
      text: answer,
      fromWho: FromWho.others,
  
    );
}
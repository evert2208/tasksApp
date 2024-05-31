
import 'package:tasks_app/domain/entities/message.dart';

class ResponseModel {
    final String answer;
    final bool forced;
    final String image;

    ResponseModel({
        required this.answer,
        required this.forced,
        required this.image,
    });

    factory ResponseModel.fromJsonMap(Map<String, dynamic> json) => ResponseModel(
        answer: json["answer"],
        forced: json["forced"],
        image: json["image"],
    );

    Map<String, dynamic> toJson() => {
        "answer": answer,
        "forced": forced,
        "image": image,
    };

    Message toMessageEntity() => Message(
      text: answer =='yes'?'Si': 'No',
      fromWho: FromWho.others,
      imageUrl: image
    );
}

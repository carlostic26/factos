import 'package:factos/feature/home/domain/entities/facto_entity.dart';

class FactoModel extends Facto {
  FactoModel(
      {required super.title,
      required super.category,
      required super.description,
      required super.nameFont,
      required super.linkFont,
      required super.linkImg,
      required super.preference,
      required super.language});

  //Para el caso donde esté implementando API
  factory FactoModel.fromJson(Map<String, dynamic> json) {
    return FactoModel(
      title: json['title'] as String,
      category: json['category'] as String,
      description: json['description'] as String,
      nameFont: json['nameFont'] as String,
      linkFont: json['linkFont'] as String,
      linkImg: json['linkImg'] as String,
      preference: json['preference'] as String,
      language: json['language'] as String,
    );
  }
  // Método para convertir el objeto a un Json
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'preference': preference,
      'category': category,
      'language': language,
      'description': description,
      'namefont': nameFont,
      'linkFont': linkFont,
      'linkImg': linkImg
    };
  }
}

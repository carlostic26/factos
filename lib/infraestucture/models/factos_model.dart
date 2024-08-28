import 'package:factos/domain/entities/facto_entity.dart';

class FactoModel extends Facto {
  FactoModel(
      {required super.title,
      required super.category,
      required super.description,
      required super.nameFont,
      required super.linkFont});

  //Para el caso donde esté implementando API
  factory FactoModel.fromJson(json) {
    return FactoModel(
      title: '',
      category: '',
      description: '',
      nameFont: '',
      linkFont: '',
    );
  }

  // Método para convertir el objeto a un Json
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'category': category,
      'description': description,
      'namefont': nameFont,
      'linkFont': linkFont,
    };
  }
}

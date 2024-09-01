import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class Game {
  final int id;
  final String name, description;
  final bool active;

  Game(
      {required this.id,
      required this.name,
      required this.description,
      required this.active});

  factory Game.fromJson(Map<String, dynamic> json) => _$GameFromJson(json);

  /// Connect the generated [_$GameToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$GameToJson(this);

}

Game _$GameFromJson(Map<String, dynamic> json) => Game(
      id: json['id'] as int,
      name: json['name'] as String,
      description: json['description'] as String,
      active: json['active'] as bool,
    );

Map<String, dynamic> _$GameToJson(Game instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'description': instance.description,
      'active': instance.active,
    };

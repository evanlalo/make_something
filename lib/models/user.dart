import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class User {
  final int id;
  final String firstName, lastName, email;
  final bool isAdmin;

  User(
      {required this.id,
      required this.firstName,
      required this.lastName,
      required this.email,
      required this.isAdmin});

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  /// Connect the generated [_$UserToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserToJson(this);
}

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      email: json['email'] as String,
      isAdmin: json['isAdmin'] as bool,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'email': instance.email,
      'isAdmin': instance.isAdmin,
    };

import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserModel {
  final String? id;
  final String? displayName, email, photoURL;
  final bool? isEmailVerified;

  UserModel(
      {required this.id,
      required this.email,
      this.displayName,
      this.photoURL,
      this.isEmailVerified});

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);

  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);

  String? get avatar {
    if (displayName != null && displayName!.isNotEmpty) {
      List<String> nameParts = displayName!.split(' ');
      if (nameParts.length >= 2) {
        return nameParts[0][0].toUpperCase() + nameParts[1][0].toUpperCase();
      }
      return displayName![0].toUpperCase();
    }

    return email![0].toUpperCase();
  }
}

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      id: json['id'] as String,
      email: json['email'] as String,
      displayName: json['displayName'] as String,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'displayName': instance.displayName,
    };

// User(
//   displayName: 
//   email: 
//   isEmailVerified: true, 
//   isAnonymous: false, 
//   metadata: UserMetadata(
//     creationTime: 2024-09-11 10:22:17.281Z, 
//     lastSignInTime: 2024-09-11 10:28:34.853Z), 
//     phoneNumber: null, 
//     photoURL: 
//     providerData, [
//       UserInfo(
//         displayName: 
//         email: 
//         phoneNumber: null, 
//         photoURL: null, 
//         providerId: google.com, 
//         uid: 
//         )
//         ], 
// refreshToken: '',
// tenantId: null, 
// uid: 
// )
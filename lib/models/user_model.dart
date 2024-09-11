import 'package:json_annotation/json_annotation.dart';

@JsonSerializable()
class UserModel {
  final String? id;
  final String? displayName, email;

  UserModel(
      {required this.id,
      required this.email,
      this.displayName
      });

  factory UserModel.fromJson(Map<String, dynamic> json) => _$UserModelFromJson(json);

  /// Connect the generated [_$UserModelToJson] function to the `toJson` method.
  Map<String, dynamic> toJson() => _$UserModelToJson(this);


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
//   displayName: Evan Lalo, 
//   email: evanslalo@gmail.com, 
//   isEmailVerified: true, 
//   isAnonymous: false, 
//   metadata: UserMetadata(
//     creationTime: 2024-09-11 10:22:17.281Z, 
//     lastSignInTime: 2024-09-11 10:28:34.853Z), 
//     phoneNumber: null, 
//     photoURL: https://lh3.googleusercontent.com/a/ACg8ocI9SOD1lOeDryrT0BPqTKKXTXaHHuV4upDiD2WROktL5T4EMg=s96-c, 
//     providerData, [
//       UserInfo(
//         displayName: Evan Lalo, 
//         email: evanslalo@gmail.com, 
//         phoneNumber: null, 
//         photoURL: null, 
//         providerId: google.com, 
//         uid: 108893708249712526975
//         )
//         ], 
// refreshToken: '',
// tenantId: null, 
// uid: bq5GNfKyEXUXKjylCQSl5PVFzIA3
// )
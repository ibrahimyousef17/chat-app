import 'package:chat_app/domain/entity/userEntity.dart';

class UserDto extends UserEntity{
  static const String collectionName = 'users' ;
  UserDto({
    required super.id,
    required super.name,
    required super.email,
});


  factory UserDto.fromJson(Map<String, dynamic>? json) => UserDto(
    id: json?['id'] as String,
    email: json?['email'] as String,
    name: json?['name'] as String,
  );

  Map<String, dynamic> toJson() => {
    'id': id,
    'email': email,
    'name': name,
  };
}

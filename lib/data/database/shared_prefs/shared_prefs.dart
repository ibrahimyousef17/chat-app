import 'dart:convert';

import 'package:chat_app/data/model/userDto.dart';
import 'package:chat_app/domain/entity/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPrefUtils {
  static late SharedPreferences sharedPreferences ;

  static SharedPrefUtils? _instance ;
  SharedPrefUtils._();


  static Future<SharedPreferences> init()async{
    sharedPreferences = await SharedPreferences.getInstance();
    return sharedPreferences ;
  }

static SharedPrefUtils getInstance(){
    _instance??=SharedPrefUtils._();
    return _instance! ;
  }

  Future<bool> saveUserInSharedPref(UserDto userDto){
     return sharedPreferences.setString('User', jsonEncode(userDto.toJson()));
  }

  Either<Failures,UserDto> getUserFromPref(){
    var data = sharedPreferences.getString('User');
    if(data !=null){
      print('Successfully store user');
      return Right(UserDto.fromJson(jsonDecode(data)));
    }
    print('no user');
    return Left(CachedError(errorMessage: 'something went wrong in cache ,please try login'));
  }

  Future<bool> clearUser(){
    return sharedPreferences.remove('User');
  }
}
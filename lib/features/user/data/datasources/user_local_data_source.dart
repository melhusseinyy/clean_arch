import 'dart:convert';

import 'package:clean_arch/core/databases/cache/cache_helper.dart';
import 'package:clean_arch/core/errors/expentions.dart';
import 'package:clean_arch/features/user/data/models/user_model.dart';

class UserLocalDataSource {
  final CacheHelper cache;

  UserLocalDataSource({required this.cache});
  final String key="CachedUser";
  cacheUser(UserModel? userToCache){
   if(userToCache != null){
    cache.saveData(key: key, value:json.encode( userToCache.toJson()));
   }else{
    throw CacheExeption(errorMessage: "No internet connection");
   }
  }

  Future<UserModel> getLastUser(){
    final jsonString=cache.getDataString(key: key);
    if(jsonString !=null){
      return Future.value(UserModel.fromJson(json.decode(jsonString)));
    }else{
      throw CacheExeption(errorMessage: "No internet connection");
    }
  }
}
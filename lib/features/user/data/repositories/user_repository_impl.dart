import 'package:clean_arch/core/connection/network_info.dart';
import 'package:clean_arch/core/errors/expentions.dart';
import 'package:clean_arch/core/errors/failure.dart';
import 'package:clean_arch/core/params/params.dart';
import 'package:clean_arch/features/user/data/datasources/user_local_data_source.dart';
import 'package:clean_arch/features/user/data/datasources/user_remote_data_source.dart';
import 'package:clean_arch/features/user/domain/entities/user_entity.dart';
import 'package:clean_arch/features/user/domain/repositories/user_repository.dart';
import 'package:dartz/dartz.dart';

class UserRepositoryImpl extends UserRepository {
  final NetworkInfo networkInfo;
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;

  UserRepositoryImpl({
    required this.networkInfo,
    required this.remoteDataSource,
    required this.localDataSource,
  });
  @override
  Future<Either<Failure, UserEntity>> getUser({required UserParams params}) async{
    if(await networkInfo.isConnected!){
      try {
  final remoteUser=await remoteDataSource.getUser(params);
  localDataSource.cacheUser(remoteUser);
  return right(remoteUser);
} on ServerException catch (e) {
   return  left(Failure(errMessage: e.errorModel.errorMessage));
}
 }else{
  try {
  final localUser=await localDataSource.getLastUser();
  return right(localUser);
} on CacheExeption catch (e) {
   return left(Failure(errMessage: e.errorMessage));
}
  
 }
   
  }
}

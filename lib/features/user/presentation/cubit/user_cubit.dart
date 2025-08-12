import 'package:clean_arch/core/connection/network_info.dart';
import 'package:clean_arch/core/databases/api/dio_consumer.dart';
import 'package:clean_arch/core/databases/cache/cache_helper.dart';
import 'package:clean_arch/core/params/params.dart';
import 'package:clean_arch/features/user/data/datasources/user_local_data_source.dart';
import 'package:clean_arch/features/user/data/datasources/user_remote_data_source.dart';
import 'package:clean_arch/features/user/data/repositories/user_repository_impl.dart';
import 'package:clean_arch/features/user/domain/usescases/get_user.dart';
import 'package:clean_arch/features/user/presentation/cubit/user_state.dart';
import 'package:data_connection_checker_tv/data_connection_checker.dart';
import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  eitherFailureOrUser(int id) async {
    final failureOrUser = await GetUser(
      repository: UserRepositoryImpl(
        networkInfo: NetworkInfoImpl(DataConnectionChecker()),
        remoteDataSource: UserRemoteDataSource(api: DioConsumer(dio: Dio())),
        localDataSource: UserLocalDataSource(cache: CacheHelper()),
      ),
    ).call(params: UserParams(id: id.toString()));
   
    failureOrUser.fold(
      (failure)=>emit(GetUserFailure(errMessage: failure.errMessage)),
       (user)=> emit(GetUserSuccessfully(user: user))
    );
  }
}

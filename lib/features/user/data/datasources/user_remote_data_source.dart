import 'package:clean_arch/core/databases/api/api_consumer.dart';
import 'package:clean_arch/core/databases/api/end_points.dart';
import 'package:clean_arch/core/params/params.dart';
import 'package:clean_arch/features/user/data/models/user_model.dart';

class UserRemoteDataSource {
  final ApiConsumer api;

  UserRemoteDataSource({required this.api});
 Future<UserModel> getUser(UserParams params)async{
    final response= await api.get("${EndPoints.user}/${params.id}");
    return UserModel.fromJson(response);

  }
}
import 'package:clean_arch/core/databases/api/end_points.dart';
import 'package:clean_arch/features/user/data/models/submodel/company_model.dart';
import 'package:clean_arch/features/user/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  final int id;
  final String username;
  final String website;
  final CompanyModel company;
  UserModel({
    required super.name,
    required super.phone,
    required super.email,
    required super.address,
    required this.id,
    required this.username,
    required this.website,
    required this.company,
  });
  factory UserModel.fromJson(Map<String,dynamic>json){
    return UserModel(
      name: json[ApiKey.name],
      phone: json[ApiKey.phone],
      email: json[ApiKey.email],
      address: json[ApiKey.address],
      id: json[ApiKey.id],
      username: json[ApiKey.username],
      website: json[ApiKey.website],
      company: CompanyModel.fromJson(json[ApiKey.company]),
    );
  }
  Map<String, dynamic> toJson() {
    return {
      ApiKey.name: name,
      ApiKey.phone: phone,
      ApiKey.email: email,
      ApiKey.address: address,
      ApiKey.id: id,
      ApiKey.username: username,
      ApiKey.website: website,
      ApiKey.company: company,
    };
  }
}

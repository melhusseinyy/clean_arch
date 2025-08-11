
import 'package:clean_arch/features/user/domain/entities/sub_entities/geo_entity.dart';


class AdressEntity{
  final String street;
  final String suite;
  final String city;
  final String zipcode;
  final GeoEntity geo;

  AdressEntity({required this.street, required this.suite, required this.city, required this.zipcode, required this.geo});

}
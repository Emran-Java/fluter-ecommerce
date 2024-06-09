import 'package:json_annotation/json_annotation.dart';
part 'user.g.dart'; //use this command for generate g file (fluter pub run build_runner build --delete-conflicting-outputs)

@JsonSerializable()
class User{

  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"mobile_number")
  String? mobileNumber;


  User({
    this.id,
    this.name,
    this.mobileNumber
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
  Map<String, dynamic> toJson() => _$UserToJson(this);

}
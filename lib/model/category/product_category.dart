import 'package:json_annotation/json_annotation.dart';
part 'product_category.g.dart'; //use this command for generate g file (fluter pub run build_runner build --delete-conflicting-outputs)

@JsonSerializable()
class ProductCategory{

  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"category_name")
  String? name;


  ProductCategory({
    this.id,
    this.name
  });

  factory ProductCategory.fromJson(Map<String, dynamic> json) => _$ProductCategoryFromJson(json);
  Map<String, dynamic> toJson() => _$ProductCategoryToJson(this);

}
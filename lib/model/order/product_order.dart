import 'package:json_annotation/json_annotation.dart';
part 'product_order.g.dart';

@JsonSerializable()
class ProductOrder{

  @JsonKey(name:"id")
  String? id;

  @JsonKey(name:"address")
  String? address;

  @JsonKey(name:"customer")
  String? customer;

  @JsonKey(name:"dateTime")
  String? dateTime;

  @JsonKey(name:"item")
  String? item;

  @JsonKey(name:"price")
  String? price;

  @JsonKey(name:"phone")
  String? phone;

  @JsonKey(name:"transactionId")
  String? transactionId;

  @JsonKey(name:"userId")
  String? userId;

  @JsonKey(name:"productId")
  String? productId;

  ProductOrder({
    this.id,
    this.address,
    this.customer,
    this.dateTime,
    this.item,
    this.price,
    this.phone,
    this.transactionId,
    this.userId,
    this.productId,
  });

  factory ProductOrder.fromJson(Map<String, dynamic> json) => _$ProductOrderFromJson(json);
  Map<String, dynamic> toJson() => _$ProductOrderToJson(this);

}
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'product_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProductOrder _$ProductOrderFromJson(Map<String, dynamic> json) => ProductOrder(
      id: json['id'] as String?,
      address: json['address'] as String?,
      customer: json['customer'] as String?,
      dateTime: json['dateTime'] as String?,
      item: json['item'] as String?,
      price: json['price'] as String?,
      phone: json['phone'] as String?,
      transactionId: json['transactionId'] as String?,
      userId: json['userId'] as String?,
      productId: json['productId'] as String?,
    );

Map<String, dynamic> _$ProductOrderToJson(ProductOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'address': instance.address,
      'customer': instance.customer,
      'dateTime': instance.dateTime,
      'item': instance.item,
      'price': instance.price,
      'phone': instance.phone,
      'transactionId': instance.transactionId,
      'userId': instance.userId,
      'productId': instance.productId,
    };

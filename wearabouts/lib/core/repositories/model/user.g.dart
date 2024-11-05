// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as String,
      username: json['username'] as String,
      password: json['password'] as String,
      email: json['email'] as String,
      sales: (json['sales'] as num).toInt(),
      purchases: (json['purchases'] as num).toInt(),
      profilePic: json['profilePic'] as String,
      rating: (json['rating'] as num).toInt(),
      labels: Map<String, int>.from(json['labels'] as Map),
      latitude: (json['lattitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      city: json['city'] as String,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'username': instance.username,
      'password': instance.password,
      'email': instance.email,
      'sales': instance.sales,
      'purchases': instance.purchases,
      'profilePic': instance.profilePic,
      'rating': instance.rating,
      'labels': instance.labels,
      'lattitude': instance.latitude,
      'longitude': instance.longitude,
      'city': instance.city,
    };

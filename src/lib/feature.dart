import 'package:flutter/material.dart';


@immutable
class Feature {
  Feature({
    this.name,
  });

  Feature.fromJson(Map<String, Object> json)
      : this(
      name: json['name'] as String
  );

  final String name;

  Map<String, Object> toJson() {
    return {
      'name': name
    };
  }
}
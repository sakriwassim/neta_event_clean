import 'dart:convert';

import '../../domain/entities/event.dart';

class EventModel extends Event {
  EventModel(
      {required super.id,
      required super.libelle,
      required super.description,
      required super.prix});

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
        id: json['id'],
        libelle: json['libelle'],
        description: json['description'],
        prix: json['prix']);
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'libelle': libelle,
      'description': description,
      'prix': prix
    };
  }
}

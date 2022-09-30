import 'package:equatable/equatable.dart';

class Event extends Equatable {
  final int id;
  final String libelle;
  final String description;
  final int prix;

  Event(
      {required this.id,
      required this.libelle,
      required this.description,
      required this.prix});

  @override
  List<Object?> get props => [id, libelle, description, prix];
}

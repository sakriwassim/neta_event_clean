import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:neta_event_clean/core/error/exceptions.dart';
import 'package:neta_event_clean/features/events/data/models/event_model.dart';
import 'package:neta_event_clean/features/events/domain/usecases/get_all_events.dart';
import 'package:http/http.dart' as http;

abstract class EventRemoteDataSource {
  Future<List<EventModel>> getAllEvents();
  Future<Unit> deleteEvents(int EventId);
  Future<Unit> updateEvents(EventModel eventModel);
  Future<Unit> addEvents(EventModel eventModel);
}

const BASE_URL = "https://frozen-refuge-80965.herokuapp.com/api/v1";
const token =
    'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpc3MiOiJodHRwOlwvXC9mcm96ZW4tcmVmdWdlLTgwOTY1Lmhlcm9rdWFwcC5jb21cL2FwaVwvdjFcL0xvZ2luIiwiaWF0IjoxNjY0NTUwNTIzLCJleHAiOjE2NjQ1NTQxMjMsIm5iZiI6MTY2NDU1MDUyMywianRpIjoiSTV2RENLb3NnUVVhWHo2bCIsInN1YiI6MywicHJ2IjoiMjNiZDVjODk0OWY2MDBhZGIzOWU3MDFjNDAwODcyZGI3YTU5NzZmNyIsInVzZXJfaWQiOjMsImVtYWlsIjoid2Fzc2ltbEBlbWFpbC5jb20ifQ.JrZwVjPqWU_TZ4YrylOtcyMzQg-XoGYcV7hE9fHLGc';

class EventRemoteDataSourceImpl implements EventRemoteDataSource {
  final http.Client client;

  EventRemoteDataSourceImpl({required this.client});

  @override
  Future<List<EventModel>> getAllEvents() async {
    final response = await client.get(Uri.parse(BASE_URL + "/Events"),
        headers: {'Authorization': 'Bearer ' '$token'});
    if (response.statusCode == 200) {
      final List decodedJson = json.decode(response.body) as List;
      final List<EventModel> eventModels = decodedJson
          .map<EventModel>(
              (jsonEventModel) => EventModel.fromJson(jsonEventModel))
          .toList();

      return eventModels;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<Unit> addEvents(EventModel eventModel) {
    // TODO: implement addEvents
    throw UnimplementedError();
  }

  @override
  Future<Unit> deleteEvents(int EventId) {
    // TODO: implement deleteEvents
    throw UnimplementedError();
  }

  @override
  Future<Unit> updateEvents(EventModel eventModel) {
    // TODO: implement updateEvents
    throw UnimplementedError();
  }
}

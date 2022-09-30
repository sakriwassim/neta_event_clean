import 'dart:convert';

import 'package:dartz/dartz.dart';
import 'package:neta_event_clean/core/error/exceptions.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../models/event_model.dart';

abstract class EventLocalDataSource {
  Future<List<EventModel>> getCachedEvents();
  Future<Unit> CachedEvents(List<EventModel> EventModels);
}

const CACHED_EVENTS = "CACHED_EVENTS";

class EventLocalDataSourceImpl implements EventLocalDataSource {
  final SharedPreferences sharedPreferences;

  EventLocalDataSourceImpl({required this.sharedPreferences});
  @override
  Future<Unit> CachedEvents(List<EventModel> EventModels) {
    List eventModelsToJson =
        EventModels.map<Map<String, dynamic>>((postModel) => postModel.toJson())
            .toList();
    sharedPreferences.setString(CACHED_EVENTS, jsonEncode(eventModelsToJson));
    return Future.value(unit);
    // throw UnimplementedError();
  }

  @override
  Future<List<EventModel>> getCachedEvents() {
    final jsonString = sharedPreferences.getString(CACHED_EVENTS);

    if (jsonString != null) {
      List decodeJsonData = json.decode(jsonString);
      List<EventModel> jsonToEventModels = decodeJsonData
          .map<EventModel>(
              (jsonEventModel) => EventModel.fromJson(jsonEventModel))
          .toList();
      return Future.value(jsonToEventModels);
    } else {
      throw EmptyCachException();
    }
  }
}

import 'dart:math';

import 'package:neta_event_clean/core/error/exceptions.dart';
import 'package:neta_event_clean/core/network/network_info.dart';
import 'package:neta_event_clean/features/events/data/datasources/event_local_data_source.dart';
import 'package:neta_event_clean/features/events/data/datasources/event_remote_data_source.dart';
import 'package:neta_event_clean/features/events/data/models/event_model.dart';
import 'package:neta_event_clean/features/events/domain/entities/event.dart';
import 'package:neta_event_clean/core/error/failures.dart';
import 'package:dartz/dartz.dart';
import 'package:neta_event_clean/features/events/domain/repositories/eventes_repository.dart';

typedef Future<Unit> AddOrdeleteOrupdateEvente();

class EventsRepositoryImp implements EventsRepository {
  final EventRemoteDataSource remoteDataSource;
  final EventLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  EventsRepositoryImp(
      {required this.networkInfo,
      required this.remoteDataSource,
      required this.localDataSource});

  @override
  Future<Either<Failure, List<Event>>> getAllEvents() async {
    if (await networkInfo.isConncted) {
      try {
        final remoteEvents = await remoteDataSource.getAllEvents();
        localDataSource.CachedEvents(remoteEvents);
        return Right(remoteEvents);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      try {
        final localEvents = await localDataSource.getCachedEvents();
        return Right(localEvents);
      } on EmptyCachException {
        return left(EmptyCacheFailure());
      }
    }
  }

  @override
  Future<Either<Failure, Unit>> addEvents(Event event) async {
    final EventModel eventModel = EventModel(
        id: event.id,
        libelle: event.libelle,
        description: event.description,
        prix: event.prix);

    return _getmessage(() {
      return remoteDataSource.addEvents(eventModel);
    });
  }

  @override
  Future<Either<Failure, Unit>> deleteEvent(int eventId) async {
    return _getmessage(() {
      return remoteDataSource.deleteEvents(eventId);
    });
  }

  @override
  Future<Either<Failure, Unit>> updateEvents(Event event) async {
    final EventModel eventModel = EventModel(
        id: event.id,
        libelle: event.libelle,
        description: event.description,
        prix: event.prix);
    return _getmessage(() {
      return remoteDataSource.updateEvents(eventModel);
    });
  }

  Future<Either<Failure, Unit>> _getmessage(
      AddOrdeleteOrupdateEvente addOrdeleteOrupdateEvente) async {
    if (await networkInfo.isConncted) {
      try {
        await addOrdeleteOrupdateEvente();
        return Right(unit);
      } on ServerException {
        return left(ServerFailure());
      }
    } else {
      return Left(OfflineFailure());
    }
  }
}

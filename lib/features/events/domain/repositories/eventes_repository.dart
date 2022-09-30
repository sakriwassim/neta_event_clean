import 'package:dartz/dartz.dart';
import 'package:neta_event_clean/features/events/domain/entities/event.dart';

import '../../../../core/error/failures.dart';

abstract class EventsRepository {
  Future<Either<Failure, List<Event>>> getAllEvents();
  Future<Either<Failure, Unit>> deleteEvent(int id);
  Future<Either<Failure, Unit>> updateEvents(Event event);
  Future<Either<Failure, Unit>> addEvents(Event event);
}

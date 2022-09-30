import 'package:dartz/dartz.dart';
import 'package:neta_event_clean/features/events/domain/entities/event.dart';
import 'package:neta_event_clean/features/events/domain/repositories/eventes_repository.dart';

import '../../../../core/error/failures.dart';

class GetAllEventsUsecase {
  final EventsRepository repository;

  GetAllEventsUsecase(this.repository);

  Future<Either<Failure, List<Event>>> call() async {
    return await repository.getAllEvents();
  }
}

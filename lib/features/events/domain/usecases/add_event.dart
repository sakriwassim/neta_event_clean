import 'package:dartz/dartz.dart';
import 'package:neta_event_clean/core/error/failures.dart';
import 'package:neta_event_clean/features/events/domain/entities/event.dart';

import '../repositories/eventes_repository.dart';

class DeleteEventUsecase {
  final EventsRepository repository;

  DeleteEventUsecase(this.repository);

  Future<Either<Failure, Unit>> call(Event event) async {
    return await repository.addEvents(event);
  }
}

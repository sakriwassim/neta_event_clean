import 'package:dartz/dartz.dart';
import 'package:neta_event_clean/features/events/domain/entities/event.dart';
import 'package:neta_event_clean/features/events/domain/repositories/eventes_repository.dart';

import '../../../../core/error/failures.dart';

class DeleteEventUsecase {
  final EventsRepository repository;

  DeleteEventUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int evantId) async {
    return await repository.deleteEvent(evantId);
  }
}

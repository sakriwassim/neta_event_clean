import 'package:dartz/dartz.dart';
import 'package:neta_event_clean/core/error/failures.dart';

import '../repositories/eventes_repository.dart';

class DeleteEventUsecase {
  final EventsRepository repository;

  DeleteEventUsecase(this.repository);

  Future<Either<Failure, Unit>> call(int evantId) async {
    return await repository.deleteEvent(evantId);
  }
}

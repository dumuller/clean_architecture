import 'package:clean_architecture/core/usecase/errors/failures.dart';
import 'package:clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:dartz/dartz.dart';

abstract class ISpaceMediaRepository {
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(DateTime dateTime);
}
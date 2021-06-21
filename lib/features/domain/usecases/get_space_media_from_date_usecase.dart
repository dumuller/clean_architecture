import 'dart:async';

import 'package:clean_architecture/core/usecase/errors/failures.dart';
import 'package:clean_architecture/core/usecase/usecase.dart';
import 'package:clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:clean_architecture/features/domain/repositories/space_media_repository.dart';
import 'package:dartz/dartz.dart';

class GetSpaceMediaFromDateUsecase implements UseCase<SpaceMediaEntity, DateTime> {
  final ISpaceMediaRepository repository;

  GetSpaceMediaFromDateUsecase(this.repository);


  @override
  Future<Either<Failure, SpaceMediaEntity>> call(DateTime dateTime) async {
    return await repository.getSpaceMediaFromDate(dateTime);
  }

}
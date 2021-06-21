import 'package:clean_architecture/core/usecase/errors/exceptions.dart';
import 'package:clean_architecture/core/usecase/errors/failures.dart';
import 'package:clean_architecture/features/data/datasources/space_media_datasource.dart';
import 'package:clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:clean_architecture/features/domain/repositories/space_media_repository.dart';
import 'package:dartz/dartz.dart';

class SpaceMediaRepositoryImplementation implements ISpaceMediaRepository {
  final ISpaceMediaDatasource datasource;

  SpaceMediaRepositoryImplementation(this.datasource);

  @override
  Future<Either<Failure, SpaceMediaEntity>> getSpaceMediaFromDate(DateTime dateTime) async {
    try {
      final result = await datasource.getSpaceMediaFromDate(dateTime);
      return Right(result);
    } on ServerException {
      return Left(ServerFailure());
    }
  }

}
import 'package:clean_architecture/core/usecase/errors/exceptions.dart';
import 'package:clean_architecture/core/usecase/errors/failures.dart';
import 'package:clean_architecture/features/data/datasources/space_media_datasource.dart';
import 'package:clean_architecture/features/data/models/space_media_model.dart';
import 'package:clean_architecture/features/data/repositories/space_media_repository_implementation.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceMediaDatasource extends Mock implements ISpaceMediaDatasource {}

void main() {
  late SpaceMediaRepositoryImplementation repository;
  late ISpaceMediaDatasource datasource;

  setUp(() {
    datasource = MockSpaceMediaDatasource();
    repository = SpaceMediaRepositoryImplementation(datasource);
  });

  final tSpaceMediaModel = SpaceMediaModel(
      description: "description",
      mediaType: "image",
      title: "title",
      mediaUrl: "mediaUrl");
  
  final tDateTime = DateTime.now();
  
  test("should return space media model when call the datasource", () async {
    when(() => datasource.getSpaceMediaFromDate(tDateTime)).thenAnswer((_) async => tSpaceMediaModel);
    
    final result = await repository.getSpaceMediaFromDate(tDateTime);
    
    expect(result, Right(tSpaceMediaModel));
    verify(() => datasource.getSpaceMediaFromDate(tDateTime)).called(1);
  });

  test("should return a server Failure when call", () async {
    when(() => datasource.getSpaceMediaFromDate(tDateTime)).thenThrow(ServerException());

    final result = await repository.getSpaceMediaFromDate(tDateTime);

    //expect(result, throwsA(ServerFailure()));
    expect(result, Left(ServerFailure()));
    verify(() => datasource.getSpaceMediaFromDate(tDateTime)).called(1);
  });


}
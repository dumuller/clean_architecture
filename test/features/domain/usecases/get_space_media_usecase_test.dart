import 'package:clean_architecture/core/usecase/errors/failures.dart';
import 'package:clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:clean_architecture/features/domain/repositories/space_media_repository.dart';
import 'package:clean_architecture/features/domain/usecases/get_space_media_from_date_usecase.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockSpaceMediaRepository extends Mock implements ISpaceMediaRepository {}

void main() {
  late GetSpaceMediaFromDateUsecase usercase;
  late ISpaceMediaRepository repository;

  setUp(() {
    repository = MockSpaceMediaRepository();
    usercase = GetSpaceMediaFromDateUsecase(repository);
  });

  final tSpaceMedia = SpaceMediaEntity(
      description: "description test from etc...",
      mediaType: "image",
      title: "title of image",
      mediaUrl: "mediaUrl test",
  );

  final tDateTime = DateTime.now();

  test("Should get space media entity for a given data from the repository",
      () async {
        when(() => repository.getSpaceMediaFromDate(tDateTime)).thenAnswer((_) async => Right(tSpaceMedia));

        final result = await usercase(tDateTime);

        expect(result, Right(tSpaceMedia));
        verify(() => repository.getSpaceMediaFromDate(tDateTime)).called(1);
      }
  );
  
  test("Should return a ServerFailure when don't succeed", () async {
    when(() => repository.getSpaceMediaFromDate(tDateTime)).thenAnswer((_) async => Left(ServerFailure()));

    final result = await usercase(tDateTime);
    expect(result, Left(ServerFailure()));
    verify(() => repository.getSpaceMediaFromDate(tDateTime)).called(1);
  });
}

import 'dart:io';

import 'package:clean_architecture/core/http_client/dio_implementation.dart';
import 'package:clean_architecture/core/http_client/http_client.dart';
import 'package:clean_architecture/core/usecase/errors/exceptions.dart';
import 'package:clean_architecture/features/data/datasources/space_media_datasource.dart';
import 'package:clean_architecture/features/data/datasources/nasa_datasource_implementation.dart';
import 'package:clean_architecture/features/data/models/space_media_model.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import '../../mocks/space_media_mock.dart';


class HttpClientMock extends Mock implements IHttpClient {}

void main() {
  late ISpaceMediaDatasource datasource;
  late IHttpClient client;

  setUp(() {
    client = HttpClientMock();
    datasource = NasaDatasourceImplementation(client);
  });

  final tDateTime = DateTime.now();
  final urlExpected = "https://api.nasa.gov/planetary/apod?api_key=DEMO_KEY&date=2021-06-16";

  void successMock() {
    when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: mockSpaceMedia, statusCode: 200));
  }

  test("should call the get method with correct url", () async {
    successMock();
    await datasource.getSpaceMediaFromDate(tDateTime);
    verify(() => client.get(urlExpected)).called(1);
  });

  test("should return a SpaceMediaModel when is successful", () async {
    successMock();
    final result = await datasource.getSpaceMediaFromDate(tDateTime);
    final tSpaceMediaModelExpected = SpaceMediaModel(
        description: "If Scorpius looked this good to the unaided eye, humans might remember it better.",
        mediaType: "image",
        title: "Scorpius Enhanced",
        mediaUrl: "https://apod.nasa.gov/apod/image/2106/ScorpiusEnhanced_Lenz_1080.jpg",
    );

    expect(result, tSpaceMediaModelExpected);
  });

  test("should throw a ServerException when the call is unccessful", () async {
    when(() => client.get(any())).thenAnswer((_) async => HttpResponse(data: 'somenthing a wrong', statusCode: 400));
    final result = datasource.getSpaceMediaFromDate(tDateTime);
    expect(() => result, throwsA(ServerException()));
  });

}
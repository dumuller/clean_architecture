import 'dart:convert';

import 'package:clean_architecture/features/data/models/space_media_model.dart';
import 'package:clean_architecture/features/domain/entities/space_media_entity.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../mocks/space_media_mock.dart';

void main() {
  final tSpaceMediaModel = SpaceMediaModel(
      description: "If Scorpius looked this good to the unaided eye, humans might remember it better.",
      mediaType: "image",
      title: "Scorpius Enhanced",
      mediaUrl: "https://apod.nasa.gov/apod/image/2106/ScorpiusEnhanced_Lenz_1080.jpg"
  );

  test("should be a subclass of SpaceMediaEntity", () {
    expect(tSpaceMediaModel, isA<SpaceMediaEntity>());
  });

  test("should return a valid model from json", () {
    final Map<String, dynamic> jsonMap = jsonDecode(mockSpaceMedia);
    final result = SpaceMediaModel.fromJson(jsonMap);
    expect(result, tSpaceMediaModel);
  });

  test("should return a json map container the property data", () {
    final expectedMap = {
      "explanation":"If Scorpius looked this good to the unaided eye, humans might remember it better.",
      "media_type":"image",
      "title":"Scorpius Enhanced",
      "url":"https://apod.nasa.gov/apod/image/2106/ScorpiusEnhanced_Lenz_1080.jpg"
    };

    final result = tSpaceMediaModel.toJson();

    expect(result, expectedMap);
  });
}
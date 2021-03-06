import 'dart:convert';

import 'package:clean_architecture/core/http_client/http_client.dart';
import 'package:clean_architecture/core/usecase/errors/exceptions.dart';
import 'package:clean_architecture/core/utils/converters/date_to_string_converter.dart';
import 'package:clean_architecture/core/utils/keys/nasa_api_key.dart';
import 'package:clean_architecture/features/data/datasources/endpoints/nasa_endpoints.dart';
import 'package:clean_architecture/features/data/datasources/space_media_datasource.dart';
import 'package:clean_architecture/features/data/models/space_media_model.dart';

class NasaDatasourceImplementation implements ISpaceMediaDatasource {

  final IHttpClient client;

  NasaDatasourceImplementation(this.client);

  @override
  Future<SpaceMediaModel> getSpaceMediaFromDate(DateTime date) async {
    final response = await client.get(NasaEndpoints.apod(NasaApiKeys.apiKey, DateToStringConverter.convert(date)));
    if (response.statusCode == 200) {
      return SpaceMediaModel.fromJson(jsonDecode(response.data));
    } else {
      throw ServerException();
    }
  }
  
}
import 'package:dartz/dartz.dart';
import 'package:dictionaryapp/model/dictionary_model.dart';
import 'package:dio/dio.dart';

class DictionaryRepository {
  String baseUrl = "https://api.dictionaryapi.dev/api/v2/entries/en/";
  Dio dio = Dio();

  Future<Either<DictionaryModel, String>> fetchData(
      {required String word}) async {
    try{
      final response = await dio.get("$baseUrl$word");
    final result = DictionaryModel.fromJson(response.data[0]);
  return Left(result);
    }catch (e){
      return const Right("Meaning not found");
    }
   
  }
}

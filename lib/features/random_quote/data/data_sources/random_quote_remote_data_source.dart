import 'package:dio/dio.dart';
import 'package:flutter_clean_archeticture/core/api/endpoints.dart';
import 'package:flutter_clean_archeticture/core/error/exceptions.dart';
import 'package:flutter_clean_archeticture/core/utils/app_strings.dart';
import 'package:flutter_clean_archeticture/features/random_quote/data/models/quote_model.dart';

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  Dio dio;

  RandomQuoteRemoteDataSourceImpl({required this.dio});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final res = await dio.get(
      Endpoints.randomQuote,
      options: Options(contentType: AppStrings.applicationJson),
    );
    if (res.statusCode == 200) {
      return QuoteModel.fromJson(res.data);
    } else {
      throw ServerException();
    }
  }
}

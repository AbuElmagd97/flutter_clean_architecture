import 'package:flutter_clean_archeticture/core/api/endpoints.dart';
import 'package:flutter_clean_archeticture/features/random_quote/data/models/quote_model.dart';

import '../../../../core/api/api_consumer.dart';

abstract class RandomQuoteRemoteDataSource {
  Future<QuoteModel> getRandomQuote();
}

class RandomQuoteRemoteDataSourceImpl implements RandomQuoteRemoteDataSource {
  ApiConsumer apiConsumer;

  RandomQuoteRemoteDataSourceImpl({required this.apiConsumer});

  @override
  Future<QuoteModel> getRandomQuote() async {
    final response = await apiConsumer.get(
      Endpoints.randomQuote,
    );
    return QuoteModel.fromJson(response);
  }
}

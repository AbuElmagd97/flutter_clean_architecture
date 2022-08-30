import 'package:dartz/dartz.dart';
import 'package:flutter_clean_archeticture/core/error/exceptions.dart';
import 'package:flutter_clean_archeticture/core/error/failures.dart';
import 'package:flutter_clean_archeticture/core/network/network_info.dart';
import 'package:flutter_clean_archeticture/features/random_quote/domain/entities/quote.dart';
import 'package:flutter_clean_archeticture/features/random_quote/domain/repositories/quote_repository.dart';

import '../data_sources/random_quote_local_data_source.dart';
import '../data_sources/random_quote_remote_data_source.dart';

class QuoteRepositoryImpl implements QuoteRepository {
  final NetworkInfo networkInfo;
  final RandomQuoteRemoteDataSource randomQuoteRemoteDataSource;
  final RandomQuoteLocalDataSource randomQuoteLocalDataSource;

  QuoteRepositoryImpl({
    required this.networkInfo,
    required this.randomQuoteRemoteDataSource,
    required this.randomQuoteLocalDataSource,
  });
  @override
  Future<Either<Failure, Quote>> getRandomQuote() async {
    if (await networkInfo.isConnected) {
      try {
        final remoteRandomQuote =
            await randomQuoteRemoteDataSource.getRandomQuote();
        randomQuoteLocalDataSource.cacheQuote(remoteRandomQuote);
        return Right(remoteRandomQuote);
      } on ServerException {
        return Left(ServerFailure());
      }
    }
    else {
      try {
        final cacheRandomQuote =
            await randomQuoteLocalDataSource.getLastRandomQuote();
        return Right(cacheRandomQuote);
      } on CacheException {
        return Left(CacheFailure());
      }
    }
  }
}

import 'package:dio/dio.dart';
import 'package:flutter_clean_archeticture/core/api/api_consumer.dart';
import 'package:flutter_clean_archeticture/core/api/dio_consumer.dart';
import 'package:flutter_clean_archeticture/core/network/network_info.dart';
import 'package:flutter_clean_archeticture/features/random_quote/data/data_sources/random_quote_local_data_source.dart';
import 'package:flutter_clean_archeticture/features/random_quote/data/repositories/quote_repository_impl.dart';
import 'package:flutter_clean_archeticture/features/random_quote/domain/repositories/quote_repository.dart';
import 'package:flutter_clean_archeticture/features/random_quote/domain/use_cases/get_random_quote.dart';
import 'package:flutter_clean_archeticture/features/random_quote/presentation/cubit/random_quote_cubit.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'core/api/app_interceptors.dart';
import 'features/random_quote/data/data_sources/random_quote_remote_data_source.dart';
import 'features/splash/data/datasources/lang_local_data_source.dart';
import 'features/splash/data/repositories/lang_repository_impl.dart';
import 'features/splash/domain/repositories/lang_repository.dart';
import 'features/splash/domain/usecases/change_lang.dart';
import 'features/splash/domain/usecases/get_saved_lang.dart';
import 'features/splash/presentation/cubit/locale_cubit.dart';


final sl = GetIt.instance;

Future<void> init() async {
  //! Features

  // Blocs
  sl.registerFactory<RandomQuoteCubit>(
          () => RandomQuoteCubit(getRandomQuoteUseCase: sl()));
  sl.registerFactory<LocaleCubit>(
          () => LocaleCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));

  // Use cases
  sl.registerLazySingleton<GetRandomQuote>(
          () => GetRandomQuote(quoteRepository: sl()));
  sl.registerLazySingleton<GetSavedLangUseCase>(
          () => GetSavedLangUseCase(langRepository: sl()));
  sl.registerLazySingleton<ChangeLangUseCase>(
          () => ChangeLangUseCase(langRepository: sl()));

  // Repository
  sl.registerLazySingleton<QuoteRepository>(() => QuoteRepositoryImpl(
      networkInfo: sl(),
      randomQuoteRemoteDataSource: sl(),
      randomQuoteLocalDataSource: sl()));
  sl.registerLazySingleton<LangRepository>(
          () => LangRepositoryImpl(langLocalDataSource: sl()));

  // Data Sources
  sl.registerLazySingleton<RandomQuoteLocalDataSource>(
          () => RandomQuoteLocalDataSourceImpl(sharedPreferences: sl()));
  sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
          () => RandomQuoteRemoteDataSourceImpl(apiConsumer: sl()));
  sl.registerLazySingleton<LangLocalDataSource>(
          () => LangLocalDataSourceImpl(sharedPreferences: sl()));

  //! Core
  sl.registerLazySingleton<NetworkInfo>(
          () => NetworkInfoImpl(connectionChecker: sl()));
  sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));

  //! External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => AppInterceptors());
  sl.registerLazySingleton(() => LogInterceptor(
      request: true,
      requestBody: true,
      requestHeader: true,
      responseBody: true,
      responseHeader: true,
      error: true));
  sl.registerLazySingleton(() => InternetConnectionChecker());
  sl.registerLazySingleton(() => Dio());
}



// final sl = GetIt.instance;
//
// Future<void> init() async {
//   /// Features
//   //Blocs
//   sl.registerFactory(() => RandomQuoteCubit(getRandomQuoteUseCase: sl()));
//   sl.registerFactory<LocaleCubit>(
//       () => LocaleCubit(getSavedLangUseCase: sl(), changeLangUseCase: sl()));
//   // Use Cases
//   sl.registerLazySingleton(() => GetRandomQuote(quoteRepository: sl()));
//   sl.registerLazySingleton<GetSavedLangUseCase>(
//       () => GetSavedLangUseCase(langRepository: sl()));
//   sl.registerLazySingleton<ChangeLangUseCase>(
//       () => ChangeLangUseCase(langRepository: sl()));
//
//   // Repository
//   sl.registerLazySingleton<QuoteRepository>(
//     () => QuoteRepositoryImpl(
//       networkInfo: sl(),
//       randomQuoteRemoteDataSource: sl(),
//       randomQuoteLocalDataSource: sl(),
//     ),
//   );
//   sl.registerLazySingleton<LangRepository>(
//       () => LangRepositoryImpl(langLocalDataSource: sl()));
//
//   // Data Sources
//   sl.registerLazySingleton<RandomQuoteLocalDataSource>(
//     () => RandomQuoteLocalDataSourceImpl(
//       sharedPreferences: sl(),
//     ),
//   );
//
//   sl.registerLazySingleton<RandomQuoteRemoteDataSource>(
//     () => RandomQuoteRemoteDataSourceImpl(
//       apiConsumer: sl(),
//     ),
//   );
//
//   /// Core
//   sl.registerLazySingleton<NetworkInfo>(
//     () => NetworkInfoImpl(
//       connectionChecker: sl(),
//     ),
//   );
//   sl.registerLazySingleton<ApiConsumer>(() => DioConsumer(client: sl()));
//
//   /// External
//   final sharedPreferences = await SharedPreferences.getInstance();
//   sl.registerLazySingleton(() => sharedPreferences);
//   sl.registerLazySingleton(() => AppInterceptors());
//   sl.registerLazySingleton(() => LogInterceptor(
//       request: true,
//       requestBody: true,
//       requestHeader: true,
//       responseHeader: true,
//       responseBody: true,
//       error: true));
//   sl.registerLazySingleton(() => InternetConnectionChecker());
//   sl.registerLazySingleton(() => Dio());
// }

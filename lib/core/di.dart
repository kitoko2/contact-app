import 'package:contact_app/core/network/connection_checker.dart';
import 'package:contact_app/core/network/dio_helper.dart';
import 'package:contact_app/data/datasources/local/onboarding_local_data_source.dart';
import 'package:contact_app/data/datasources/remote/contact_remote_data_source.dart';
import 'package:contact_app/data/repositories/contact_repository_impl.dart';
import 'package:contact_app/data/repositories/onboarding_repository_impl.dart';
import 'package:contact_app/domain/repositories/contact_repository.dart';
import 'package:contact_app/domain/repositories/onboarding_repository.dart';
import 'package:contact_app/domain/usecases/complete_onboarding_use_case.dart';
import 'package:contact_app/domain/usecases/get_contact_use_case.dart';
import 'package:contact_app/presentation/home/blocs/contact_bloc.dart';
import 'package:contact_app/presentation/onboarding/blocs/onboarding_bloc.dart';
import 'package:contact_app/presentation/splash/blocs/splash_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker_plus/internet_connection_checker_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Di {
  static Future<void> init() async {
    final getIt = GetIt.instance;

    ///*********************************************************
    /// External
    ///*********************************************************

    // InternetConnection
    getIt.registerLazySingleton<InternetConnection>(() => InternetConnection());

    // SharedPreferences
    final sharedPreferences = await SharedPreferences.getInstance();
    getIt.registerLazySingleton(() => sharedPreferences);

    // Connection Checker
    getIt.registerLazySingleton<ConnectionChecker>(
      () => ConnectionCheckerImpl(
        getIt<InternetConnection>(),
      ),
    );

    // DioHelper
    getIt.registerLazySingleton<DioHelper>(
      () => DioHelper(),
    );

    ///*********************************************************
    /// DataSources
    ///*********************************************************

    // Contact DataSource
    getIt.registerLazySingleton<ContactRemoteDataSource>(
      () => ContactRemoteDataSourceImpl(
        dioHelper: getIt<DioHelper>(),
      ),
    );

    // Onboarding DataSource
    getIt.registerLazySingleton<OnboardingLocalDataSource>(
      () => OnboardingLocalDataSourceImpl(
        sharedPreferences: getIt<SharedPreferences>(),
      ),
    );

    ///*********************************************************
    /// Repositories
    ///*********************************************************

    // Contact Repository
    getIt.registerLazySingleton<ContactRepository>(
      () => ContactRepositoryImpl(
        remoteDataSource: getIt<ContactRemoteDataSource>(),
        connectionChecker: getIt<ConnectionChecker>(),
      ),
    );
    // Onboarding Repository
    getIt.registerLazySingleton<OnboardingRepository>(
      () => OnboardingRepositoryImpl(
        localDataSource: getIt<OnboardingLocalDataSource>(),
      ),
    );

    ///*********************************************************
    /// Use Cases
    ///*********************************************************

    // Get Contacts Use Case
    getIt.registerLazySingleton(
      () => GetContactsUseCase(
        repository: getIt<ContactRepository>(),
      ),
    );
    // Complete Onboarding Use Case
    getIt.registerLazySingleton(
      () => CompleteOnboardingUseCase(
        repository: getIt<OnboardingRepository>(),
      ),
    );

    ///*********************************************************
    /// Blocs
    ///*********************************************************

    // Contact Bloc
    getIt.registerFactory(
      () => ContactBloc(
        getContactsUseCase: getIt<GetContactsUseCase>(),
      ),
    );
    // Splash Bloc
    getIt.registerFactory(
      () => SplashBloc(
        onboardingLocalDataSource: getIt<OnboardingLocalDataSource>(),
      ),
    );
    // Onboarding Bloc
    getIt.registerFactory(
      () => OnboardingBloc(
        completeOnboardingUseCase: getIt<CompleteOnboardingUseCase>(),
      ),
    );
  }
}

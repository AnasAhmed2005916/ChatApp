import 'package:chat_app/features/auth/data/repos/auth_repo.dart';
import 'package:chat_app/features/auth/data/repos/auth_repo_impl.dart';
import 'package:chat_app/features/auth/presentation/cubit/auth_cubit.dart';

import 'package:chat_app/features/home/data/repos/home_repo.dart';
import 'package:chat_app/features/home/data/repos/home_repo_impl.dart';
import 'package:chat_app/features/home/presentation/cubit/home_cubit.dart';

import 'package:chat_app/features/chat/data/repos/chat_repo.dart';
import 'package:chat_app/features/chat/data/repos/chat_repo_impl.dart';
import 'package:chat_app/features/chat/presentation/cubit/chat_cubit.dart';

import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setupServiceLocator() {
  // ===========================
  // Repositories
  // ===========================

  getIt.registerLazySingleton<AuthRepo>(() => AuthRepoImpl());

  getIt.registerLazySingleton<HomeRepo>(() => HomeRepoImpl());

  getIt.registerLazySingleton<ChatRepo>(() => ChatRepoImpl());

  // ===========================
  // Cubits
  // ===========================

  getIt.registerFactory<AuthCubit>(() => AuthCubit(getIt<AuthRepo>()));

  getIt.registerFactory<HomeCubit>(() => HomeCubit(getIt<HomeRepo>()));

  getIt.registerFactory<ChatCubit>(() => ChatCubit(getIt<ChatRepo>()));
}

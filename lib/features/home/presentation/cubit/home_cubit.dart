import 'package:chat_app/features/auth/data/models/user_model.dart';
import 'package:chat_app/features/home/data/repos/home_repo.dart';
import 'package:chat_app/features/home/presentation/cubit/home_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeCubit extends Cubit<HomeState> {
  final HomeRepo homeRepo;
  HomeCubit(this.homeRepo) : super(HomeInitial());

  Future<void> loadAllUsers() async {
    emit(HomeLoading());
    try {
      final List<UserModel> users = await homeRepo.getAllUsers();
      emit(HomeUsersLoaded(users));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
}

/*
 Future<void> loadCurrentUser() async {
    emit(HomeLoading());
    try {
      final UserModel user = await homeRepo.getCurrentUser();
      emit(HomeLoaded(user));
    } catch (e) {
      emit(HomeError(e.toString()));
    }
  }
  
 */

import 'package:chat_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_app/features/home/presentation/cubit/home_state.dart';
import 'package:chat_app/features/home/presentation/widgets/chat_user_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    context.read<HomeCubit>().loadAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoading) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (state is HomeError) {
          return Scaffold(
            body: Center(
              child: Text(
                state.message,
                style: const TextStyle(color: Colors.red),
              ),
            ),
          );
        }

        if (state is HomeUsersLoaded) {
          final chatUsers = state.chatUsers;

          return Scaffold(
            appBar: AppBar(centerTitle: true, title: const Text('Chat App')),
            body: ListView.builder(
              itemCount: chatUsers.length,
              itemBuilder: (context, index) {
                return ChatUserItem(chatUser: chatUsers[index]);
              },
            ),
          );
        }

        return const Scaffold(body: SizedBox());
      },
    );
  }
}

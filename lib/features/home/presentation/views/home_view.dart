import 'package:chat_app/features/home/presentation/cubit/home_cubit.dart';
import 'package:chat_app/features/home/presentation/cubit/home_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

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

        if (state is HomeLoaded) {
          final user = state.user;

          return Scaffold(
            appBar: AppBar(centerTitle: true, title: const Text('Chat App')),
            body: Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const CircleAvatar(
                    radius: 50,
                    child: Icon(Icons.person, size: 50),
                  ),
                  const SizedBox(height: 20),

                  Text(
                    user.name,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),

                  const SizedBox(height: 8),

                  Text(
                    user.email,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),

                  const SizedBox(height: 16),

                  Card(
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        children: [
                          ListTile(
                            leading: const Icon(Icons.info_outline),
                            title: const Text("About"),
                            subtitle: Text(user.about),
                          ),
                          const Divider(),
                          ListTile(
                            leading: Icon(
                              user.isOnline
                                  ? Icons.circle
                                  : Icons.circle_outlined,
                              color: user.isOnline ? Colors.green : Colors.grey,
                            ),
                            title: Text(user.isOnline ? "Online" : "Offline"),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        }

        return const Scaffold(body: SizedBox());
      },
    );
  }
}

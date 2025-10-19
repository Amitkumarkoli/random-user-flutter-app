import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_user_app/presentation/screens/profile_detail_screen.dart';
import '../providers/user_provider.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(usersProvider);
    final countryFilter = ref.watch(countryFilterProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Profiles'),
        actions: [
          // Country filter dropdown (bonus)
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DropdownButton<String?>(
              value: countryFilter,
              hint: const Text('Filter by Country'),
              underline: const SizedBox(),
              dropdownColor: Theme.of(context).colorScheme.surface,
              style: TextStyle(color: Theme.of(context).colorScheme.onSurface),
              items: [
                const DropdownMenuItem(value: null, child: Text('All')),
                const DropdownMenuItem(
                    value: 'us', child: Text('United States')),
                const DropdownMenuItem(
                    value: 'gb', child: Text('United Kingdom')),
                const DropdownMenuItem(value: 'fr', child: Text('France')),
                const DropdownMenuItem(value: 'au', child: Text('Australia')),
              ],
              onChanged: (value) {
                ref.read(countryFilterProvider.notifier).state = value;
                ref.read(usersProvider.notifier).fetchUsers(isRefresh: true);
              },
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(usersProvider.notifier).fetchUsers(isRefresh: true),
        child: usersState.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error, _) => Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error: $error', style: const TextStyle(fontSize: 16)),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () => ref
                      .read(usersProvider.notifier)
                      .fetchUsers(isRefresh: true),
                  child: const Text('Retry'),
                ),
              ],
            ),
          ),
          data: (users) => GridView.builder(
            padding: const EdgeInsets.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  MediaQuery.of(context).size.width > 600 ? 4 : 2, // Responsive
              crossAxisSpacing: 8,
              mainAxisSpacing: 8,
              childAspectRatio: 0.75,
            ),
            itemCount: users.length,
            itemBuilder: (context, index) {
              final user = users[index];
              return Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)),
                elevation: 4,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileDetailScreen(
                                  pictureUrl: user.pictureUrl),
                            ),
                          );
                        },
                        child: ClipRRect(
                          borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(16)),
                          child: Image.network(
                            user.pictureUrl,
                            fit: BoxFit.cover,
                            width: double.infinity,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            '${user.firstName}, ${user.age}',
                            style: const TextStyle(
                                fontSize: 16, fontWeight: FontWeight.bold),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            user.city,
                            style: const TextStyle(fontSize: 14),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Icon(
                                  user.isLiked
                                      ? Icons.favorite
                                      : Icons.favorite_border,
                                  color: user.isLiked ? Colors.red : null,
                                )
                                    .animate(
                                      onPlay: (controller) =>
                                          controller.repeat(),
                                    )
                                    .scale(
                                        duration: 300.ms,
                                        curve: Curves.easeInOut),
                                onPressed: () => ref
                                    .read(usersProvider.notifier)
                                    .toggleLike(user.pictureUrl),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}

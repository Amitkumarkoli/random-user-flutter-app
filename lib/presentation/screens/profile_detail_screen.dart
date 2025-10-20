import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/models/user_model.dart';
import '../providers/user_provider.dart';

class ProfileDetailScreen extends ConsumerWidget {
  final String pictureUrl;

  const ProfileDetailScreen({super.key, required this.pictureUrl});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersState = ref.watch(usersProvider);
    final user =
        usersState.value?.firstWhere((u) => u.pictureUrl == pictureUrl);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          if (user != null)
            IconButton(
              icon: Icon(
                user.isLiked ? Icons.favorite : Icons.favorite_border,
                color: user.isLiked ? Colors.red : null,
              )
                  .animate(
                    onPlay: (controller) => controller.repeat(),
                  )
                  .scale(duration: 300.ms, curve: Curves.easeInOut),
              onPressed: () =>
                  ref.read(usersProvider.notifier).toggleLike(pictureUrl),
            ),
        ],
      ),
      body: user == null
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Column(
                children: [
                  Hero(
                    tag: user.pictureUrl,
                    child: ClipRRect(
                      borderRadius: const BorderRadius.vertical(
                          bottom: Radius.circular(16)),
                      child: CachedNetworkImage(
                        imageUrl: user.pictureUrl,
                        fit: BoxFit.cover,
                        width: double.infinity,
                        height: 300,
                        placeholder: (context, url) =>
                            const Center(child: CircularProgressIndicator()),
                        errorWidget: (context, url, error) => Container(
                          color: Colors.grey[300],
                          height: 300,
                          child:
                              const Center(child: Text('Image Failed to Load')),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          '${user.firstName}, ${user.age}',
                          style: const TextStyle(
                              fontSize: 24, fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'Location',
                          style:
                              TextStyle(fontSize: 16, color: Colors.grey[600]),
                        ),
                        Text(
                          user.city,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}

import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';

// Provide the UserRepository
final userRepositoryProvider = Provider<UserRepository>((ref) => UserRepositoryImpl());

// Provider for country filter (bonus feature)
final countryFilterProvider = StateProvider<String?>((ref) => null);

// Notifier to manage the list of users and their state
class UsersNotifier extends StateNotifier<AsyncValue<List<UserModel>>> {
  UsersNotifier(this._repository, this._ref) : super(const AsyncValue.loading()) {
    fetchUsers();
  }
  final UserRepository _repository;
  final Ref _ref;

  Future<void> fetchUsers({bool isRefresh = false}) async {
    if (isRefresh) state = const AsyncValue.loading();
    try {
      final country = _ref.read(countryFilterProvider);
      final users = await _repository.getUsers();
      state = AsyncValue.data(users);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void toggleLike(String pictureUrl) {
    final users = state.value ?? [];
    final updatedUsers = users.map((user) {
      if (user.pictureUrl == pictureUrl) {
        return UserModel(
          firstName: user.firstName,
          pictureUrl: user.pictureUrl,
          age: user.age,
          city: user.city,
          isLiked: !user.isLiked, // Toggle like status
        );
      }
      return user;
    }).toList();
    state = AsyncValue.data(updatedUsers);
  }
}

// Provide the UsersNotifier
final usersProvider = StateNotifierProvider<UsersNotifier, AsyncValue<List<UserModel>>>((ref) {
  final repository = ref.watch(userRepositoryProvider);
  return UsersNotifier(repository, ref);
});
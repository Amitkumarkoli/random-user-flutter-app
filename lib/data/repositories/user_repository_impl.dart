import '../../domain/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';
import '../datasources/remote_data_source.dart';

class UserRepositoryImpl implements UserRepository {
  final RemoteDataSource _dataSource;

  UserRepositoryImpl({RemoteDataSource? dataSource})
      : _dataSource = dataSource ?? RemoteDataSource();

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final jsonList = await _dataSource.fetchUsers();
      return jsonList.map((json) => UserModel.fromJson(json)).toList();
    } catch (e) {
      throw Exception('Repository error: $e');
    }
  }
}
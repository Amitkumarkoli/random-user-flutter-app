import 'package:dio/dio.dart';

class RemoteDataSource {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchUsers({String? country}) async {
    try {
      final url = country != null
          ? 'https://randomuser.me/api/?results=20&nat=$country'
          : 'https://randomuser.me/api/?results=20';
      final response = await _dio.get(url);
      return response.data['results'] as List<dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}
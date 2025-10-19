import 'package:dio/dio.dart';

class RemoteDataSource {
  final Dio _dio = Dio();

  Future<List<dynamic>> fetchUsers() async {
    try {
      final response = await _dio.get('https://randomuser.me/api/?results=20');
      return response.data['results'] as List<dynamic>;
    } catch (e) {
      throw Exception('Failed to fetch users: $e');
    }
  }
}
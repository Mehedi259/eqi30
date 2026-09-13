import '../network/api_client.dart';

class ResourceService {
  final ApiClient _apiClient = ApiClient();

  Future<List<dynamic>> fetchResources({
    String? category,
    String? type,
    bool? isFeatured,
  }) async {
    try {
      final queryParams = <String>[];
      if (category != null) queryParams.add('category=$category');
      if (type != null) queryParams.add('type=$type');
      if (isFeatured != null) queryParams.add('is_featured=$isFeatured');

      final queryString = queryParams.isNotEmpty ? '?${queryParams.join('&')}' : '';
      final response = await _apiClient.get('/resources/$queryString');

      if (response != null) {
        if (response is List) {
          return response;
        } else if (response is Map && response['results'] != null) {
          return response['results'];
        }
      }
      return [];
    } catch (e) {
      print('Error fetching resources: $e');
      return [];
    }
  }
}

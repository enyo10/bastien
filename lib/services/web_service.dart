
import 'package:bastien/utils/movie_resource.dart';
import 'package:http/http.dart' as http;

class Webservice {
  Future<T> load<T>(MovieResource<T> resource) async {
    final response = await http.get(resource.url);
    if (response.statusCode == 200) {
      return resource.parse(response);
    } else {
      throw Exception('Failed to load data!');
    }
  }



}

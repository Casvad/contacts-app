
import 'package:flutter_dotenv/flutter_dotenv.dart';

class HttpClient {
  final String baseUrl = dotenv.env['API_HOST'] ?? '';
}
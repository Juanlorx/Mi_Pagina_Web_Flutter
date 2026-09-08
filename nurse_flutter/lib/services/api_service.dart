import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'https://nurse.redmoss-24d4a40e.chilecentral.azurecontainerapps.io';

  static Future<List<dynamic>> obtenerPacientes() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/pacientes'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener pacientes');
    }
  }

  static Future<List<dynamic>> obtenerHorarios() async {
    final response = await http.get(
      Uri.parse('$baseUrl/api/horarios'),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Error al obtener horarios');
    }
  }
}
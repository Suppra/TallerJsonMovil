import 'dart:convert';
import 'package:http/http.dart' as http;
import 'user.dart';

void main() async {
  // URL de la API
  final url = Uri.parse('https://jsonplaceholder.typicode.com/users');
  try {
    // Realizar la petición GET
    final response = await http.get(url);
    // Verificar si la petición fue exitosa
    if (response.statusCode == 200) {
      // Parsear la respuesta JSON a una lista
      List<dynamic> jsonData = json.decode(response.body);
      // Crear una lista de usuarios
      List<User> users = jsonData.map((user) => User.fromJson(user)).toList();
      // Filtrar y mostrar usuarios con username > 6 caracteres
      print("Usuarios con username > 6 caracteres:");
      showUsersWithLongUsername(users);
      // Contar y mostrar usuarios con email @biz

      int bizUsersCount = countBizUsers(users);
      print("Cantidad de usuarios con email .biz: $bizUsersCount");
    } else {
      throw Exception('Error en la solicitud HTTP: ${response.statusCode}');
    }
  } catch (e) {
    print('Error: $e');
  }
}

// Función para mostrar usuarios con username > 6 caracteres
void showUsersWithLongUsername(List<User> users) {
  users.where((user) => user.username.length > 6).forEach((user) {
    print('${user.name} (${user.username})');
  });
}

// Función para contar usuarios con email @biz
int countBizUsers(List<User> users) {
  return users.where((user) => user.email.endsWith('.biz')).length;
}

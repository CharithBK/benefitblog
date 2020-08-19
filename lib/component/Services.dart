import 'dart:convert';
import 'package:benefitblog/component/Users.dart';
import 'package:http/http.dart' as http;

class Services {
  //CRUD Operations

  //update user details
  static Future<String> updateUser(
    String _id,
    String _name,
    String _email,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map["id"] = _id;
      map["name"] = _name;
      map["email"] = _email;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
          'https://etrendsapp.000webhostapp.com/fiverr/update.php',
          headers: headers,
          body: data);
      //print('updateUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //user login
  static Future<String> loginUser(
    String _email,
    String _password,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map["email"] = _email;
      map["password"] = _password;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
          'https://etrendsapp.000webhostapp.com/fiverr/login.php',
          headers: headers,
          body: data);
      //print('loginUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }

  //get the user details and it return to Users Profile
  static Future<List<User>> getUserDetails()
  async {
    try {
      final response = await http
          .post("https://etrendsapp.000webhostapp.com/fiverr/users.php");
      if (200 == response.statusCode) {
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>(); // return an empty list on exception/error
    }
  }

  //get all user details of user details table
  static Future<List<User>> getUsers() async {
    try {
      final response = await http
          .post("https://etrendsapp.000webhostapp.com/fiverr/users.php");
      if (200 == response.statusCode) {
        List<User> list = parseResponse(response.body);
        return list;
      } else {
        return List<User>();
      }
    } catch (e) {
      return List<User>(); // return an empty list on exception/error
    }
  }
   static List<User> parseResponse(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    return parsed.map<User>((json) => User.fromJson(json)).toList();
  }
//delete the user from the table
  static Future<String> deleteUser(String id)
  async {
    try {
      var map = Map<String, dynamic>();
      map["id"] = id;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
          'https://etrendsapp.000webhostapp.com/fiverr/delete.php',
          headers: headers,
          body: data);
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error"; // returning just an "error" string to keep this simple...
    }
  }

  //Add a new user
  static Future<String> addUser(
    String _name,
    String _email,
    String _password,
  ) async {
    try {
      var map = Map<String, dynamic>();
      map["name"] = _name;
      map["email"] = _email;
      map["password"] = _password;
      final data = json.encode(map);
      Map<String, String> headers = {"Content-type": "application/json"};
      final response = await http.post(
          'https://etrendsapp.000webhostapp.com/fiverr/register.php',
          headers: headers,
          body: data);
      //print('addUser Response: ${response.body}');
      if (200 == response.statusCode) {
        return response.body;
      } else {
        return "error";
      }
    } catch (e) {
      return "error";
    }
  }
}

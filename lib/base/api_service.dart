import 'dart:async';
import 'dart:convert';
import 'dart:developer'; // For logging
import 'package:flutter/material.dart';
import 'package:home/constants/secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:connectivity_plus/connectivity_plus.dart';

import '../utils/toast_utils.dart';

// StreamController to notify unauthorized access
final StreamController<void> unauthorizedStream =
    StreamController<void>.broadcast();

class ApiService {
  final String baseUrl;

  ApiService({required this.baseUrl});

  // Check Internet Connectivity
  Future<bool> hasInternetConnection() async {
    final connectivityResult = await Connectivity().checkConnectivity();
    return !connectivityResult.contains(ConnectivityResult.none);
  }

  // General GET request with query parameters
  Future<dynamic> get(String endpoint,
      {Map<String, String>? headers,
      Map<String, dynamic>? queryParameters}) async {
    return _makeRequest(
      method: 'GET',
      endpoint: endpoint,
      headers: headers,
      queryParameters: queryParameters,
    );
  }

  // General POST request
  Future<dynamic> post(String endpoint,
      {Map<String, String>? headers, dynamic body}) async {
    return _makeRequest(
      method: 'POST',
      endpoint: endpoint,
      headers: headers,
      body: body,
    );
  }

  // Private method to handle all API requests
  Future<dynamic> _makeRequest({
    required String method,
    required String endpoint,
    Map<String, String>? headers,
    Map<String, dynamic>? queryParameters,
    dynamic body,
  }) async {
    // Check for internet connectivity
    if (!await hasInternetConnection()) {
      ToastUtils.showError(
          "No internet connection. Please check your network.");
      return;
    }

    // Build URL with query parameters
    final uri = Uri.parse('$baseUrl$endpoint')
        .replace(queryParameters: queryParameters);

    headers = headers ?? {'Content-Type': 'application/json'};
    final token = await getToken();
    if (token != null && token.isNotEmpty) {
      headers['Authorization'] = 'Bearer $token';
    }

    log('Request [$method] $uri'); // Log request URL
    if (body != null) {
      log('Request Body: ${jsonEncode(body)}'); // Log body if applicable
    }

    http.Response response;

    try {
      switch (method) {
        case 'GET':
          response = await http.get(uri, headers: headers);
          break;
        case 'POST':
          response =
              await http.post(uri, headers: headers, body: jsonEncode(body));
          break;
        default:
          throw Exception('Unsupported HTTP method: $method');
      }

      log('Response Status: ${response.statusCode}'); // Log status code
      log('Response Body: ${response.body}'); // Log response body

      return _handleResponse(response);
    } catch (e) {
      log('Error: $e'); // Log error
      ToastUtils.showError('Error: ${e.toString()}'); // Show error toast
      throw Exception('API request failed: $e');
    }
  }

  // Handle HTTP responses
  dynamic _handleResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      if (response.body.isNotEmpty) {
        return jsonDecode(response.body);
      }
      return null;
    }
    // else if (response.statusCode == 401) {
    //   // Handle Unauthorized Error (401)
    //   // Perform logout or token invalidation
    //   _handleUnauthorized();
    //   throw Exception('Unauthorized access. Please log in again.');
    // }
    else {
      // Handle other errors
      throw Exception('Error: ${response.statusCode} - ${response.body}');
    }
  }

  // Handle unauthorized access (e.g., logout)
  void _handleUnauthorized() async {
    // Clear stored tokens or credentials
    setToken(null);

    // Navigate to login screen
    // Navigator.pushNamedAndRemoveUntil(
    //   navigatorKey.currentContext!,
    //   '/login',
    //       (route) => false, // Remove all previous routes
    // );

    // Broadcast the unauthorized event
    unauthorizedStream.add(null);

    // Optionally, show a toast message
    ToastUtils.showError('Session expired. Please log in again.');
  }
}

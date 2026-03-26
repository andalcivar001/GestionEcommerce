import 'dart:convert';

import 'package:ecommerce_prueba/src/data/api/ApiConfig.dart';
import 'package:ecommerce_prueba/src/domain/models/OrderPayment.dart';
import 'package:ecommerce_prueba/src/domain/utils/ListToString.dart';
import 'package:ecommerce_prueba/src/domain/utils/Resource.dart';
import 'package:http/http.dart' as http;

class OrderPaymentService {
  Future<String> token;

  OrderPaymentService(this.token);

  Future<Resource<List<OrderPayment>>> getOrderPaymentByOrden(
    String idOrden,
  ) async {
    try {
      Uri url = Uri.parse(
        '${Apiconfig.API_ECOMMERCE}/payment-order/order/$idOrden',
      );
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        List<OrderPayment> orderResponse = OrderPayment.fromJsonList(data);
        return Success(orderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<OrderPayment>> getOrderPaymentById(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/payment-order/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.get(url, headers: headers);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        OrderPayment orderResponse = OrderPayment.fromJson(data);
        return Success(orderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<OrderPayment>> create(OrderPayment orderPayment) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/payment-order');

      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };
      String body = json.encode(orderPayment.toJson());
      final response = await http.post(url, headers: headers, body: body);
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        OrderPayment orderResponse = OrderPayment.fromJson(data);
        return Success(orderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<OrderPayment>> update(
    OrderPayment orderPayment,
    String id,
  ) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/payment-order/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      //final response = await http.put(url, headers: headers, body: order);
      final response = await http.put(
        url,
        headers: headers,
        body: json.encode(orderPayment.toJson()),
      );
      final data = json.decode(response.body);
      if (response.statusCode == 201 || response.statusCode == 200) {
        OrderPayment orderResponse = OrderPayment.fromJson(data);
        return Success(orderResponse);
      } else {
        return Error(listToString(data['message']));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }

  Future<Resource<bool>> delete(String id) async {
    try {
      Uri url = Uri.parse('${Apiconfig.API_ECOMMERCE}/payment-order/$id');
      Map<String, String> headers = {
        "Content-Type": "application/json",
        "Authorization": await token,
      };

      final response = await http.delete(url, headers: headers);
      final data = json.decode(response.body);

      if (response.statusCode == 201 || response.statusCode == 200) {
        bool deletedResponse = data as bool;
        return Success(deletedResponse);
      } else {
        return Error(listToString(data));
      }
    } catch (e) {
      return Error(e.toString());
    }
  }
}

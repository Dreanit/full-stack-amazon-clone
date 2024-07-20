import 'dart:convert';
import 'dart:io';

import 'package:amazon_clone/constants/global_variables.dart';
import 'package:amazon_clone/helpers/ServiceHelpers/apiHelper.dart';
import 'package:amazon_clone/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../../../helpers/ServiceHelpers/apiResponse.dart';
import '../../../models/product.dart';

class SearchService {
  ApiHelper helper = ApiHelper();

  Future<List<Product>> getSearchedProduct(
      BuildContext context, String searchQuery) async {
    List<Product> dataList = [];
    final user = Provider.of<UserProvider>(context, listen: false);
    Uri uri = Uri.http(baseUrl, "/api/products/search/$searchQuery");
    final response = await http.get(
      uri,
      headers: {
        HttpHeaders.contentTypeHeader: 'application/json',
        'x-auth-token': user.user.token
      },
    );
    for (var json in jsonDecode(response.body)) {
      Product value = Product.fromMap(json);
      dataList.add(value);
    }
    return dataList;
  }
}

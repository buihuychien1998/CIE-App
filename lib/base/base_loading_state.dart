import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'api_service.dart';
import 'api_url.dart';

mixin BaseLoadingState<T extends StatefulWidget> on State<T> {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  final apiService = ApiService(baseUrl: ApiUrl.baseUrl);

  void showLoading() {
    print("showLoading");
    setState(() {
      _isLoading = true;
    });
  }

  void hideLoading() {
    print("hideLoading");
    setState(() {
      _isLoading = false;
    });
  }

  Widget buildWithLoading({required Widget child}) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Stack(
        children: [
          child,
          if (_isLoading)
            Container(
              width: double.infinity,
              height: double.infinity,
              alignment: Alignment.center,
              // color: Colors.black26,
              child: Container(
                // width: 80.0,
                // height: 80.0,
                // decoration: BoxDecoration(
                //   color: Colors.black87,
                //   borderRadius: BorderRadius.circular(12.0),
                // ),
                padding: const EdgeInsets.all(32.0),
                child: CupertinoActivityIndicator(
                  radius: 14,
                  // color: Colors.black87,
                ),
              ),
            ),
        ],
      ),
    );
  }
}



import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

void showAlert(BuildContext context, String title, String message){
  if(Platform.isAndroid){
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
      ),
    );
  } else{
    showCupertinoDialog(
      context: context, 
      builder: (context) => CupertinoAlertDialog(
        title: Text(title),
        content: CupertinoActivityIndicator(),//Text(message),
      ),
    );
  }
}
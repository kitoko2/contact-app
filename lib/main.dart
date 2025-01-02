import 'package:contact_app/core/app.dart';
import 'package:contact_app/core/di.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Initialize dependencies
  await Di.init();
  runApp(const MyApp());
}

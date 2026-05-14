import 'package:flutter/material.dart';
import 'features/home/home_page.dart';
import 'api_service.dart';

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  var resultado = await ApiService.login(
    "aluno",
    "demetrius@aluno.cps.gov.br",
    "123",
  );

  print(resultado);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meu App',
      home: const HomePage(),
    );
  }
}
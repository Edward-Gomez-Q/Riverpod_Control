import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  Future<String> _loadNewImage() async {
    String url='';
    final response = await http.get(Uri.parse('https://dog.ceo/api/breeds/image/random'));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      url = jsonResponse['message'];
    } else {
      url='';
    }
    return url;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Random Dog Image',
            ),
            FutureBuilder(
              future: _loadNewImage(),
              builder: (context, snapshot) {
                if(snapshot.data==null)
                {
                  return const SizedBox(height: 200,width: 200);
                }
                else
                {
                  return Image.network(snapshot.data!, fit: BoxFit.cover,width: 200,height: 200,);
                }
            },),
            ElevatedButton(onPressed: () {
              setState(() {
                _loadNewImage();
              });
            }, child: const Text('Cargar nueva Imagen')),
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

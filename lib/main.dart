import 'package:flutter/material.dart';

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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'CIS 3334 Weather App'),
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
  Widget weatherTile (int position) {
    print ("Inside weatherTile and setting up tile for positon ${position}");
    return ListTile(
      leading: Image(image: AssetImage('graphics/sun.png')),
      title: Text("Title Here"),
      subtitle: Text("Subtitle Here"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: ListView.builder(
        itemCount: 4,
        itemBuilder: (BuildContext context, int position) {
          return Card(
            child: weatherTile(position),
          );
        },
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
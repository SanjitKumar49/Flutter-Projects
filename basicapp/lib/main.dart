// import 'package:basicapp/second_page.dart';
// import 'package:flutter/material.dart';
//
// import 'package:http/http.dart' as http;
//
//
// import 'home_page.dart';
//
// void main() {
//   runApp(MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Hello Sanjit',
//       //  home: MyHomePage(),
//       debugShowCheckedModeBanner: false,
//       home: HomePage(),
//     );
//   }
// }
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   final TextEditingController _controller = TextEditingController();
//   String _displayText = 'Hello, Flutter!';
//
//   void _updateText() {
//     setState(() {
//       _displayText = _controller.text;
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Hello Flutter '),
//       ),
//       body: Center(
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           children: [
//             Text(
//               _displayText,
//               style: TextStyle(fontSize: 24),
//             ),
//             TextButton(
//               child: Text('Go Second Page'),
//               onPressed: () {
//                 Navigator.push(
//                   context,
//                   MaterialPageRoute(builder: (context) => SecondPage()),
//                 );
//                 // Do some operation
//               },
//             ),
//             TextField(
//               controller: _controller,
//               decoration: InputDecoration(
//                 labelText: 'Enter text',
//               ),
//             ),
//             TextButton(
//               child: Text("Update Text"),
//               onPressed: _updateText,
//             ),
//             // Image.asset('assets/computer.png'),
//             const Image(
//               image: NetworkImage(
//                   'https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg'),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }

/* List View 1... 1000*/

import 'package:basicapp/second_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() {
  runApp(
    MyApp(
      items: List<String>.generate(10000, (i) => 'Item $i'),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<String> items;

  const MyApp({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    const title = 'Long List';

    return MaterialApp(
      title: title,
      home: Scaffold(
        appBar: AppBar(
          title: const Text(title),
        ),
        body: Center(
          // child: Column(children: <Widget>[

          /*
            ListTile(
              leading: Icon(Icons.map),
              title: Text('Map'),
              onTap: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Map clicked'),
                    duration: Duration(seconds: 1),
                  ),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.circle),
              title: Text('Circle'),
            )

             */

          //     ]

          // itemCount: items.length,
          // prototypeItem: ListTile(
          //   title: Text(items.first),
          // ),
          // itemBuilder: (context, index) {
          //   return ListTile(
          //     title: Text(items[index]),
          //   );
          // },
        ),
      ),
    );
  }
}


// import 'dart:async';
// import 'package:flutter/material.dart';
//
// import 'ApiResponse/fetchAlbum.dart';
// import 'DataClass/Album.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});
//
//   @override
//   State<MyApp> createState() => _MyAppState();
// }
//
// class _MyAppState extends State<MyApp> {
//   late Future<Album> futureAlbum;
//
//   @override
//   void initState() {
//     super.initState();
//     futureAlbum = fetchAlbum();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Fetch Data Example',
//       theme: ThemeData(
//         colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
//       ),
//
//
//
//       home: Scaffold(
//         appBar: AppBar(
//           title: const Text('Fetch Data Example'),
//         ),
//         body: Center(
//           child: FutureBuilder<Album>(
//             future: futureAlbum,
//             builder: (context, snapshot) {
//               if (snapshot.hasData) {
//                 return Text(snapshot.data!.title);
//               } else if (snapshot.hasError) {
//                 return Text('${snapshot.error}');
//               }
//
//               // By default, show a loading spinner.
//               return const CircularProgressIndicator();
//             },
//           ),
//         ),
//       ),
//     );
//   }
// }

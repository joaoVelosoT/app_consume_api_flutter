import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  String title = "";
  String price = "";
  String description = "";
  String category = "";
  String image = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/HD_transparent_picture.png/1280px-HD_transparent_picture.png";
  void _getData(int id) async {
    setState(() {
      _counter++;
    });

    if (_counter == 0 || _counter > 20) {
      print("Não existe nenhum produto 0, ou maior que 20");
    } else {
      var url = Uri.https('fakestoreapi.com',
          '/products/' + _counter.toString(), {'q': '{https}'});

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as Map<String, dynamic>;

        var titleJson = jsonResponse['title'];
        var priceJson = jsonResponse['price'];
        var descriptionJson = jsonResponse['description'];
        var categoryJson = jsonResponse['category'];
        var imageJson = jsonResponse['image'];

        // print(imageJson);
        setState(() {
          title = titleJson;
          price = priceJson.toString();
          description = descriptionJson;
          category = categoryJson;
          image = imageJson;
        });
        print('Nome Produto: $title.');
      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
    }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            ElevatedButton(
                onPressed: () {
                  setState(() {
                    _counter = 0;
                    setState(() {
                      title = "";
                      price = "";
                      description = "";
                      category = "";
                      image = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/HD_transparent_picture.png/1280px-HD_transparent_picture.png";
                    });
                  });
                },
                child: Text("Zerar")),

            Container(
              margin: EdgeInsets.all(20),
              decoration: BoxDecoration(
                border: Border.all(width: 1)
              ),
              child: Column(
                children: [
                  Image.network(image, width: 100,),
                  Text(title),
                  Text(price),
              Text(description),
              Text(category)
              
                ],
              ),
            ),
            
            
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _getData(0);
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

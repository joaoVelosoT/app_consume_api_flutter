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
  var allProducts = [];
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

  void limparTudo() {
    setState(() {
                    _counter = 0;
                      title = "";
                      price = "";
                      description = "";
                      category = "";
                      image = "https://upload.wikimedia.org/wikipedia/commons/thumb/8/89/HD_transparent_picture.png/1280px-HD_transparent_picture.png";
                   
                  });
  }


  

  @override
  void getAll()async {
    var url = Uri.https('fakestoreapi.com','/products',{'q': '{https}'});

    var response = await http.get(url);

    if (response.statusCode == 200) {
        var jsonResponse =
            convert.jsonDecode(response.body) as List<dynamic>;

        var array = jsonResponse;

        array.forEach((produto) {

          // print(produto['title']);
          setState(() {
            allProducts.add({
            title : produto['title'],
            price : produto['price'],
            description : produto['description'],
            category : produto['category'],
            image : produto['image']
          });
          });
          
        });

      // print("array quantidade" + allProducts.length.toString());
        
        limparTudo();
         ListView.builder(
              itemCount: allProducts.length,
              itemBuilder: (context, index) {
                final product = allProducts[index];
                if(!allProducts.isEmpty){
                     return const Column(
                  children: [
                    Text("data")
                  ],
                );
                }
               

            });

      } else {
        print('Request failed with status: ${response.statusCode}.');
      }
  }

  
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
                  limparTudo();
                },
                child: const Text("Zerar")),
                ElevatedButton(onPressed: (){







                    // Text("data");

                  // funcao mostrar todas 
                  getAll();

                  // print("array quantidade" + allProducts.length.toString());












                  
                }, child: Text("Mostrar todas")),
  

  

           
            









            // Container(
            //   margin: EdgeInsets.all(20),
            //   decoration: BoxDecoration(
            //     border: Border.all(width: 1)
            //   ),
            //   child: Column(
            //     children: [
            //       Image.network(image, width: 100,),
            //       Text(title),
            //       Text(price),
            //   Text(description),
            //   Text(category)
              
            //     ],
            //   ),
            // ),
            
            
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

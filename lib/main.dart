import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'models/item.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  var items = new List<Item>();
  HomePage() {
    items = [];
    // items.add(Item(title: 'Item 1', done: false));
    // items.add(Item(title: 'Item 2', done: true));
  }
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  _HomePageState() {
    load();
  }
  var newTaskController = TextEditingController();

  void add() {
    if (newTaskController.text.isEmpty) return;
    print('Entrou no add');
    setState(() {
      widget.items.add(
        Item(
          title: newTaskController.text,
          done: false,
        ),
      );
      save();
      newTaskController.text = '';
    });
  }

  void remove(int index) {
    print('Remove' + index.toString());
    setState(() {
      widget.items.removeAt(index);
      save();
    });
  }

  Future load() async {
    print('LOAD 1');
    var prefs = await SharedPreferences.getInstance();
    print('LOAD 2');
    var data = prefs.getString('data');
    print('LOAD 3');
    if (data != null) {
      print('LOAD 4');
      Iterable decoded = jsonDecode(data);
      print('LOAD 5');
      List<Item> result = decoded.map((x) => Item.fromJson(x)).toList();
      print('LOAD 6');
      setState(() {
        widget.items = result;
      });
      print('LOAD 7');
    }
  }

  save() async {
    var prefs = await SharedPreferences.getInstance();
    print('save ' + widget.items.toString());
    await prefs.setString('data', jsonEncode(widget.items));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextFormField(
          controller: newTaskController,
          keyboardType: TextInputType.text,
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
          decoration: InputDecoration(
              labelText: "Nova Tarefa",
              labelStyle: TextStyle(
                color: Colors.white,
              )),
        ),
      ),
      body: ListView.builder(
        itemCount: widget.items.length,
        itemBuilder: (BuildContext ctx, int index) {
          final item = widget.items[index];
          return Center(
            child: Dismissible(
              key: Key(item.title),
              child: CheckboxListTile(
                title: Text(item.title),
                value: item.done,
                onChanged: (value) {
                  setState(() {
                    item.done = value;
                    save();
                  });
                },
              ),
              background: Container(
                color: Colors.red.withOpacity(0.4),
              ),
              onDismissed: (direction) {
                if (direction == DismissDirection.endToStart) {
                  remove(index);
                }
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: add,
        child: Icon(Icons.add),
        backgroundColor: Colors.pink,
      ),
    );
  }
}

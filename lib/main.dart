import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home:ShoppingList(),
    );
  }
}

class Item {
  String id;
  String name;
  Item({required this.id, required this.name});
}

class ShoppingList extends StatefulWidget {
  const ShoppingList({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() {
     return _ShoppingListState();
  }
}

class _ShoppingListState extends State<ShoppingList>{

  final Item _shoppingItem  = Item(id: '1', name: 'milk');
  bool _isClick = false;

void handleClick(){
    setState(() {
      _isClick = !_isClick;
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(title: Text("Shopping Cart App"),),
      body: ListView(
        children: [
          ListItem(
            item: _shoppingItem,
            inCart: _isClick,
            callback: handleClick,
          )
        ],
      ),
    );
  }

}



typedef CartChangedCallback = Function();

//用此class 決定畫面要如何顯示。 注意 inCart、tap Function 都是final。 其原因就是他只負責抓到別人給的值，然後顯示或是執行。
class ListItem extends StatelessWidget {
  final bool inCart;
  final Item item;
  final CartChangedCallback callback;

  ListItem({required this.inCart, required this.item, required this.callback});
  Color _getColor(BuildContext context) {
    // The theme depends on the BuildContext because different
    // parts of the tree can have different themes.
    // The BuildContext indicates where the build is
    // taking place and therefore which theme to use.
    return inCart //
        ? Colors.black54
        : Theme.of(context).primaryColor;
  }

  TextStyle? _getTextStyle(BuildContext context) {
    if (!inCart) return null;

    return const TextStyle(
      color: Colors.black54,
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListTile(
      onTap: () {
        callback();
      },
      leading: CircleAvatar(
        backgroundColor: _getColor(context),
        child: Text(item.name[0].toUpperCase()),
      ),
      title: Text(
        item.name,
        style: _getTextStyle(context),
      ),
    );
  }
}

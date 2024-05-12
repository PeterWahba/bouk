import 'package:flutter/material.dart';

class BasketShoppingScreen extends StatefulWidget {
  @override
  _ShoppingCartState createState() => _ShoppingCartState();
}

class _ShoppingCartState extends State<BasketShoppingScreen> {
  List<String> items = ['منتج 1', 'منتج 2', 'منتج 3']; // قائمة المنتجات في سلة التسوق

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('سلة التسوق'),
      ),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text(items[index]),
            trailing: IconButton(
              icon: Icon(Icons.remove_circle),
              onPressed: () {
                setState(() {
                  items.removeAt(index); // حذف المنتج عند الضغط على الزر
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          // يمكنك هنا إضافة منتج جديد إلى سلة التسوق
          setState(() {
            items.add('منتج جديد');
          });
        },
      ),
    );
  }
}

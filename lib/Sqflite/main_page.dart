import 'package:flutter/material.dart';
import 'package:storage2/Sqflite/sqloperations.dart';

void main() {
  runApp(MaterialApp(
    home: HomeStorage(),
    debugShowCheckedModeBanner: false,
    theme: ThemeData(primarySwatch: Colors.orange),
  ));
}

class HomeStorage extends StatefulWidget {
  @override
  State<HomeStorage> createState() => _HomeStorageState();
}

class _HomeStorageState extends State<HomeStorage> {
  bool isloading = true;
  List<Map<String, dynamic>> datas = [];

  void refreshdata() async {
    final data = await SqlHelper.getItems();
    setState(() {
      datas = data;
      isloading = false;
    });
  }

  @override
  void initState() {
    refreshdata();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sqflite"),
      ),
      body: isloading
          ? CircularProgressIndicator()
          : ListView.builder(itemBuilder: (context, int) {
              return Card(
                child: ListTile(
                  title: Text(""),
                  subtitle: Text(""),
                ),
              );
            }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showform(null),
        child: Icon(Icons.add),
      ),
    );
  }

  final title_controller = TextEditingController();
  final description_controller = TextEditingController();

  void showform(int? id) async {
    if (id != null) {
      //id == null create new id != null update
      final existing_data = datas.firstWhere((element) => element[id] == id);
      title_controller.text = existing_data['title'];
      description_controller.text = existing_data['description'];
    }
    showModalBottomSheet(
      context: context,
      elevation: 5,
      isScrollControlled: true,
      builder: (context) => Container(
        padding: EdgeInsets.only(
            left: 15,
            right: 15,
            top: 15,
            bottom: MediaQuery.of(context).viewInsets.bottom + 100),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            TextField(
              controller: title_controller,
              decoration: InputDecoration(hintText: "Title"),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: description_controller,
              decoration: InputDecoration(hintText: "Description"),
            ),
            SizedBox(
              height: 10,
            ),
            ElevatedButton(
                onPressed: () async {
                  if (id == null) {
                    await createItem();
                  }
                  if (id != null) {
                    //await updateItem();
                  }
                  title_controller.text = '';
                  description_controller.clear();
                  Navigator.of(context).pop();
                },
                child: Text(id == null ? 'Create new' : "Update"))
          ],
        ),
      ),
    );
  }

  Future<void> createItem() async {
    await SqlHelper.create_item(
        title_controller.text, description_controller.text);
    refreshdata();
  }
}

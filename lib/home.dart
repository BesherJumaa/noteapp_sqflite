import 'package:flutter/material.dart';
import 'package:noteapp_sqflite/addnotes.dart';
import 'package:noteapp_sqflite/animationroute.dart';

import 'package:noteapp_sqflite/sqldb.dart';

import 'editnotes.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  _HomeState createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  double total = 0.0;
  bool isloading = true;
  SqlDb sqlDb = SqlDb();
  List notes = [];
  Future readData() async {
    List<Map> response = await sqlDb.readData("SELECT * FROM notes");
    notes.addAll(response);
    // total = (getTotal());
    isloading = false;
    if (this.mounted) {
      setState(() {});
    }
  }

  double getTotal() {
    double response = sqlDb.readData("SELECT SUM(note) FROM notes");
    return response;
  }

  @override
  void initState() {
    readData();
    super.initState();
  }

  void updateAll(int oldIndex, int newIndex) {
    if (newIndex > oldIndex) {
      newIndex -= 1;
    }
    final note = notes.removeAt(oldIndex);
    notes.insert(newIndex, note);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    print(total);
    return Scaffold(
      appBar: AppBar(title: Text("Total is : ${total}"), actions: [
        IconButton(
            onPressed: () async {
              int response = await sqlDb.deleteDatabases();
              print("================");
              print(response);
            },
            icon: Icon(Icons.delete_outline_outlined))
      ]),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            SlideRight(Page: const AddNotes()),
          );
        },
        child: const Icon(Icons.add),
      ),
      body: isloading == true
          ? const Center(child: LinearProgressIndicator())
          : ReorderableListView(
              onReorder: (oldIndex, newIndex) async {
                updateAll(oldIndex, newIndex);

                setState(() {});
              },
              children: notes
                  .map(
                    (note) => Dismissible(
                      onDismissed: (direction) async {
                        int response =
                            await sqlDb.delete("notes", "id = ${note['id']}");
                        if (response > 0) {
                          notes.removeWhere(
                              (element) => element['id'] == note['id']);
                          setState(() {});
                        }
                      },
                      key: ValueKey(note),
                      child: Card(
                        child: ListTile(
                          title: Text("${note['title']}"),
                          subtitle: Text("${note['note']}"),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                "${note['color']}",
                                style: TextStyle(color: Colors.grey.shade700),
                              ),
                              IconButton(
                                onPressed: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => EditNotes(
                                        color: note['color'],
                                        title: note['title'],
                                        id: note['id'],
                                        notes: note['note'],
                                      ),
                                    ),
                                  );
                                },
                                icon: Icon(
                                  Icons.edit,
                                  color: Colors.green[400],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                  .toList(),
            ),
    );
  }
}

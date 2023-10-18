import 'package:flutter/material.dart';
import 'package:noteapp_sqflite/home.dart';
import 'package:noteapp_sqflite/sqldb.dart';
import 'package:noteapp_sqflite/widgets/customtextform.dart';

class AddNotes extends StatefulWidget {
  const AddNotes({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddNotesState createState() {
    return _AddNotesState();
  }
}

class _AddNotesState extends State<AddNotes> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController title = TextEditingController();
  SqlDb sqlDb = SqlDb();
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: Container(
        padding: const EdgeInsets.all(15),
        child: ListView(
          children: [
            Form(
                key: formstate,
                child: Column(
                  children: [
                    AuthTextFormField(
                      textBox: 'title',
                      hintText: 'Enter title ',
                      controller: title,
                      iconPrefix: Icons.title_outlined,
                    ),
                    AuthTextFormField(
                      keyboardType: TextInputType.number,
                      textBox: 'note',
                      hintText: 'Enter note ',
                      controller: note,
                      iconPrefix: Icons.note_add_outlined,
                    ),
                    AuthTextFormField(
                      textBox: 'Overview',
                      hintText: 'Write Your Overview ',
                      controller: color,
                      iconPrefix: Icons.info_outline,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        // int response = await sqlDb.insertData('''
                        // INSERT INTO notes (`note`,`title`,`color`)
                        // VALUES ("${note.text}" ,"${title.text}", "${color.text}")
                        // ''');
                        int response = await sqlDb.insert("notes", {
                          "note": note.text,
                          "title": title.text,
                          "color": color.text,
                        });
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        }

                        print("Response=====================");
                        print(response);
                      },
                      color: Colors.green,
                      child: const Text("Add Notes"),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

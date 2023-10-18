import 'package:flutter/material.dart';
import 'package:noteapp_sqflite/home.dart';
import 'package:noteapp_sqflite/sqldb.dart';
import 'package:noteapp_sqflite/widgets/customtextform.dart';

class EditNotes extends StatefulWidget {
  const EditNotes({super.key, this.notes, this.title, this.id, this.color});
  final notes;
  final title;
  final color;
  final id;
  @override
  // ignore: library_private_types_in_public_api
  _EditNotesState createState() {
    return _EditNotesState();
  }
}

class _EditNotesState extends State<EditNotes> {
  GlobalKey<FormState> formstate = GlobalKey<FormState>();
  TextEditingController note = TextEditingController();
  TextEditingController color = TextEditingController();
  TextEditingController title = TextEditingController();
  SqlDb sqlDb = SqlDb();
  @override
  void initState() {
    note.text = widget.notes;
    title.text = widget.title;
    color.text = widget.color;

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
                      textBox: 'overview',
                      hintText: 'Write Your Overview ',
                      controller: color,
                      iconPrefix: Icons.info_outline,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    MaterialButton(
                      onPressed: () async {
                        //  int response = await sqlDb.updateData('''
                        // UPDATE notes SET
                        //  note = "${note.text}",
                        //  title = "${title.text}",
                        //  color = "${color.text}",
                        //  WHERE id=${widget.id}
                        // ''');
                        int response = await sqlDb.update(
                            "notes",
                            {
                              "note": note.text,
                              "title": title.text,
                              "color": color.text,
                            },
                            "id = ${widget.id}");
                        if (response > 0) {
                          Navigator.of(context).pushAndRemoveUntil(
                              MaterialPageRoute(builder: (context) => Home()),
                              (route) => false);
                        }

                        print("Response=====================");
                        print(response);
                      },
                      color: Colors.green,
                      child: const Text("Edit Notes"),
                    )
                  ],
                ))
          ],
        ),
      ),
    );
  }
}

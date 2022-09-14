import 'package:flutter/material.dart';
import 'package:sqflite_0/home.dart';
import 'package:sqflite_0/sqldb.dart';

class AddNote extends StatefulWidget {
  const AddNote({Key? key}) : super(key: key);

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController? notes =  TextEditingController();
  TextEditingController? title =  TextEditingController();
  TextEditingController? color =  TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Notes"),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: ListView(
          children: [
            Form(
              key: formstate,
                child: Column(
                  children: [
                    TextFormField(
                      controller: notes,
                      decoration: InputDecoration(
                        // hintText: "note",
                        labelText: "note",
                      ),
                    ),
                    TextFormField(
                      controller: title,
                      decoration: InputDecoration(
                        // hintText: "title",
                        labelText: "title",
                      ),
                    ),
                    TextFormField(
                      controller: color,
                      decoration: InputDecoration(
                        // hintText: "color",
                        labelText: "color",
                      ),
                    ),
                    SizedBox(height: 20,),
                    MaterialButton(
                      onPressed: ()async{
                       int response= await sqlDb.insertData('''
                       INSERT INTO Notes ('note','title','color')
                       VALUES ("${notes!.text}" , "${title!.text}" , "${color!.text}")
                       ''');
                       print("response ======================= $response");
                       if (response >0 ){
                         Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home(),),
                                 (route) => false);
                       }
                      },
                      child: Text("Add Note"),
                      color: Colors.blue,
                      textColor: Colors.white,
                    ),
                  ],
                ),
            ),
          ],
        ),
      ),
    );
  }
}

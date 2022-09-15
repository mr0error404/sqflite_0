import 'package:flutter/material.dart';
import 'package:sqflite_0/home.dart';
import 'package:sqflite_0/sqldb.dart';

class EditNote extends StatefulWidget {
  final note ;
  final title;
  final color;
  final id;
  const EditNote({Key? key, this.title, this.id, this.color, this.note}) : super(key: key);

  @override
  State<EditNote> createState() => _EditNoteState();
}

class _EditNoteState extends State<EditNote> {
  SqlDb sqlDb = SqlDb();
  GlobalKey<FormState> formstate = GlobalKey();
  TextEditingController? notes =  TextEditingController();
  TextEditingController? title =  TextEditingController();
  TextEditingController? color =  TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    notes!.text=widget.note;
    title!.text=widget.title;
    color!.text=widget.color;
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Notes"),
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

                      // int response= await sqlDb.updatetData('''
                      //  UPDATE Notes SET
                      //  note =  "${ notes!.text}" ,
                      //  title = "${ title!.text} ",
                      //  color = "${ color!.text}"
                      //  WHERE id = ${widget.id}
                      //  ''');
                      int response = await sqlDb.update(
                          "Notes",
                          {
                            "note" :  "${ notes!.text}" ,
                             "title" : "${ title!.text} ",
                             "color" :"${ color!.text}"
                          },
                          "id = ${widget.id}");
                      print("response ======================= $response");
                      if (response >0 ){
                        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) => Home(),),
                                (route) => false);
                      }
                    },
                    child: Text("Save Note"),
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

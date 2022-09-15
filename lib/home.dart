import 'package:flutter/material.dart';
import 'package:sqflite_0/sqldb.dart';
class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);
  @override
  State<Home> createState() => _HomeState();
}
class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  bool isLoading =true;
  List notes = [];
  // Future<List<Map>> showData()async{
  Future showData()async{
    List<Map> response = await sqlDb.showData("SELECT * FROM Notes");
    notes.addAll(response);
    isLoading =false;
    if(this.mounted){
      setState((){});
    }
    return response;
  }
  @override
  void initState() {
    // TODO: implement initState
    showData();
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("HomePage"),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.of(context).pushNamed("addnotes");
          },
        child: Icon(Icons.add),
      ),
      body: Column(
        children: [
          // MaterialButton(onPressed: ()async{
          //   await sqlDb.mydeleteDatabase();
          // },child: Text("Delete Database"),),
          // FutureBuilder(
          //     future: showData(),
          //     builder: (BuildContext context ,AsyncSnapshot<List<Map>> snapshot) {
          //   if (snapshot.hasData){
          //     return
                ListView.builder(
                itemCount: notes.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context , i){
                    return Card(
                      child: ListTile(
                        title: Text("${notes[i]['note']}"),
                        subtitle: Text("${notes[i]['title']}"),
                        trailing: IconButton(
                            onPressed: ()async{
                              int response =await sqlDb.deleteData("DELETE FROM Notes WHERE id = ${notes[i]['id']}");
                              if(response > 0){
                                notes.removeWhere((element) => element['id'] == notes[i]['id']);
                                // Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (context) => Home()));
                                setState((){});
                              }
                            },
                            icon: Icon(Icons.delete , color:  Colors.red,)),
                      ),
                    );
              }),
          //   return Center(child: CircularProgressIndicator(),);
          // } ),
        ],
      ),
    );
  }
}
/*
* Center(
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: ()async{
                int response = await sqlDb.insertData("INSERT INTO 'Notes' ('note') VALUES ('note gg')");
                print(response);
              },
              child: Text('Insert Data'),
            ),
          ),
          Center(
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: ()async{
                List<Map> response = await sqlDb.showData("SELECT * From 'Notes'");
                print('$response\n');
              },
              child: Text('Read Data'),
            ),
          ),
          Center(
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: ()async{
                int response = await sqlDb.updatetData("UPDATE 'Notes' SET 'note' = 'note six' WHERE id =6");
                print('$response\n');
              },
              child: Text('Update Data'),
            ),
          ),
          Center(
            child: MaterialButton(
              color: Colors.red,
              textColor: Colors.white,
              onPressed: ()async{
                int response = await sqlDb.deleteData("DELETE From 'Notes' WHERE id = 3");
                print('$response\n');
              },
              child: Text('Delete Data'),
            ),
          ),*/
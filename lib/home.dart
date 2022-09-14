import 'package:flutter/material.dart';
import 'package:sqflite_0/sqldb.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  SqlDb sqlDb = SqlDb();
  Future<List<Map>> showData()async{
    List<Map> response = await sqlDb.showData("SELECT * FROM Notes");
    return response;
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
          FutureBuilder(
              future: showData(),
              builder: (BuildContext context ,AsyncSnapshot<List<Map>> snapshot) {
            if (snapshot.hasData){
              return ListView.builder(
                itemCount: snapshot.data!.length,
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (context , i){
                    return Card(
                      child: ListTile(
                        title: Text("${snapshot.data![i]['note']}"),
                        subtitle: Text("${snapshot.data![i]['title']}"),
                        trailing: Text("${snapshot.data![i]['color']}"),
                      ),
                    );
              });
            }
            return Center(child: CircularProgressIndicator(),);
          } ),
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
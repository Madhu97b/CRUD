import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_4/services/databases.dart';
// import 'package:flutter/widgets.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  // ignore: unnecessary_new
  TextEditingController namecontroller = new TextEditingController(); //01
  // ignore: unnecessary_new
  TextEditingController agecontroller = new TextEditingController(); //02
  // ignore: unnecessary_new
  TextEditingController locationcontroller = new TextEditingController();
  //NOTE:-This code is from the employee.dart file we have to place after the class _HomeState.
  TextEditingController datecontroller = TextEditingController();

  Stream? DrDetailsStream; //first before allDrDetails

  getontheload() async {
    DrDetailsStream = await DatabaseMethods().getDrDetails();
    setState(() {});
  }

  @override
  void initState() {
    getontheload();
    super.initState();
  }

  Widget allDrDetails() {
    return StreamBuilder(
        stream: DrDetailsStream,
        builder: (context, AsyncSnapshot snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data.docs.length,
                  itemBuilder: (context, index) {
                    DocumentSnapshot ds = snapshot.data.docs[index];
                    return Container(
                      margin: const EdgeInsets.only(bottom: 5.0),
                      child: Material(
                        // here we wrapped a material widget to the container widget so we can clearly see the container widget
                        elevation: 10.0, //01
                        borderRadius: BorderRadius.circular(
                            10), //02.Used with material widget
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          // height: MediaQuery.of(context).size.height,//donot use it i'll gives the overflow
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Row(
                                // mainAxisAlignment:
                                // MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    // ignore: prefer_interpolation_to_compose_strings
                                    'Name:' + ds['Name'],
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.blue,
                                      fontSize: 20.0,
                                    ),
                                  ),
                                  const Spacer(),
                                  GestureDetector(
                                    onTap: () {
                                      namecontroller.text = ds['Name']; //01
                                      agecontroller.text = ds['age']; //02
                                      locationcontroller.text =
                                          ds['Location']; //03
//The above codes is used to load the data to the update page from home page
                                      Editdrdetails(ds['id']);
                                    },
                                    child: Icon(
                                      Icons.edit,
                                      color: Colors.amber[900],
                                    ),
                                  ),
                                  const SizedBox(width: 2.0),
                                  GestureDetector(
                                      onTap: () async {
                                        await DatabaseMethods()
                                            .DeleteDrDetails(ds['id']);
                                      },
                                      child: Icon(Icons.delete,
                                          color: Colors.amber[900])),
                                ],
                              ),
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                'age:' + ds['age'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                'Location:' + ds['Location'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.blue,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                'id:' + ds['id'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              ),
                              Text(
                                'Token Number: ${ds['sequenceID']}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.green,
                                  fontSize: 20.0,
                                ),
                              ),
                              Text(
                                // ignore: prefer_interpolation_to_compose_strings
                                'date:' + ds['Date'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.amber,
                                  fontSize: 20.0,
                                  fontStyle: FontStyle.italic,
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  })
              : Container();
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          const SafeArea(
            child: Text(
              "Dear",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.normal,
                color: Colors.cyanAccent,
                wordSpacing: 5.0,
              ),
            ),
          ),

          // centerTitle:true;
          Text(
            "Doctor",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.yellow[300],
              wordSpacing: 5.0,
              letterSpacing: 1.5,
            ),
          ),
        ]),
        // centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            // ignore: avoid_print
            print("clicked me");
            Navigator.pushNamed(context, '/employee');
          },
          child: const Text("NEXT")),
      body: Container(
        margin: const EdgeInsets.fromLTRB(14.0, 15.0, 15.0, 0.0),
        child: Column(
          children: <Widget>[
            Expanded(child: allDrDetails()),
          ],
        ),
      ),
    );
  }

  Future Editdrdetails(id) => showDialog(
      context: context,
      builder: (context) => AlertDialog(
            content: Container(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        GestureDetector(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Icon(Icons.cancel)),
                        const SizedBox(height: 60.0),
                        Text(
                          "Update",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.blue[900],
                            wordSpacing: 5.0,
                          ),
                        ),

                        // centerTitle:true;
                        Text(
                          "Details",
                          style: TextStyle(
                            fontSize: 30.0,
                            fontWeight: FontWeight.normal,
                            color: Colors.yellow[900],
                            wordSpacing: 5.0,
                            letterSpacing: 1.5,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5.0),
                    //NOTE:-This code from the employee.dart and this must be placed inside the column widget,Not in Row
                    const Text(
                      "Name",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Container(
                      // color: Colors.amber,
                      margin: const EdgeInsets.all(10.0),
                      // padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10.0)), //02
                      child: TextField(
                        controller: namecontroller,
                        decoration: const InputDecoration(
                            border: InputBorder.none), //01
                      ),
                    ),
                    const SizedBox(
                      height: 10.0,
                      width: 0.0,
                    ),
                    const Text(
                      "Age",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
                      // color: Colors.amber,
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10.0)),
                      child: TextField(
                        controller: agecontroller,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ), //01
                    ),
                    const SizedBox(
                      height: 10.0,
                      width: 0.0,
                    ),
                    const Text(
                      "Location",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 20.0),
                    ),
                    Container(
                      // color: Colors.amber,
                      margin: const EdgeInsets.all(10.0),
                      padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
                      decoration: BoxDecoration(
                          border: Border.all(),
                          borderRadius: BorderRadius.circular(10.0)), //02
                      child: TextField(
                        controller: locationcontroller,
                        decoration:
                            const InputDecoration(border: InputBorder.none),
                      ), //01
                    ),
                    ElevatedButton(
                        onPressed: () async {
                          Map<String, dynamic> updateinfo = {
                            "Name": namecontroller.text,
                            "age": agecontroller.text,
                            "id": id,
                            "Location": locationcontroller.text,
                            // "sequenceID": sequenceID;
                          };
                          await DatabaseMethods()
                              // .addEmployeeDetails(employeeInfoMap, id)
                              .UpdateDrDetails(id, updateinfo)
                              .then((value) {
                            Navigator.pop(context);
                          });
                        },
                        child: const Text('Update'))
                  ],
                ),
              ),
            ),
          ));
}

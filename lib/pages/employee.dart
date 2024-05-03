// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_application_4/services/database.dart';
import 'package:flutter_application_4/services/databases.dart';
// import 'package:random_string/random_string.dart';
import 'package:fluttertoast/fluttertoast.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_core/firebase_core.dart';

// import 'package:flutter_application_4/pages/home.dart';
// import 'package:flutter_application_4/pages/employee.dart';

class Employee extends StatefulWidget {
  const Employee({super.key});

  @override
  State<Employee> createState() => _EmployeeState();
}

class _EmployeeState extends State<Employee> {
  // ignore: unnecessary_new
  TextEditingController namecontroller = new TextEditingController(); //01
  // ignore: unnecessary_new
  TextEditingController agecontroller = new TextEditingController(); //02
  // ignore: unnecessary_new
  TextEditingController locationcontroller = new TextEditingController();
  //03 After the database addemployeedetailsmethod()
  TextEditingController datecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        title:
            Row(mainAxisAlignment: MainAxisAlignment.center, children: <Widget>[
          const Text(
            "Doctor",
            style: TextStyle(
              fontSize: 30.0,
              fontWeight: FontWeight.normal,
              color: Colors.cyanAccent,
              wordSpacing: 5.0,
            ),
          ),

          // centerTitle:true;
          Text(
            "Form",
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
      body: SafeArea(
        child: SingleChildScrollView(
          //single child scroll view is applied to prevent the bottom overflow.
          //Above the column which is applied for the entire screen
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 10.0, width: 0.0),
              const Text(
                "Name",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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
                  decoration:
                      const InputDecoration(border: InputBorder.none), //01
                ),
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              const Text(
                "Age",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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
                  decoration: const InputDecoration(border: InputBorder.none),
                ), //01
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              const Text(
                "Location",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
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
                  decoration: const InputDecoration(border: InputBorder.none),
                ), //01
              ),
              const Text(
                "Date",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.0),
              ),
              Container(
                // color: Colors.amber,
                margin: const EdgeInsets.all(10.0),
                padding: const EdgeInsets.fromLTRB(3.0, 3.0, 3.0, 3.0),
                decoration: BoxDecoration(
                    border: Border.all(),
                    borderRadius: BorderRadius.circular(10.0)), //02
                child: TextField(
                  keyboardType: TextInputType.datetime,
                  controller: datecontroller,
                  decoration: const InputDecoration(border: InputBorder.none),
                ), //01
              ),
              const SizedBox(
                height: 10.0,
                width: 0.0,
              ),
              Center(
                // child: ElevatedButton(
                //     onPressed: () async {
                //       //we have to use async here
                //       String id = randomAlphaNumeric(10);
                //       // String id = randomNumeric(2);
                //       // Map<String, dynamic> employeeInfoMap = {
                //       //async not here
                //       Map<String, dynamic> adddrDetails = {
                //         // FirebaseFirestore.instance.collection('DrDetails');

                //         "Name": namecontroller.text,
                //         "age": agecontroller.text,
                //         "id": id,
                //         "Location": locationcontroller.text,
                //       };
                //       await DatabaseMethods()
                //           // .addEmployeeDetails(employeeInfoMap, id)
                //           .adddrDetails(adddrDetails, id)
                //           .then((value) {
                //         Fluttertoast.showToast(
                //             msg: "Details Added successfully",
                //             toastLength: Toast.LENGTH_SHORT,
                //             gravity: ToastGravity.CENTER,
                //             timeInSecForIosWeb: 1,
                //             backgroundColor: Colors.red,
                //             textColor: Colors.white,
                //             fontSize: 16.0);
                //         Navigator.pop(context);
                child: ElevatedButton(
                    onPressed: () async {
                      Map<String, dynamic> adddrDetails = {
                        "Name": namecontroller.text,
                        "age": agecontroller.text,
                        // No need to pass 'id' and 'Location' here
                        // These will be generated and added automatically in the DatabaseMethods class
                        "Location": locationcontroller.text,
                        "Date": datecontroller.text,
                      };

                      await DatabaseMethods()
                          .adddrDetails(adddrDetails)
                          .then((value) {
                        Fluttertoast.showToast(
                          msg: "Details Added successfully",
                          toastLength: Toast.LENGTH_SHORT,
                          gravity: ToastGravity.CENTER,
                          timeInSecForIosWeb: 1,
                          backgroundColor: Colors.red,
                          textColor: Colors.white,
                          fontSize: 16.0,
                        );
                        Navigator.pop(context);
                      });
                      //.then method is used to the put the toast code inside it.
                      // // ignore: avoid_print
                      // print(id);
                      // ignore: use_build_context_synchronously
                    },
                    child: const Text(
                      "Add",
                      style: TextStyle(
                        fontSize: 15.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.black,
                      ),
                    )),
              ),
              // ElevatedButton(
              //   onPressed: () {
              //     Navigator.pop(context, '/');
              //   },
              //   child: const Text(
              //     'Done',
              //     style: TextStyle(
              //         fontSize: 20.0,
              //         color: Colors.black,
              //         fontWeight: FontWeight.bold),
              //   ),
              // )
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pop(context, '/');
          // print(id);
        },
        backgroundColor: Colors.purple[100],
        child: const Text(
          'Done',
          style: TextStyle(color: Colors.black, fontSize: 20.0),
        ),
      ),
    );
  }
}

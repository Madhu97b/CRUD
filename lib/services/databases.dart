// import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:firebase_core/firebase_core.dart';

// class DatabaseMethods {
//   //NOTE:-For the Creation.
//   Future adddrDetails(Map<String, dynamic> adddrDetails, String id) async {
//     return await FirebaseFirestore.instance
//         .collection('DrDetails')
//         .doc(id)
//         .set(adddrDetails); //For Adding we used .set(); method
//   }

// //NOTE:-For the Reading.
//   Future<Stream<QuerySnapshot>> getDrDetails() async {
//     return FirebaseFirestore.instance.collection('DrDetails').snapshots();
//     // For Reading we used .snapshots();  method
//   }

import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fluttertoast/fluttertoast.dart';
import 'package:random_string/random_string.dart';

class DatabaseMethods {
  // For Adding user details with a generated sequence ID
  Future<void> adddrDetails(Map<String, dynamic> adddrDetails) async {
    String id = randomAlphaNumeric(10);
    // String id = FirebaseFirestore.instance.collection('DrDetails').doc().id;
    // Generate a unique sequence ID for each user
    int sequenceID = await _getNextSequenceID();
    adddrDetails['id'] = id; // Add the generated ID to the user details
    adddrDetails['sequenceID'] = sequenceID;

    // await FirebaseFirestore.instance.collection('DrDetails').add(adddrDetails);
    await FirebaseFirestore.instance
        .collection('DrDetails')
        .doc(id)
        .set(adddrDetails);
  }

  // For getting the next sequence ID
  Future<int> _getNextSequenceID() async {
    QuerySnapshot querySnapshot =
        await FirebaseFirestore.instance.collection('DrDetails').get();
    return querySnapshot.docs.length + 1;
  }

  //NOTE:-For the Reading.
  Stream<QuerySnapshot> getDrDetails() {
    return FirebaseFirestore.instance.collection('DrDetails').snapshots();
  }

//NOTE:-For the Updating.
  // Future UpdateDrDetails(id, Map<String, dynamic> updateinfo) async {
  //   return await FirebaseFirestore.instance
  //       .collection('DrDetails')
  //       .doc(id)
  //       .update(updateinfo);

  //   // For update we used .update(); method
  //   //This will be used inside the update button.
  // }

  Future<void> UpdateDrDetails(
      String id, Map<String, dynamic> updateinfo) async {
    try {
      final documentSnapshot = await FirebaseFirestore.instance
          .collection('DrDetails')
          .doc(id)
          .get();

      if (documentSnapshot.exists) {
        await FirebaseFirestore.instance
            .collection('DrDetails')
            .doc(id)
            .update(updateinfo);
        print('Document updated successfully');
      } else {
        print('Document with ID $id does not exist');
        // Handle the case where the document does not exist
      }
    } catch (e) {
      print('Error updating document: $e');
      // Handle any potential errors
    }
  }

  Future DeleteDrDetails(String id) async {
    return await FirebaseFirestore.instance
        .collection('DrDetails')
        .doc(id)
        .delete();
  }
}



// Future addEmployeeDetails(
  //     Map<String, dynamic> employeeInfoMap, String id) async {
  //   return await FirebaseFirestore.instance
  //       .collection('Dr.Details') //This is a database name
  //       .doc(id) //This represents id
  //       .set(employeeInfoMap);
  //   //In add method this will set the details to the variable employeeInfoMap.
  // }
  // //addEmployeeDetails is a variable name and these are parameters(Map<String,dynamic> employeeInfoMap,String id)
  //String id is a id which represents the unique id for the each details we are going to enter based on this id.It can perform CRUD operations.

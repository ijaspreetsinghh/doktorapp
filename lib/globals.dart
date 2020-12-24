import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Globals {
  String userFirstName;
  String currentUserId;
  String userLastName;
  String userType;
  String userFullName;
  String userEmail;
  String userOccupation;
  String userAlcoholConsumption;
  String userActivityLevel;
  String userFoodPreference;
  String userSmokingHabit;
  User user;
  User loggedInUser;
  String userGender;
  String userDOB;
  String userBloodGroup;
  String userMaritalStatus;
  String userHeight;
  String userWeight;
  String userAllergies;
  String userCurrentMedication;
  String userPastMedication;
  String chronicDiseases;
  String userInjuries;
  String userSurgeries;
  String userEmergencyContactNumber;
  String userAddress;
  String doctorFirstName;
  String doctorLastName;
  String doctorSpeciality;
  int doctorContactNumber;
  String doctorAbout;
  String doctorAvatar;
  String doctorFullName;
  var doctorMap = Map();
  bool userLoggedIn = false;

  final users = FirebaseFirestore.instance.collection('users');
  final doctors = FirebaseFirestore.instance.collection('doctors');
  final appointments = FirebaseFirestore.instance.collection('appointments');
  final categories = FirebaseFirestore.instance.collection('categories');
  final auth = FirebaseAuth.instance;

  void getCurrentUser() async {
    try {
      user = auth.currentUser;
      currentUserId = user.uid;
      userEmail = user.email;
      if (user != null) {
        loggedInUser = user;
        userLoggedIn = true;
      }
    } catch (e) {
      print(e);
    }
  }

  Future getUserData() {
    getCurrentUser();
    users.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        userFirstName = result.data()['firstName'];
        userLastName = result.data()['lastName'];
        userType = result.data()['userType'];
        doctorSpeciality = result.data()['speciality'];

        userFullName = userFirstName + ' ' + userLastName;
      });
    });
    return null;
  }

  void getDoctorData() async {
    await for (var doc in doctors.snapshots()) {
      for (var docData in doc.docs) {
        // print(docData.data());
      }
    }
  }

  void getAppointments() async {
    await for (var appointment in appointments
        .where('appointmentBookedBy', isEqualTo: currentUserId)
        .snapshots()) {
      for (var appointmentData in appointment.docs) {
        // print(appointmentData.data());
      }
    }
  }

  void getCategories() async {
    await for (var category in categories.snapshots()) {
      for (var categories in category.docs) {
        // print(categories.data());
      }
    }
  }
}

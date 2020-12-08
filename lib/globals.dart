import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Globals {
  static String userFirstName;
  static String currentUserId;
  static String userLastName;
  static String userType;
  static String userFullName;
  static String userEmail;
  static String userOccupation;
  static String userAlcoholConsumption;
  static String userActivityLevel;
  static String userFoodPreference;
  static String userSmokingHabit;
  static var user;
  static User loggedInUser;
  static String userGender;
  static String userDOB;
  static String userBloodGroup;
  static String userMaritalStatus;
  static String userHeight;
  static String userWeight;
  static String userAllergies;
  static String userCurrentMedication;
  static String userPastMedication;
  static String chronicDiseases;
  static String userInjuries;
  static String userSurgeries;
  static String userEmergencyContactNumber;
  static String userAddress;
  static String doctorFirstName;
  static String doctorLastName;
  static String doctorSpeciality;
  static int doctorContactNumber;
  static String doctorAbout;
  static String doctorAvatar;
  static String doctorFullName;
  static var doctorMap = Map();
  static bool userLoggedIn = false;
  static CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  static CollectionReference doctors =
      FirebaseFirestore.instance.collection('doctors');
  static final auth = FirebaseAuth.instance;
  static void getCurrentUser() async {
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

  static Future getUserData() {
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

  static Future getDoctorData() {
    doctors.get().then((querySnapshot) {
      querySnapshot.docs.forEach((result) {
        doctorFirstName = result.data()['firstName'];
        doctorLastName = result.data()['lastName'];
        // doctorSpeciality = result.data()['speciality'];
        doctorContactNumber = result.data()['doctorContactNumber'];
        doctorFullName = doctorFirstName + ' ' + doctorLastName;

        doctorMap = result.data();
      });
    });
    return null;
  }
}

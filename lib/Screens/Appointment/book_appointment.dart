import 'package:date_format/date_format.dart';
import 'package:doktorapp/Screens/Appointment/appointment_booked.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:doktorapp/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class BookAppointment extends StatefulWidget {
  final String doctorName;
  final String doctorSpeciality;
  final doctorAvatar;
  final String doctorId;
  BookAppointment(
      {@required this.doctorName,
      @required this.doctorSpeciality,
        @required this.doctorAvatar,
      @required this.doctorId});
  @override
  _BookAppointmentState createState() => _BookAppointmentState();
}

class _BookAppointmentState extends State<BookAppointment> {
  bool _saving = false;
  String title;
  String description;
  final _auth = FirebaseAuth.instance;
  void _submit() {
    setState(() {
      _saving = true;
    });
  }

  User loggedInUser;
  void getCurrentUser() async {
    try {
      final user = _auth.currentUser;
      if (user != null) {
        loggedInUser = user;

        currentUserId = loggedInUser.uid;
        print(currentUserId);
      }
    } catch (e) {
      print(e);
    }
  }

  CollectionReference appointments =
      FirebaseFirestore.instance.collection('appointments');
  String currentUserId;

  Future<void> addAppointment() {
    // Call the user's CollectionReference to add a new user
    return appointments
        .doc()
        .set({
          'appointmentBookedBy': currentUserId,
          'appointmentTime': '${selectedTime.hour}:${selectedTime.minute}',
          'dateOfAppointment': {
            'date': selectedDate.day,
            'month': selectedDate.month,
            'year': selectedDate.year
          },
          'created': selectedDate,
          'placeOfAppointment': 'Clinic',
          'appointmentBookedWith': widget.doctorId,
          'titleOfAppointment': title,
          'doctorName': widget.doctorName,
          'doctorSpeciality': widget.doctorSpeciality,
          'descriptionOfAppointment': description,
      'doctorAvatar':widget.doctorAvatar,

          // Stokes and Sons
        })
        .then((value) => print("Appointment Booked"))
        .catchError((error) => print("Failed to book appointment: $error"));
  }

  bool showAppointmentTitleBorder = false;
  bool appointmentTitleFieldOk = false;
  TextEditingController appointmentTitleController = TextEditingController();
  bool showAppointmentDescriptionBorder = false;
  bool appointmentDescriptionFieldOk = false;
  TextEditingController appointmentDescriptionController =
      TextEditingController();
  String _setTime, _setDate;

  String _hour, _minute, _time;

  String dateTime;

  DateTime selectedDate = DateTime.now();

  TimeOfDay selectedTime =
      TimeOfDay.fromDateTime(DateTime.now().add(Duration(minutes: 10)));

  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  Future<Null> _selectDate(BuildContext context) async {
    final DateTime picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        initialDatePickerMode: DatePickerMode.day,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 14)));
    if (picked != null)
      setState(() {
        selectedDate = picked;
        _dateController.text = DateFormat.yMd().format(selectedDate);
      });
  }

  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
      initialEntryMode: TimePickerEntryMode.dial,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
        _timeController.text = formatDate(
            DateTime(2019, 08, 1, selectedTime.hour, selectedTime.minute),
            [hh, ':', nn, " ", am]).toString();
      });
  }

  @override
  void initState() {
    getCurrentUser();
    _dateController.text = DateFormat.yMd().format(DateTime.now());

    _timeController.text = formatDate(
        DateTime(2019, 08, 1, DateTime.now().hour, DateTime.now().minute + 10),
        [hh, ':', nn, " ", am]).toString();
    super.initState();
  }

  final _appointmentBookingFormKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      color: Colors.black,
      dismissible: false,
      inAsyncCall: _saving,
      opacity: 0.7,
      child: Scaffold(
        backgroundColor: kWhiteBackgroundColor,
        appBar: AppBar(
          title: Text(
            'Book Appointment',
            style: TextStyle(color: Colors.black),
          ),
          backgroundColor: kWhiteBackgroundColor,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: GestureDetector(
          onTap: () {
            FocusScopeNode currentFocus = FocusScope.of(context);
            if (!currentFocus.hasPrimaryFocus) {
              currentFocus.unfocus();
            }
          },
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: ListBody(
              children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
                  child: Column(
                    children: [
                      AppointmentCard(
                        doctorSpeciality: '${widget.doctorSpeciality}',
                        doctorName: '${widget.doctorName}',
                        doctorAvatar: '${widget.doctorAvatar}',
                      ),
                      SizedBox(
                        height: kPageVerticalPadding,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            child: InkWell(
                              onTap: () {
                                _selectDate(context);
                              },
                              child: Container(
                                height: 70,
                                width: 140,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: kBackgroundColor,
                                    borderRadius:
                                        BorderRadius.circular(kRoundedCorners)),
                                child: TextFormField(
                                  autofocus: false,
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  controller: _dateController,
                                  onSaved: (String val) {
                                    _setDate = val;
                                  },
                                  decoration: InputDecoration(
                                    disabledBorder: UnderlineInputBorder(
                                        borderSide: BorderSide.none),
                                    // labelText: 'Time',
                                  ),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
                                color: kBackgroundColor),
                          ),
                          Container(
                            child: InkWell(
                              onTap: () {
                                _selectTime(context);
                              },
                              child: Container(
                                width: 120,
                                height: 70,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: kBackgroundColor,
                                    borderRadius:
                                        BorderRadius.circular(kRoundedCorners)),
                                child: TextFormField(
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                  onSaved: (String val) {
                                    _setTime = val;
                                  },
                                  enabled: false,
                                  keyboardType: TextInputType.text,
                                  controller: _timeController,
                                  decoration: InputDecoration(
                                      disabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide.none),
                                      // labelText: 'Time',
                                      contentPadding: EdgeInsets.all(5)),
                                ),
                              ),
                            ),
                            decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
                                color: kBackgroundColor),
                          )
                        ],
                      ),
                      SizedBox(
                        height: kPageVerticalPadding * 2,
                      ),
                      Form(
                        key: _appointmentBookingFormKey,
                        child: Column(
                          children: [
                            AnimatedContainer(
                              duration: Duration(milliseconds: 500),
                              decoration: BoxDecoration(
                                color: kBackgroundColor,
                                border: Border.all(
                                  color: showAppointmentTitleBorder
                                      ? kBorderColor
                                      : Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
                              ),
                              child: Container(
                                padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                                child: TextFormField(
                                  controller: appointmentTitleController,
                                  cursorColor: kPrimaryColor,
                                  textInputAction: TextInputAction.next,
                                  autofocus: false,
                                  validator: (value) {
                                    if (value.isEmpty || value.length > 250) {
                                      setState(() {
                                        showAppointmentTitleBorder = true;
                                        appointmentTitleFieldOk = false;
                                      });
                                    } else {
                                      setState(() {
                                        appointmentTitleFieldOk = true;
                                        showAppointmentTitleBorder = false;
                                      });
                                    }
                                    return null;
                                  },
                                  keyboardType: TextInputType.text,
                                  decoration: InputDecoration(
                                    fillColor: Colors.white,
                                    // filled: true,
                                    prefixIcon: Icon(Icons.short_text),
                                    labelText: 'Title',
                                    labelStyle: kLabelTextStyle,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: kPageHorizontalPadding - 8,
                                        vertical: 15.0),
                                    hintText: 'Short title for appointment',
                                    hintStyle: kHintTextStyle,
                                    isDense: true,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          kRoundedCorners),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: kPageVerticalPadding,
                            ),
                            AnimatedContainer(
                              duration: Duration(milliseconds: 300),
                              decoration: BoxDecoration(
                                color: kBackgroundColor,
                                border: Border.all(
                                  color: showAppointmentDescriptionBorder
                                      ? kBorderColor
                                      : Colors.white,
                                  width: 2.0,
                                ),
                                borderRadius:
                                    BorderRadius.circular(kRoundedCorners),
                              ),
                              child: Container(
                                // color: Colors.white,
                                padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                                decoration: BoxDecoration(
                                  color: kBackgroundColor,
                                  borderRadius:
                                      BorderRadius.circular(kRoundedCorners),
                                ),
                                child: TextFormField(
                                  controller: appointmentDescriptionController,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 3,
                                  minLines: 3,
                                  cursorColor: kPrimaryColor,
                                  validator: (value) {
                                    if (value.isEmpty ||
                                        value.length < 5 ||
                                        value.length > 400) {
                                      setState(() {
                                        showAppointmentDescriptionBorder = true;
                                        appointmentDescriptionFieldOk = false;
                                      });
                                    } else {
                                      setState(() {
                                        showAppointmentDescriptionBorder =
                                            false;
                                        appointmentDescriptionFieldOk = true;
                                      });
                                    }
                                    return null;
                                  },
                                  decoration: InputDecoration(
                                    labelText: 'Brief Description',
                                    labelStyle: kLabelTextStyle,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.always,
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: kPageHorizontalPadding - 8,
                                        vertical: 15.0),
                                    isDense: true,
                                    isCollapsed: true,
                                    hintText: '400 characters maximum.',
                                    hintStyle: kHintTextStyle,
                                    prefixIcon:
                                        Icon(Icons.description_outlined),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(
                                          kRoundedCorners),
                                      borderSide: BorderSide(
                                        width: 0,
                                        style: BorderStyle.none,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
              mainAxis: Axis.vertical,
            ),
          ),
        ),
        bottomNavigationBar: Container(
          margin: EdgeInsets.symmetric(vertical: kPageVerticalPadding),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              RaisedButton(
                onPressed: () async {
                  if (_appointmentBookingFormKey.currentState.validate()) {
                    _appointmentBookingFormKey.currentState.save();
                    title = appointmentTitleController.text;
                    description = appointmentDescriptionController.text;
                    if (appointmentTitleFieldOk) {
                      if (appointmentDescriptionFieldOk) {
                        try {
                          _submit();
                          await addAppointment();
                          Navigator.pushReplacementNamed(
                              context, AppointmentBooked.id);
                        } catch (e) {
                          print(e);
                        }
                        setState(() {
                          _saving = false;
                        });
                      }
                    }
                  }
                },
                color: kPrimaryColor,
                padding: EdgeInsets.symmetric(
                    horizontal: kPageHorizontalPadding * 2,
                    vertical: (kPageVerticalPadding * 2) - 2),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(kRoundedCorners),
                ),
                child: Text(
                  'Confirm Booking ',
                  style: TextStyle(color: Colors.white, fontSize: 20.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class AppointmentCard extends StatelessWidget {
  final String doctorName;
  final String doctorSpeciality;
final String doctorAvatar;
  AppointmentCard({
    @required this.doctorSpeciality,
    @required this.doctorName,
    @required this.doctorAvatar,
  });
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: kPageVerticalPadding),
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: kPageHorizontalPadding * 1.5,
            vertical: kPageVerticalPadding * 1.5),
        decoration: BoxDecoration(
          color: Colors.teal,
          borderRadius: BorderRadius.circular(kRoundedCorners),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(doctorAvatar),
                  radius: 30.0,
                ),
                SizedBox(
                  width: kPageHorizontalPadding,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Dr. $doctorName',
                      overflow: TextOverflow.ellipsis,
                      style: kSubHeadingTextStyle.copyWith(
                          fontSize: 18.0, color: Colors.white),
                    ),
                    Text(doctorSpeciality,
                        style:
                            kSecondaryTextStyle.copyWith(color: Colors.white70))
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

import 'package:doktorapp/globals.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:date_picker_timeline/date_picker_widget.dart';
import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

class DoctorProfileView extends StatefulWidget {
  static const id = 'DoctorProfileView';
  final doctorSpeciality;
  final doctorFullName;

  final doctorContactNumber;
  final doctorAbout;
  DoctorProfileView(
      {@required this.doctorFullName,
      @required this.doctorSpeciality,
      @required this.doctorAbout,
      @required this.doctorContactNumber});
  @override
  _DoctorProfileViewState createState() => _DoctorProfileViewState();
}

class _DoctorProfileViewState extends State<DoctorProfileView> {
  DatePickerController _controller = DatePickerController();

  DateTime _selectedDate = DateTime.now();

  TimeOfDay selectedTime = TimeOfDay.now();
  TextEditingController _timeController = TextEditingController();

  String _hour, _minute, _time;
  Future<Null> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null)
      setState(() {
        selectedTime = picked;
        _hour = selectedTime.hour.toString();
        _minute = selectedTime.minute.toString();
        _time = _hour + ' : ' + _minute;
        _timeController.text = _time;
      });
  }

  Color clockColor = kSecondaryColor;
  Color clockBackgroundColor = kBackgroundColor;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kWhiteBackgroundColor,
      appBar: AppBar(
        backgroundColor: kWhiteBackgroundColor,
        iconTheme: IconThemeData(color: Colors.black),
        actions: [
          Container(
            child: Icon(
              Icons.more_vert_rounded,
            ),
            margin: EdgeInsets.only(right: kPageHorizontalPadding),
          ),
        ],
        elevation: 0,
      ),
      body: Container(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
          child: Consumer<Globals>(builder: (context, globals, child) {
            return Column(
              children: [
                Center(
                  child: Column(
                    children: [
                      CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/images/defaultProfileImage.png'),
                        radius: kLargeCircleAvatarRadius,
                      ),
                      SizedBox(
                        height: 30.0,
                      ),
                      Text(
                        '${widget.doctorSpeciality}',
                        style: kNameTextStyle.copyWith(color: kSecondaryColor),
                      ),
                      Text(
                        'Dr. ${widget.doctorFullName}',
                        style: kBigHeadingTextStyle,
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: kPageVerticalPadding * 3),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              child: DoctorProfileViewActionButton(
                                icon: FontAwesomeIcons.phoneAlt,
                              ),
                              onTap: () {
                                launch("tel:${widget.doctorContactNumber}");
                              },
                            ),
                            GestureDetector(
                              child: DoctorProfileViewActionButton(
                                icon: Icons.messenger,
                              ),
                              onTap: () {
                                launch(
                                    'sms:${widget.doctorContactNumber}?body=Hi\nDr. ${widget.doctorFullName} contacting you via Doctor App for ');
                              },
                            ),
                            DoctorProfileViewActionButton(
                              icon: FontAwesomeIcons.video,
                            ),
                            DoctorProfileViewActionButton(
                              icon: FontAwesomeIcons.locationArrow,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'About',
                              style: kBigHeadingTextStyle,
                            ),
                            SizedBox(
                              height: kPageVerticalPadding - 5,
                            ),
                            Text(
                              '${widget.doctorAbout}',
                              style: kHintTextStyle.copyWith(
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: kPageVerticalPadding * 3),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Schedules',
                              style: kBigHeadingTextStyle,
                            ),
                            SizedBox(
                              height: kPageVerticalPadding * 2,
                            ),
                            DatePicker(
                              DateTime.now(), daysCount: 15,
                              // width: 60,
                              // height: 80,
                              controller: _controller,
                              initialSelectedDate: DateTime.now(),
                              inactiveDates: [
                                DateTime.now().add(Duration(days: 3)),
                                DateTime.now().add(Duration(days: 9)),
                                DateTime.now().add(Duration(days: 7))
                              ],
                              deactivatedColor: kSecondaryColor,
                              selectionColor: kPrimaryColor,
                              selectedTextColor: Colors.white,
                              dateTextStyle: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                              monthTextStyle: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 12.0),
                              onDateChange: (date) {
                                // New date selected
                                setState(() {
                                  _selectedDate = date;
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          }),
        ),
      ),
      bottomNavigationBar: Container(
        margin: EdgeInsets.symmetric(vertical: kPageVerticalPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            GestureDetector(
              child: Container(
                child: Icon(
                  FontAwesomeIcons.clock,
                  color: clockColor,
                ),
                width: 65.0,
                height: 65.0,
                decoration: BoxDecoration(
                  color: clockBackgroundColor,
                  borderRadius: BorderRadius.circular(kRoundedCorners),
                ),
              ),
              onTap: () {
                print(selectedTime);
                _selectTime(context);
                if (selectedTime != null) {
                  setState(() {
                    clockColor = Colors.white;
                    clockBackgroundColor = kPrimaryColor;
                  });
                }
              },
            ),
            RaisedButton(
              onPressed: () //async
                  {
                print(_selectedDate);
              },
              color: kPrimaryColor,
              padding: EdgeInsets.symmetric(
                  horizontal: kPageHorizontalPadding * 2,
                  vertical: (kPageVerticalPadding * 2) - 2),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(kRoundedCorners),
              ),
              child: Text(
                'Appointment',
                style: TextStyle(color: Colors.white, fontSize: 20.0),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class DoctorProfileViewActionButton extends StatelessWidget {
  final IconData icon;
  DoctorProfileViewActionButton({@required this.icon});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: kPageHorizontalPadding / 2),
      child: Icon(
        icon,
        color: kSecondaryColor,
      ),
      width: 55.0,
      height: 55.0,
      decoration: BoxDecoration(
        color: kBackgroundColor,
        borderRadius: BorderRadius.circular(kRoundedCorners),
      ),
    );
  }
}

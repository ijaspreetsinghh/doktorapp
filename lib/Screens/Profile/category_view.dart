import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:doktorapp/constants.dart';
import 'package:provider/provider.dart';
import 'package:doktorapp/globals.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'doctor_profile_view.dart';

class CategoryView extends StatefulWidget {
  CategoryView(
      {@required this.title, @required this.icon, @required this.speciality});
  final String title;
  final String icon;
  final String speciality;
  @override
  _CategoryViewState createState() => _CategoryViewState();
}

class _CategoryViewState extends State<CategoryView> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Globals>(builder: (context, globals, child) {
      return Scaffold(
        backgroundColor: kWhiteBackgroundColor,
        appBar: AppBar(
          title: (Text(
            '${widget.speciality} ',
            style: TextStyle(color: Colors.black),
          )),
          backgroundColor: kWhiteBackgroundColor,
          iconTheme: IconThemeData(color: Colors.black),
          elevation: 0,
        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(
                vertical: kPageVerticalPadding,
                horizontal: kPageHorizontalPadding),
            child: ListBody(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(
                              horizontal: kPageHorizontalPadding - 8),
                          decoration: BoxDecoration(
                            gradient: kPrimaryGradient,
                            borderRadius:
                                BorderRadius.circular(kRoundedCorners),
                          ),
                          width: 90.0,
                          height: 105.0,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.network(
                                widget.icon,
                                width: 50,
                              ),
                              Text(
                                widget.title,
                                style: kRichTextStyle1.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w100,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Container(
                          width: 180.0,
                          child: Text(
                            'So, how do you catch this user event in Flutter Well, after a fair amount of trial an',
                            style: kSecondaryTextStyle,
                            textAlign: TextAlign.justify,
                          ),
                        ),
                      ],
                    )
                  ],
                ),
                Container(
                  padding:
                      EdgeInsets.symmetric(vertical: kPageVerticalPadding * 2),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Top Doctors in this category',
                        style: kSubHeadingTextStyle.copyWith(fontSize: 18.0),
                      )
                    ],
                  ),
                ),
                StreamBuilder<QuerySnapshot>(
                  stream: globals.doctors
                      .where('speciality', isEqualTo: widget.speciality)
                      .snapshots(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      final doc = snapshot.data.docs;
                      List<TopDoctorsBuilder> topDoctorWidget = [];
                      for (var docs in doc) {
                        final docFirstName = docs.data()['firstName'];
                        final docLastName = docs.data()['lastName'];
                        final docSpeciality = docs.data()['speciality'];
                        final docAbout = docs.data()['doctorAbout'];
                        final docId = docs.data()['userId'];
                        final docNumber = docs.data()['doctorContactNumber'];
                        final docAvatar = docs.data()['doctorAvatar'];
                        final doctorWidget = TopDoctorsBuilder(
                            doctorAbout: docAbout,
                            doctorId: docId,
                            doctorNumber: docNumber,
                            doctorAvatarAssetName:docAvatar
                            ,
                            doctorName: '$docFirstName $docLastName',
                            doctorSpeciality: '$docSpeciality');
                        topDoctorWidget.add(doctorWidget);
                      }
                      return Column(
                        children: topDoctorWidget,
                      );
                    }
                    return Container();
                  },
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TopDoctorsBuilder extends StatelessWidget {
  TopDoctorsBuilder(
      {@required this.doctorAvatarAssetName,
      @required this.doctorName,
      @required this.doctorSpeciality,
      @required this.doctorAbout,
      @required this.doctorId,
      @required this.doctorNumber});
  final String doctorSpeciality;
  final String doctorName;
  final String doctorId;
  final String doctorAvatarAssetName;
  final String doctorAbout;
  final String doctorNumber;

  @override
  Widget build(BuildContext context) {
    return Consumer<Globals>(builder: (context, globals, child) {
      globals.getUserData();
      return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => DoctorProfileView(
                        doctorFullName: this.doctorName,
                        doctorId: this.doctorId,
                        doctorAvatar: this.doctorAvatarAssetName,
                        doctorSpeciality: this.doctorSpeciality,
                        doctorAbout: this.doctorAbout,
                        doctorContactNumber: this.doctorNumber,
                      )));
        },
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(kRoundedCorners)),
          color: kBackgroundColor,
          margin: EdgeInsets.symmetric(vertical: kPageVerticalPadding - 3),
          elevation: 0,
          child: Padding(
            padding: const EdgeInsets.symmetric(
                horizontal: kPageHorizontalPadding,
                vertical: kPageVerticalPadding),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(doctorAvatarAssetName),
                  radius: kMediumCircleAvatarRadius,backgroundColor: Colors.white,
                ),
                SizedBox(
                  width: kPageHorizontalPadding - 2,
                ),
                Expanded(
                  flex: 5,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        doctorSpeciality,
                        style: kSecondaryTextStyle.copyWith(fontSize: 12.0),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      ),
                      Text(
                        doctorName,
                        style: kBigHeadingTextStyle.copyWith(
                          fontSize: 15.0,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                        softWrap: false,
                      )
                    ],
                  ),
                ),
                Visibility(
                    visible: false,
                    child: Column(
                      children: [Text(doctorAbout), Text(doctorNumber)],
                    )),
                Flexible(child: Container()),
                GestureDetector(
                  child: Icon(
                    Icons.more_vert_rounded,
                  ),
                  onTap: () {},
                )
              ],
            ),
          ),
        ),
      );
    });
  }
}

class TopDoctors {
  List<TopDoctorsBuilder> doctorsList;
  TopDoctors({this.doctorsList});
}

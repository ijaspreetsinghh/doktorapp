import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doktorapp/Screens/Profile/category_view.dart';
import 'package:doktorapp/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doktorapp/globals.dart';
import 'package:provider/provider.dart';
import 'package:doktorapp/Screens/Profile/doctor_profile_view.dart';

class ProfilePageContent extends StatefulWidget {
  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);
        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Container(child: Consumer<Globals>(
        builder: (context, globals, child) {
          return SingleChildScrollView(
            child: ListBody(
              children: [
                Column(children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kPageHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Container(
                        //   margin: EdgeInsets.symmetric(
                        //       vertical: kPageVerticalPadding * 2),
                        //   padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                        //   child: TextField(
                        //     textInputAction: TextInputAction.search,
                        //     cursorColor: kPrimaryColor,
                        //     keyboardType: TextInputType.text,
                        //     decoration: InputDecoration(
                        //       fillColor: kBackgroundColor,
                        //       filled: true,
                        //       contentPadding: EdgeInsets.symmetric(
                        //           horizontal: kPageHorizontalPadding,
                        //           vertical: 15.0),
                        //       hintText: 'Search, e.g. Dr. Louis Pasteur',
                        //       hintStyle: kHintTextStyle,
                        //       isDense: true,
                        //       suffixIcon: GestureDetector(
                        //         onTap: () {
                        //           FocusScopeNode currentFocus =
                        //               FocusScope.of(context);
                        //           currentFocus.unfocus();
                        //         },
                        //         child: Container(
                        //           padding: EdgeInsets.symmetric(
                        //               vertical: kPageVerticalPadding + 8,
                        //               horizontal: kPageHorizontalPadding + 2),
                        //           decoration: BoxDecoration(
                        //             gradient: kPrimaryGradient,
                        //             borderRadius:
                        //                 BorderRadius.circular(kRoundedCorners),
                        //           ),
                        //           child: Icon(
                        //             FontAwesomeIcons.search,
                        //             color: Colors.white,
                        //           ),
                        //         ),
                        //       ),
                        //       border: OutlineInputBorder(
                        //         borderRadius:
                        //             BorderRadius.circular(kRoundedCorners),
                        //         borderSide: BorderSide(
                        //           width: 0,
                        //           style: BorderStyle.none,
                        //         ),
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        SizedBox(
                          height: kPageVerticalPadding,
                        ),
                        Text(
                          'Categories',
                          style: kBigHeadingTextStyle,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(
                        vertical: kPageVerticalPadding * 1.5),
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10.0,
                          ),
                          StreamBuilder(
                              stream: globals.categories.snapshots(),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  final category = snapshot.data.docs;
                                  List<HorizontalListCategoryItemBuilder>
                                      horizontalListWidgets = [];
                                  for (var categories in category) {
                                    final categoryAlias =
                                        categories.data()['categoryAlias'];
                                    final categoryTitle =
                                        categories.data()['categoryTitle'];
                                    final categoryAvatar =
                                        categories.data()['categoryAvatar'];
                                    final horizontalListWidget =
                                        HorizontalListCategoryItemBuilder(
                                            speciality: categoryTitle,
                                            icon: categoryAvatar,
                                            title: categoryAlias);
                                    horizontalListWidgets
                                        .add(horizontalListWidget);
                                  }

                                  return Row(
                                    children: horizontalListWidgets,
                                  );
                                }
                                return Container();
                              })
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: kPageHorizontalPadding),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Top Doctors',
                          style: kBigHeadingTextStyle,
                        ),
                        SizedBox(
                          height: kPageVerticalPadding,
                        ),
                        StreamBuilder<QuerySnapshot>(
                          stream: globals.doctors.snapshots(),
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
                                final docNumber =
                                    docs.data()['doctorContactNumber'];
                                final doctorWidget = TopDoctorsBuilder(
                                    doctorAbout: docAbout,
                                    doctorId: docId,
                                    doctorNumber: docNumber,
                                    doctorAvatarAssetName:
                                        'assets/images/userImage.jpg',
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
                ]),
              ],
            ),
          );
        },
      )),
    );
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
                  backgroundImage: AssetImage(doctorAvatarAssetName),
                  radius: kMediumCircleAvatarRadius,
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

class HorizontalListCategoryItemBuilder extends StatelessWidget {
  HorizontalListCategoryItemBuilder(
      {@required this.icon, @required this.title, @required this.speciality});

  final String title;
  final String speciality;
  final String icon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CategoryView(
                      title: this.title,
                      icon: this.icon,
                      speciality: this.speciality,
                    )));
      },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: kPageHorizontalPadding - 8),
        decoration: BoxDecoration(
          gradient: kPrimaryGradient,
          borderRadius: BorderRadius.circular(kRoundedCorners),
        ),
        width: 90.0,
        height: 105.0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Image.network(
              icon,
              width: 50,
            ),
            Text(
              title,
              style: kRichTextStyle1.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class TopDoctors {
  List<TopDoctorsBuilder> doctorsList;
  TopDoctors({this.doctorsList});
}

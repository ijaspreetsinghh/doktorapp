import 'package:doktorapp/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:doktorapp/globals.dart';

class ProfilePageContent extends StatefulWidget {
  @override
  _ProfilePageContentState createState() => _ProfilePageContentState();
}

class _ProfilePageContentState extends State<ProfilePageContent> {
  @override
  void initState() {
    Globals.getDoctorData();
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
      child: Container(
        child: SingleChildScrollView(
          child: ListBody(
            children: [
              Column(children: [
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(
                            vertical: kPageVerticalPadding * 2),
                        padding: EdgeInsets.fromLTRB(0, 15.0, 0, 0),
                        child: TextField(
                          textInputAction: TextInputAction.search,
                          cursorColor: kPrimaryColor,
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                            fillColor: kBackgroundColor,
                            filled: true,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: kPageHorizontalPadding,
                                vertical: 15.0),
                            hintText: 'Search, e.g. Dr. Louis Pasteur',
                            hintStyle: kHintTextStyle,
                            isDense: true,
                            suffixIcon: GestureDetector(
                              onTap: () {
                                FocusScopeNode currentFocus =
                                    FocusScope.of(context);
                                currentFocus.unfocus();
                              },
                              child: Container(
                                padding: EdgeInsets.symmetric(
                                    vertical: kPageVerticalPadding + 8,
                                    horizontal: kPageHorizontalPadding + 2),
                                decoration: BoxDecoration(
                                  gradient: kPrimaryGradient,
                                  borderRadius:
                                      BorderRadius.circular(kRoundedCorners),
                                ),
                                child: Icon(
                                  FontAwesomeIcons.search,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.circular(kRoundedCorners),
                              borderSide: BorderSide(
                                width: 0,
                                style: BorderStyle.none,
                              ),
                            ),
                          ),
                        ),
                      ),
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
                        HorizontalListCategoryItemBuilder(
                          title: 'Heart',
                          icon: FontAwesomeIcons.kissWinkHeart,
                        ),
                        HorizontalListCategoryItemBuilder(
                          title: 'Kidney',
                          icon: FontAwesomeIcons.solidNewspaper,
                        ),
                        HorizontalListCategoryItemBuilder(
                          title: 'Brain',
                          icon: FontAwesomeIcons.brain,
                        ),
                        HorizontalListCategoryItemBuilder(
                          title: 'Brain',
                          icon: FontAwesomeIcons.brain,
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: kPageHorizontalPadding),
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
                      TopDoctorsBuilder(
                        doctorAvatarAssetName:
                            'assets/images/defaultProfileImage.png',
                        doctorName: 'Dr. Jaspreet Singh',
                        doctorSpeciality: 'Dil ka doctor',
                      )
                    ],
                  ),
                ),
              ]),
            ],
          ),
        ),
      ),
    );
  }
}

class TopDoctorsBuilder extends StatelessWidget {
  TopDoctorsBuilder(
      {@required this.doctorAvatarAssetName,
      @required this.doctorName,
      @required this.doctorSpeciality});
  final String doctorSpeciality;
  final String doctorName;
  final String doctorAvatarAssetName;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        print(Globals.doctorSpeciality);
        print(Globals.doctorMap);
        print(Globals.doctorSpeciality);
        // Navigator.pushNamed(context, DoctorProfileView.id);
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
                Flexible(child: Container()),
                GestureDetector(
                  child: Icon(
                    Icons.more_vert_rounded,
                  ),
                  onTap: () {},
                )
              ],
            ),
          )),
    );
  }
}

class HorizontalListCategoryItemBuilder extends StatelessWidget {
  HorizontalListCategoryItemBuilder(
      {@required this.icon, @required this.title});

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Icon(
            icon,
            color: Colors.white,
            size: 45.0,
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
    );
  }
}

class TopDoctors {
  List<TopDoctorsBuilder> doctorsList;
  TopDoctors({this.doctorsList});
}

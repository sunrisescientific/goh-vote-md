import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import '../widgets/contact_card.dart';
import '../widgets/contact_row.dart';
import '../widgets/county_dropdown.dart';
import '../widgets/screen_header.dart';
import '../data/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ContactScreen extends StatefulWidget {
  const ContactScreen({super.key});

  @override
  State<ContactScreen> createState() => _ContactScreenState();
}

class _ContactScreenState extends State<ContactScreen> {
  
  @override
  Widget build(BuildContext context) {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;

    final stateRows = const [
      ContactRow(icon: Icons.phone, text: "410-269-2840", url: true, type: "phone"),
      ContactRow(icon: Icons.mail, text: "info.sbe@maryland.gov", url: true, type: "email"),
      ContactRow(icon: Icons.language, text: "elections.maryland.gov", url: true, type: "website"),
      ContactRow(icon: Icons.pin_drop, text: "151 West Street, Suite 200 \nAnnapolis, MD 21401", url: true, type: "address"),
      ContactRow(icon: FontAwesomeIcons.twitter, text: "x.com/md_sbe", url: true, type: "social"),
      ContactRow(icon: FontAwesomeIcons.instagram, text: "instagram.com/md_sbe", url: true, type: "social"),
      ContactRow(icon: FontAwesomeIcons.facebook, text: "facebook.com/MarylandStateBoardofElections", url: true, type: "social"),
      ContactRow(icon: FontAwesomeIcons.youtube, text: "youtube.com/channel/UCSlRSVe3Q3mwn26BCeAL7tw/videos", url: true, type: "social"),
    ];

    Widget countyDropdown = CountyDropdown();

    List<ContactRow> countyRows = countyProvider.selectedCountyContact != null
        ? [
            ContactRow(icon: Icons.phone, text: countyProvider.selectedCountyContact!.phone, url: true, type: "phone"),
            ContactRow(icon: Icons.mail, text: countyProvider.selectedCountyContact!.email, url: true, type: "email"),
            ContactRow(icon: Icons.language, text: countyProvider.selectedCountyContact!.website, url: true, type: "website"),
            ContactRow(icon: Icons.pin_drop, text: countyProvider.selectedCountyContact!.address, url: true, type: "address"),
          ]
        : [];

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.symmetric(horizontal: Dimensions.screenWidth * 0.06),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ScreenHeader(
                logoPath: 'assets/title_logo.png',
                countyName: selectedCounty,
                title: "Contact",
              ),

              ContactCard(title: "State Board of Elections Contact", rows: stateRows),
              if (countyProvider.selectedCountyContact != null && countyProvider.selectedCounty != 'County')
                ContactCard(title: "$selectedCounty Election Offices Contact", rows: countyRows, dropdown: countyDropdown),
              if (countyProvider.selectedCountyContact == null || countyProvider.selectedCounty == 'County')
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: ContactCard(
                    title: "State Election Offices Contacts",
                    rows: [],
                    dropdown: countyDropdown,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';
import '../widgets/contact_card.dart';
import '../widgets/contact_row.dart';
import '../widgets/county_dropdown.dart';
import '../widgets/screen_header.dart';
import '../data/constants.dart';

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
      ContactRow(icon: Icons.phone, text: "410-269-2840"),
      ContactRow(icon: Icons.mail, text: "info.sbe@maryland.gov"),
      ContactRow(icon: Icons.language, text: "elections.maryland.gov"),
      ContactRow(icon: Icons.pin_drop, text: "151 West Street, Suite 200 \nAnnapolis, MD 21401"),
      ContactRow(icon: Icons.numbers, text: "x.com/md_sbe"),
      ContactRow(icon: Icons.numbers, text: "instagram.com/md_sbe"),
    ];

    Widget countyDropdown = CountyDropdown();

    List<ContactRow> countyRows = countyProvider.selectedCountyContact != null
        ? [
            ContactRow(icon: Icons.phone, text: countyProvider.selectedCountyContact!.phone),
            ContactRow(icon: Icons.mail, text: countyProvider.selectedCountyContact!.email),
            ContactRow(icon: Icons.language, text: countyProvider.selectedCountyContact!.website),
            ContactRow(icon: Icons.pin_drop, text: countyProvider.selectedCountyContact!.address),
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

              ContactCard(title: "State Board of Election Contact", rows: stateRows),
              if (countyProvider.selectedCountyContact != null)
                ContactCard(title: "$selectedCounty Election Office Contact", rows: countyRows, dropdown: countyDropdown),
              if (countyProvider.selectedCountyContact == null)
                Container(
                  margin: const EdgeInsets.only(bottom: 16.0),
                  child: ContactCard(
                    title: "State Election Office Contacts",
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

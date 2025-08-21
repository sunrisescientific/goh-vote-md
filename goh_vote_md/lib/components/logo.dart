import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/county_provider.dart';

class Banner extends StatefulWidget {
  const Banner({super.key});

  @override
  State<Banner> createState() => _BannerState();
}

class _BannerState extends State<Banner> {
  String selectedCounty = "County";

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;


    return Column(
      children: [ 
        Container(
          color: Colors.white,
          padding: const EdgeInsets.only(top: 40, bottom: 0, left: 20, right: 20),
          width: double.infinity,
          child: Center(
            child: Image.asset(
              'assets/title_logo.png',
              height: height - 770,
              fit: BoxFit.contain,
            ),
          ),
        )
      ]
    );
  }
}
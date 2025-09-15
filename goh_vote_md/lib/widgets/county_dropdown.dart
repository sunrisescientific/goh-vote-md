import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/counties.dart';
import '../providers/county_provider.dart';
import '../data/constants.dart';
import '../data/constants.dart';

class CountyDropdown extends StatelessWidget {
  const CountyDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;

    final screenHeight = Dimensions.screenHeight;
    final screenWidth = Dimensions.screenWidth;

    return Container(
      width: screenWidth * 0.38,
      height: screenHeight * 0.045,
      padding: EdgeInsets.symmetric(
        horizontal: screenWidth * 0.025,
        vertical: screenHeight * 0.004, 
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: MARYLAND_RED, width: 1.2),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            spreadRadius: 1,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCounty,
          isExpanded: true,
          icon: const Icon(
            Icons.arrow_drop_down_rounded,
            color: MARYLAND_RED,
            size: 20, 
          ),
          style: TextStyle(
            fontSize: screenWidth * 0.04,
            color: Colors.black87,
            fontWeight: FontWeight.bold,
          ),
          onChanged: (newValue) {
            if (newValue != null) countyProvider.setCounty(newValue);
          },
          items: counties
              .map(
                (e) => DropdownMenuItem(
                  value: e,
                  child: Text(
                    e,
                    style: TextStyle(
                      fontSize: screenWidth * 0.04,
                      fontWeight: FontWeight.bold,
                      color: e == selectedCounty ? MARYLAND_RED : Colors.black87,
                    ),
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}

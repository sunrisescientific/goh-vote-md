import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../data/counties.dart';
import '../providers/county_provider.dart';

class CountyDropdown extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final countyProvider = Provider.of<CountyProvider>(context);
    final selectedCounty = countyProvider.selectedCounty;
    final screenWidth = MediaQuery.of(context).size.width;

    return Container(
      width: screenWidth * 0.35,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.2), spreadRadius: 1, blurRadius: 6, offset: const Offset(0, 3))],
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedCounty,
          isExpanded: true,
          icon: const Icon(Icons.arrow_drop_down),
          onChanged: (newValue) {
            if (newValue != null) countyProvider.setCounty(newValue);
          },
          items: counties.map((e) => DropdownMenuItem(value: e, child: Text(e, style: const TextStyle(fontSize: 14)))).toList(),
        ),
      ),
    );
  }
}
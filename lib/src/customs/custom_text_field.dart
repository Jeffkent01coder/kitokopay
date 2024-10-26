import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  const CustomTextField({super.key, required this.hintText});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  Country? _selectedCountry;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        // Input field
        Expanded(
          child: TextField(
            decoration: InputDecoration(
              prefixIcon: GestureDetector(
                onTap: () {
                  showCountryPicker(
                    context: context,
                    exclude: <String>['KN', 'MF'],
                    favorite: <String>['SE'],
                    showPhoneCode: true,
                    onSelect: (Country country) {
                      setState(() {
                        _selectedCountry = country;
                      });
                    },
                    countryListTheme: CountryListThemeData(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(40.0),
                        topRight: Radius.circular(40.0),
                      ),
                      inputDecoration: InputDecoration(
                        labelText: 'Search',
                        hintText: 'Start typing to search',
                        prefixIcon: const Icon(Icons.search),
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: const Color(0xFF8C98A8).withOpacity(0.2),
                          ),
                        ),
                      ),
                      searchTextStyle: const TextStyle(
                        color: Colors.blue,
                        fontSize: 18,
                      ),
                    ),
                  );
                },
                child: _selectedCountry != null
                    ? Text(_selectedCountry!.flagEmoji)
                    : const Icon(Icons.flag),
              ),
              hintText: widget.hintText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 16),
            ),
          ),
        ),
      ],
    );
  }
}

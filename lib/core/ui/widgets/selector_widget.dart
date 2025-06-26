import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_weather/bloc/weather/weather_bloc.dart';
import 'package:material_weather/core/ui/widgets/locationtile/locationtile.dart';

import '../../../bloc/search/search_bloc.dart';

class CitySelector extends StatefulWidget {
  const CitySelector({super.key});

  @override
  State<CitySelector> createState() => _CitySelectorState();
}

class _CitySelectorState extends State<CitySelector> {
  var key = GlobalKey<FormState>();
  late final TextEditingController controller;

  final int _debouncetime = 500;
  Timer? _debounce;
  String query = "";

  _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce?.cancel();
    _debounce = Timer(Duration(milliseconds: _debouncetime), () {
      if (controller.text != "") {
        ///here you perform your search
        context.read<SearchBloc>().add(
          SearchStart(location: controller.text.trim()),
        );
      } else {
        context.read<SearchBloc>().add(SearchReset());
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    controller = TextEditingController();
    controller.addListener(_onSearchChanged);
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    controller.removeListener(_onSearchChanged);
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsetsGeometry.all(16.0),
      decoration: BoxDecoration(color: Color.fromARGB(255, 27, 27, 27)),
      child: SingleChildScrollView(
        child: Form(
          key: key,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                decoration: InputDecoration(
                  focusColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(24.0),
                    borderSide: BorderSide(color: Colors.white, width: 2),
                  ),
                ),
                controller: controller,
                validator: (text) {
                  // Open Metro Geocoding API hook here.

                  if (text == null) {
                    return "Please enter a value";
                  } else if (text.isEmpty) {
                    return "Please enter a value";
                  }

                  return null;
                },
              ),
              const SizedBox(height: 30),
              BlocBuilder<SearchBloc, SearchState>(
                builder: (context, state) {
                  if (state is SearchSuccess) {
                    return ListView.builder(
                      shrinkWrap: true,
                      itemCount: state.locations.length,
                      itemBuilder: (c, i) {
                        return Locationtile(
                          name: state.locations[i]["name"],
                          city: state.locations[i]["admin1"] ?? "",
                          onClick: () {
                            context.read<WeatherBloc>().add(
                              SelectWeather(
                                name: state.locations[i]["name"] ?? "",
                                latitude: state.locations[i]["latitude"] ?? "",
                                longitude:
                                    state.locations[i]["longitude"] ?? "",
                              ),
                            );
                            Navigator.pop(context);
                          },
                          country: state.locations[i]["country"] ?? "",
                          countryCode: state.locations[i]["country_code"] ?? "",
                        );
                      },
                    );
                  }
                  if (state is SearchInitial) {
                    return Center(
                      child: Text(
                        "Type to begin searching",
                        style: GoogleFonts.delius().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }

                  if (state is SearchFailure) {
                    return Center(
                      child: Text(
                        state.error,
                        style: GoogleFonts.delius().copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    );
                  }
                  return Center(child: CircularProgressIndicator());
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

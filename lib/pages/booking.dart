

import 'package:baby_may_cry/components/custom-text-field.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:localize_and_translate/localize_and_translate.dart';

import '../static/colors.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  String? service = "King Hussein Bridge".tr();
  String? idType = "Palestinian".tr();
  String? fromLocation = "Jordan".tr();
  String? toLocation = "West Bank".tr();
  String? transportationFrom = "Jordan".tr();
  String? transportationTo = "King Hussein Bridge".tr();
  Map<String, List<String>> locations = {
    "Palestinian".tr(): ["Jordan".tr(), "West Bank".tr()],
    "Jerusalem or other".tr(): ["Jordan".tr(), "Israeli Side".tr()]
  };
  DateTime selectedDate = DateTime.now();
  TimeOfDay selectedTime = TimeOfDay.now();
  bool includeTransportation = false;
  bool includeCity = true;

  TextEditingController travelersCount = TextEditingController();
  TextEditingController adultsCount = TextEditingController();
  TextEditingController childrenCount = TextEditingController();
  TextEditingController babiesCount = TextEditingController();
  TextEditingController city = TextEditingController();

  TextEditingController passengersCount = TextEditingController();
  TextEditingController bagsCount = TextEditingController();
  TextEditingController notes = TextEditingController();
  String? vehicleType = "Car".tr();

  List<TextDirection> textDirection = [TextDirection.ltr, TextDirection.rtl];
  bool showSpinner = false;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );
    if (picked != null && picked != selectedTime) {
      setState(() {
        selectedTime = picked;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                width: screenWidth,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 20),
                child: Text(
                  "Reserve a VIP service".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(color: CustomColors.secondary, fontSize: 25),
                ),
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                color: CustomColors.primary,
                thickness: 3,
              ),
              Row(
                textDirection: translator.activeLanguageCode == "en"
                    ? this.textDirection[0]
                    : this.textDirection[1],
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Choose the location".tr(),
                    style: TextStyle(color: CustomColors.primary),
                  ),
                  SizedBox(width: 10),
                  DropdownButton(
                    isDense: true,
                    elevation: 16,
                    iconEnabledColor: CustomColors.primary,
                    value: this.service!.tr(),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 26,
                    ),
                    items: [
                      "King Hussein Bridge".tr(),
                      "Sheikh Hussein Bridge".tr()
                    ].map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        this.service = newValue;
                        if (newValue == "Sheikh Hussein Bridge".tr()) {
                          this.idType = "Jerusalem or other".tr();
                          this.fromLocation = "Jordan".tr();
                          this.toLocation = "Israeli Side".tr();
                        } else {
                          this.idType = "Palestinian".tr();
                          this.fromLocation = "Jordan".tr();
                          this.toLocation = "West Bank".tr();
                        }
                      });
                    },
                  ),
                ],
              ),
              Divider(
                indent: 20,
                endIndent: 20,
                color: CustomColors.primary,
                thickness: 3,
              ),
              if (this.service == "King Hussein Bridge".tr())
                SizedBox(height: 30),
              if (this.service == "King Hussein Bridge".tr())
                Row(
                  textDirection: translator.activeLanguageCode == "en"
                      ? this.textDirection[0]
                      : this.textDirection[1],
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Choose the id type".tr(),
                      style: TextStyle(
                        color: CustomColors.primary,
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButton(
                      isDense: true,
                      elevation: 16,
                      iconEnabledColor: CustomColors.primary,
                      value: this.idType!.tr(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 26,
                      ),
                      items: ["Palestinian".tr(), "Jerusalem or other".tr()]
                          .map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          this.idType = newValue;
                          if (newValue == "Palestinian".tr()) {
                            this.fromLocation = "Jordan".tr();
                            this.toLocation = "West Bank".tr();
                          } else {
                            this.fromLocation = "Jordan".tr();
                            this.toLocation = "Israeli Side".tr();
                          }
                        });
                      },
                    ),
                  ],
                ),
              SizedBox(height: 20),
              Row(
                textDirection: translator.activeLanguageCode == "en"
                    ? this.textDirection[0]
                    : this.textDirection[1],
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "From".tr(),
                    style: TextStyle(
                      color: CustomColors.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton(
                    isDense: true,
                    elevation: 16,
                    iconEnabledColor: CustomColors.primary,
                    value: this.fromLocation!.tr(),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 26,
                    ),
                    items: this.locations[this.idType]!.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        this.fromLocation = newValue;
                      });
                    },
                  ),
                  SizedBox(width: 20),
                  Text(
                    "To".tr(),
                    style: TextStyle(
                      color: CustomColors.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton(
                    isDense: true,
                    elevation: 16,
                    iconEnabledColor: CustomColors.primary,
                    value: this.toLocation!.tr(),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 26,
                    ),
                    items: this.locations[this.idType]!.map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        this.toLocation = newValue;
                      });
                    },
                  ),
                ],
              ),

              SizedBox(height: 20),
              Row(
                textDirection: translator.activeLanguageCode == "en"
                    ? this.textDirection[0]
                    : this.textDirection[1],
                children: [
                  SizedBox(width: 35),
                  InkWell(
                    child: Text(
                      "Select the date".tr(),
                      style: TextStyle(color: CustomColors.primary),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    child: Text(
                      this.selectedDate.year.toString() +
                          "-" +
                          this.selectedDate.month.toString() +
                          "-" +
                          this.selectedDate.day.toString(),
                    ),
                    onTap: () => _selectDate(context),
                  ),
                ],
              ),
              SizedBox(height: 30),
              Row(
                textDirection: translator.activeLanguageCode == "en"
                    ? this.textDirection[0]
                    : this.textDirection[1],
                children: [
                  SizedBox(width: 35),
                  InkWell(
                    child: Text(
                      "Select the time".tr(),
                      style: TextStyle(color: CustomColors.primary),
                    ),
                    onTap: () => _selectTime(context),
                  ),
                  SizedBox(width: 20),
                  InkWell(
                    child: Text(
                      this.selectedTime.format(context),
                    ),
                    onTap: () => _selectTime(context),
                  ),
                ],
              ),
              SizedBox(height: 25),
              Row(
                textDirection: translator.activeLanguageCode == "en"
                    ? this.textDirection[0]
                    : this.textDirection[1],
                children: [
                  SizedBox(width: 35),
                  Text(
                    "Number of travelers".tr(),
                    style: TextStyle(color: CustomColors.primary),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    child: CustomTextField(
                        controller: this.travelersCount,
                        inputType: TextInputType.number,
                        hint: "",
                        isObsecured: false,
                        isCenteredInput: true,
                        maxLength: 1,
                        icon: Icons.code),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                textDirection: translator.activeLanguageCode == "en"
                    ? this.textDirection[0]
                    : this.textDirection[1],
                children: [
                  SizedBox(width: 35),
                  Text(
                    "Number of adults".tr(),
                    style: TextStyle(color: CustomColors.primary),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    child: CustomTextField(
                        controller: this.adultsCount,
                        inputType: TextInputType.number,
                        hint: "",
                        isObsecured: false,
                        isCenteredInput: true,
                        maxLength: 1,
                        icon: Icons.code),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                textDirection: translator.activeLanguageCode == "en"
                    ? this.textDirection[0]
                    : this.textDirection[1],
                children: [
                  SizedBox(width: 35),
                  Text(
                    "Number of childs".tr(),
                    style: TextStyle(color: CustomColors.primary),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    child: CustomTextField(
                        controller: this.childrenCount,
                        inputType: TextInputType.number,
                        hint: "",
                        isObsecured: false,
                        isCenteredInput: true,
                        maxLength: 1,
                        icon: Icons.code),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Row(
                textDirection: translator.activeLanguageCode == "en"
                    ? this.textDirection[0]
                    : this.textDirection[1],
                children: [
                  SizedBox(width: 35),
                  Text(
                    "Number of babies".tr(),
                    style: TextStyle(color: CustomColors.primary),
                  ),
                  SizedBox(width: 10),
                  Container(
                    width: 50,
                    child: CustomTextField(
                        controller: this.babiesCount,
                        inputType: TextInputType.number,
                        hint: "",
                        isObsecured: false,
                        isCenteredInput: true,
                        maxLength: 1,
                        icon: Icons.code),
                  ),
                ],
              ),
              SizedBox(height: 20),
              Row(
                textDirection: translator.activeLanguageCode == "en"
                    ? this.textDirection[0]
                    : this.textDirection[1],
                children: [
                  SizedBox(width: 35),
                  Text(
                    "Include transportation".tr(),
                    style: TextStyle(
                      color: CustomColors.primary,
                    ),
                  ),
                  SizedBox(width: 10),
                  DropdownButton(
                    isDense: true,
                    elevation: 16,
                    iconEnabledColor: CustomColors.primary,
                    value: this.includeTransportation ? "Yes".tr() : "No".tr(),
                    icon: Icon(
                      Icons.arrow_drop_down,
                      size: 26,
                    ),
                    items: ["Yes".tr(), "No".tr()].map((String items) {
                      return DropdownMenuItem(
                        value: items,
                        child: Text(items),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      setState(() {
                        this.includeTransportation = (newValue == "Yes".tr());
                      });
                    },
                  ),
                ],
              ),
              SizedBox(height: 30),
              if (this.includeTransportation)
                Row(
                  textDirection: translator.activeLanguageCode == "en"
                      ? this.textDirection[0]
                      : this.textDirection[1],
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "From".tr(),
                      style: TextStyle(
                        color: CustomColors.primary,
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButton(
                      isDense: true,
                      elevation: 16,
                      iconEnabledColor: CustomColors.primary,
                      value: this.transportationFrom!.tr(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 26,
                      ),
                      items: [
                        "Jordan".tr(),
                        "King Hussein Bridge".tr(),
                        "Sheikh Hussein Bridge".tr()
                      ].map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          this.transportationFrom = newValue;
                          if (newValue == "Jordan".tr())
                            this.includeCity = true;
                        });
                      },
                    ),
                  ],
                ),
              if (this.includeTransportation) SizedBox(height: 30),
              if (this.includeTransportation &&
                  this.transportationFrom == "Jordan".tr() &&
                  this.includeCity)
                Row(
                  textDirection: translator.activeLanguageCode == "en"
                      ? this.textDirection[0]
                      : this.textDirection[1],
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "City".tr(),
                      style: TextStyle(
                        color: CustomColors.primary,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: screenWidth * 0.5,
                      height: 40,
                      child: CustomTextField(
                        controller: this.city,
                        inputType: TextInputType.name,
                        hint: "City".tr(),
                        isObsecured: false,
                        isCenteredInput: false,
                        maxLength: 20,
                        icon: Icons.location_on,
                      ),
                    ),
                  ],
                ),

              if (this.includeTransportation &&
                  this.transportationFrom == "Jordan".tr() &&
                  this.includeCity)
                SizedBox(height: 30),
              if (this.includeTransportation)
                Row(
                  textDirection: translator.activeLanguageCode == "en"
                      ? this.textDirection[0]
                      : this.textDirection[1],
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "To".tr(),
                      style: TextStyle(
                        color: CustomColors.primary,
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButton(
                      isDense: true,
                      elevation: 16,
                      iconEnabledColor: CustomColors.primary,
                      value: this.transportationTo!.tr(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 26,
                      ),
                      items: [
                        "Jordan".tr(),
                        "King Hussein Bridge".tr(),
                        "Sheikh Hussein Bridge".tr()
                      ].map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          this.transportationTo = newValue;
                          if (newValue == "Jordan".tr())
                            this.includeCity = true;
                        });
                      },
                    ),
                  ],
                ),
              if (this.includeTransportation &&
                  this.transportationTo == "Jordan".tr() &&
                  this.includeCity)
                SizedBox(height: 30),

              if (this.includeTransportation &&
                  this.transportationTo == "Jordan".tr() &&
                  this.includeCity)
                Row(
                  textDirection: translator.activeLanguageCode == "en"
                      ? this.textDirection[0]
                      : this.textDirection[1],
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "City".tr(),
                      style: TextStyle(
                        color: CustomColors.primary,
                      ),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: screenWidth * 0.5,
                      height: 40,
                      child: CustomTextField(
                        controller: this.city,
                        inputType: TextInputType.name,
                        hint: "City".tr(),
                        isObsecured: false,
                        isCenteredInput: false,
                        maxLength: 20,
                        icon: Icons.location_on,
                      ),
                    ),
                  ],
                ),
              if (this.includeTransportation) SizedBox(height: 15),
              if (this.includeTransportation)
                Row(
                  textDirection: translator.activeLanguageCode == "en"
                      ? this.textDirection[0]
                      : this.textDirection[1],
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "Number of passengers".tr(),
                      style: TextStyle(color: CustomColors.primary),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 50,
                      child: CustomTextField(
                          controller: this.passengersCount,
                          inputType: TextInputType.number,
                          hint: "",
                          isObsecured: false,
                          isCenteredInput: true,
                          maxLength: 1,
                          icon: Icons.code),
                    ),
                  ],
                ),
              if (this.includeTransportation) SizedBox(height: 15),
              if (this.includeTransportation)
                Row(
                  textDirection: translator.activeLanguageCode == "en"
                      ? this.textDirection[0]
                      : this.textDirection[1],
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "Number of bags".tr(),
                      style: TextStyle(color: CustomColors.primary),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: 50,
                      child: CustomTextField(
                          controller: this.bagsCount,
                          inputType: TextInputType.number,
                          hint: "",
                          isObsecured: false,
                          isCenteredInput: true,
                          maxLength: 1,
                          icon: Icons.code),
                    ),
                  ],
                ),
              if (this.includeTransportation) SizedBox(height: 30),
              if (this.includeTransportation)
                Row(
                  textDirection: translator.activeLanguageCode == "en"
                      ? this.textDirection[0]
                      : this.textDirection[1],
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "Vehicle type".tr(),
                      style: TextStyle(
                        color: CustomColors.primary,
                      ),
                    ),
                    SizedBox(width: 10),
                    DropdownButton(
                      isDense: true,
                      elevation: 16,
                      iconEnabledColor: CustomColors.primary,
                      value: this.vehicleType!.tr(),
                      icon: Icon(
                        Icons.arrow_drop_down,
                        size: 26,
                      ),
                      items: [
                        "Car".tr(),
                        "Van".tr(),
                      ].map((String items) {
                        return DropdownMenuItem(
                          value: items,
                          child: Text(items),
                        );
                      }).toList(),
                      onChanged: (String? newValue) {
                        setState(() {
                          this.vehicleType = newValue;
                        });
                      },
                    ),
                  ],
                ),
              if (this.includeTransportation) SizedBox(height: 30),
              if (this.includeTransportation)
                Row(
                  textDirection: translator.activeLanguageCode == "en"
                      ? this.textDirection[0]
                      : this.textDirection[1],
                  children: [
                    SizedBox(width: 35),
                    Text(
                      "Notes".tr(),
                      style: TextStyle(color: CustomColors.primary),
                    ),
                    SizedBox(width: 10),
                    Container(
                      width: screenWidth * 0.5,
                      height: 40,
                      child: CustomTextField(
                        controller: this.notes,
                        inputType: TextInputType.name,
                        hint: "Notes".tr(),
                        isObsecured: false,
                        isCenteredInput: false,
                        maxLength: 20,
                        icon: Icons.notes,
                      ),
                    ),
                  ],
                ),

              SizedBox(height: 25),
              Container(
                width: screenWidth * 0.9,
                child: ElevatedButton(
                  child: Text("Send".tr()),
                  onPressed: () async {
                    if (travelersCount.text.isNotEmpty &&
                            adultsCount.text.isNotEmpty &&
                            childrenCount.text.isNotEmpty &&
                            babiesCount.text.isNotEmpty &&
                            !includeTransportation ||
                        (includeTransportation &&
                            !includeCity &&
                            passengersCount.text.isNotEmpty &&
                            bagsCount.text.isNotEmpty) ||
                        (includeTransportation &&
                            includeCity &&
                            city.text.isNotEmpty &&
                            passengersCount.text.isNotEmpty &&
                            bagsCount.text.isNotEmpty)) {
                      setState(() {
                        this.showSpinner = true;
                      });

                      Fluttertoast.showToast(
                        msg: "Your reservation has sent successfully".tr(),
                        backgroundColor: Colors.green,
                      );

                      setState(() {
                        this.showSpinner = false;
                      });
                    } else
                      Fluttertoast.showToast(
                        msg: "Please fill all fields".tr(),
                        backgroundColor: Colors.red,
                      );
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: Size.fromHeight(40),
                  ),
                ),
              ),
              SizedBox(height: 15),

// Number of people traveling:
// Adults (Above 16 years of age)
// Children (From 3 years of age to 16 years of age)
// Babies (Below 3 years of age)
            ],
          ),
        ),
      ),
    );
  }
}

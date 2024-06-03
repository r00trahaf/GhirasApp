import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:ghiras/Model/weatherModel.dart';
import 'package:ghiras/widgets/commonColor.dart';
import 'package:ghiras/widgets/extensions.dart';
import 'package:intl/intl.dart';
import '../../widgets/assets.dart';
import '../../Api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;


class weather extends StatefulWidget {
  const weather({super.key});

  @override
  State<weather> createState() => _weatherState();
}

class _weatherState extends State<weather> {

  DateTime now = DateTime.now();
  String formattedDate = DateFormat('EEE d MMM').format(DateTime.now());
  bool? isAfterNoon;
  bool isWeatherDataLoading = false;
  String? _cityName;
  WeatherModel? weatherModel;


  @override
  void initState() {
    super.initState();
    _getLocationAndWeather();
  }

  Future<void> _getLocationAndWeather() async {
    final permissionGranted = await _handleLocationPermission();
    if (permissionGranted) {
      await _getCurrentPosition();
    }
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      await _getCurrentPosition();
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content:
        Text('Location services are disabled. Please enable the services'),
      ));
      return false;
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Location permissions are denied'),
        ));
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
        content: Text(
            'Location permissions are permanently denied, we cannot request permissions.'),
      ));
      return false;
    }
    return true;
  }

  Future<void> _getCurrentPosition() async {
    try {
      Position position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
      _getLocalityName(position);
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  Future<void> _getLocalityName(Position position) async {
    try {
      List<Placemark> placemarks = await placemarkFromCoordinates(position.latitude, position.longitude);
      String city = placemarks[0].locality ?? '';
      setState(() {
        _cityName = city.isNotEmpty ? city : 'Unknown';
        weatherData(context: context, location: _cityName.toString());
      });
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  String getWeatherDescription(int weatherCode) {
    switch (weatherCode) {
      case 1000:
      case 10000:
        return 'Clear';

      case 1001:
      case 10011:
        return 'Cloudy';

      case 2000:
        return 'Fog';

      case 4000:
      case 4200:
        return 'Drizzle';

      case 4201:
      case 42011:
        return 'Heavy Rain';

      case 1063:
        return 'Patchy rain possible';

      case 4001:
        return 'Rain';

      case 1066:
        return 'Patchy snow possible';

      case 1100:
      case 11000:
        return 'Mostly Clear';

      case 1101:
      case 11011:
        return 'Partly Cloudy';
      default:
        return 'Unknown';
    }
  }

  Future weatherData({required BuildContext context, required String location}) async {
    http.Response response = await Api.weatherApi(location: location.toString());
    var data = convert.jsonDecode(response.body);
    if ((response.statusCode == 200 || response.statusCode == 201) ) {
      weatherModel = WeatherModel.fromJson(data);
      debugPrint("response  ${response.body}");
      setState(() {
        isWeatherDataLoading = true;
      });
      return 1;
    } else if (response.statusCode  == 401) {
      setState(() {
        isWeatherDataLoading = false;
      });
      return 0;
    } else if (response.statusCode  == 404) {
      setState(() {
        isWeatherDataLoading = false;
      });
      return 0;
    } else if (response.statusCode  == 400) {
      setState(() {
        isWeatherDataLoading = false;
      });
      return 0;
    } else if (response.statusCode  == 500) {
      setState(() {
        isWeatherDataLoading = false;
      });
      return 0;
    } else {
      setState(() {
        isWeatherDataLoading = false;
      });
      return 0;
    }
  }


  @override
  Widget build(BuildContext context) {
    return isWeatherDataLoading == false ? Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(
          color: CommonColor.borderColor,
        ),
      ),
    ):Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: Container(
            height: 72,
            width: 288,
            decoration: BoxDecoration(boxShadow: const [
              BoxShadow(
                color: Colors.grey,
                offset: Offset(
                  0.0,
                  2.0,
                ),
                blurRadius: 0.10,
                spreadRadius: 0.10,
              ),
            ], color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  "$_cityName" == null ? "" : _cityName!,
                  style: TextStyle(color: "#8FBDC4".toHexa(), fontSize: 15),
                ),
                InkWell(
                  onTap: () {},
                  child: Image.asset(
                    Assets.shared.MapBlue,
                  ),
                ),
                InkWell(
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                  child: Image.asset(
                    Assets.shared.HomeBlue,
                  ),
                ),
              ],
            )),
        backgroundColor: Colors.white,
        body: Center(
          child: SingleChildScrollView(
            physics: const NeverScrollableScrollPhysics(),
            child:  Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 30, top: 50),
                    child: Text(
                      formattedDate == null ? "" : formattedDate!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 20, color: "#C4E1E8".toHexa()),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 30),
                    child: Text(
                      "$_cityName" == null ? "" : _cityName!,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30, color: "#89B1B8".toHexa()),
                    ),
                  ),
                  Center(
                    child: Image.asset(
                      Assets.shared.cloudy,
                    ),
                  ),
                  Center(
                    child: Text(
                      getWeatherDescription(int.parse(weatherModel!.data!.timelines![0].intervals![0].values!.weatherCode.toString())),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 30, color: "#89B1B8".toHexa()),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Text(
                            "${weatherModel!.data!.timelines![0].intervals![0].values!.precipitationProbability.toString().split('.')[0]}%",
                            style: TextStyle(
                                fontSize: 40, color: "#A4D5DD".toHexa()),
                          ),
                          Text(
                            "الامطار",
                            style: TextStyle(
                                fontSize: 15, color: "#8FBDC4".toHexa()),
                          ),
                        ],
                      ),
                      Image.asset(
                        Assets.shared.Line,
                      ),
                      Column(
                        children: [
                          Text(
                            "${weatherModel!.data!.timelines![0].intervals![0].values!.temperature.toString().split('.')[0]}C",
                            style: TextStyle(
                                fontSize: 40, color: "#A4D5DD".toHexa()),
                          ),
                          Text(
                            "درجة الحرارة",
                            style: TextStyle(
                                fontSize: 15, color: "#8FBDC4".toHexa()),
                          ),
                        ],
                      ),
                      Image.asset(
                        Assets.shared.Line,
                      ),
                      Column(
                        children: [
                          Text(
                            "${weatherModel!.data!.timelines![0].intervals![0].values!.humidity.toString().split('.')[0]}%",
                            style: TextStyle(
                                fontSize: 40, color: "#A4D5DD".toHexa()),
                          ),
                          Text(
                            "الرطوبة",
                            style: TextStyle(
                                fontSize: 15, color: "#8FBDC4".toHexa()),
                          ),
                        ],
                      )
                    ],
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                          color: "#C4E1E8".toHexa(),
                          offset: const Offset(
                            0.0,
                            50.0,
                          ),
                          blurRadius: 0.10,
                          spreadRadius: 0.10,
                        ),
                      ],
                      color: "#C4E1E8".toHexa(),
                      borderRadius:
                      const BorderRadius.all(Radius.circular(30)),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Padding(
                          padding:
                          EdgeInsets.only(left: 30, right: 30, top: 20),
                          child: Row(
                            mainAxisAlignment:
                            MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "اليوم",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 25),
                              ),
                              Icon(
                                CupertinoIcons.right_chevron,
                                color: Colors.white,
                                size: 25,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        SizedBox(
                          height: (MediaQuery.of(context).size.height * 0.13).ceilToDouble(),
                          child: ListView.builder(
                            itemCount: 7,
                            shrinkWrap: true,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              String apiTime = weatherModel!.data!.timelines![0].intervals![index].startTime.toString();
                              DateTime apiDateTime = DateTime.parse(apiTime);
                              DateTime utcPlus3DateTime = apiDateTime.add(const Duration(hours: 3));
                              isAfterNoon = utcPlus3DateTime.hour >= 00;
                              return Container(
                                width: 81,
                                decoration: BoxDecoration(
                                  color: "#e4f1f4".toHexa(),
                                  borderRadius: const BorderRadius.all(
                                      Radius.circular(30)),
                                ),
                                margin: const EdgeInsets.only(
                                    right: 8), // Adjust margin as needed
                                child: Column(
                                  mainAxisAlignment:
                                  MainAxisAlignment.center,
                                  children: [
                                    Image.asset(
                                      Assets.shared.sun,
                                    ),
                                    Text(
                                      DateFormat.Hm().format(utcPlus3DateTime), // Display time adjusted to UTC+3
                                    ),

                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ]),
          ),
        ));
  }
}

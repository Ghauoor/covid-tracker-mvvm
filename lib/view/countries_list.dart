import 'package:covid_tracker/Services/states_services.dart';
import 'package:flutter/services.dart';

import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';
import 'package:share/share.dart';


import 'country_details_screen.dart';

class CountriesList extends StatefulWidget {
  const CountriesList({Key? key}) : super(key: key);

  @override
  State<CountriesList> createState() => _CountriesListState();
}

class _CountriesListState extends State<CountriesList> {
  final TextEditingController _searchEditingController =
      TextEditingController();
  final StatesServices _statesServices = StatesServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  FocusScope.of(context).requestFocus(FocusNode());
                  SystemChannels.textInput.invokeMethod('TextInput.hide');
                },
                child: TextFormField(
                  controller: _searchEditingController,
                  onChanged: (val) {
                    setState(() {});
                  },
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                    hintText: 'Search with Country name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: FutureBuilder(
                future: _statesServices.countriesListApi(),
                builder: (context, AsyncSnapshot<List<dynamic>> snapshot) {
                  if (!snapshot.hasData) {
                    return Shimmer.fromColors(
                      baseColor: Colors.white,
                      highlightColor: Colors.grey.shade700,
                      child: ListView.builder(
                        itemCount: 10,
                        itemBuilder: (context, index) {
                          return ListTile(
                            title: Container(
                              height: 10,
                              width: 80,
                              color: Colors.white,
                            ),
                            subtitle: Container(
                              height: 10,
                              width: 80,
                              color: Colors.white,
                            ),
                            leading: Container(
                              height: 50,
                              width: 50,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    );
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        String name =
                            snapshot.data![index]['country'].toString();
                        if (_searchEditingController.text.isEmpty) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  snapshot.data![index]['country'].toString(),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                ),
                                leading: CachedNetworkImage(
                                  height: 50,
                                  width: 50,
                                  imageUrl: snapshot.data![index]['countryInfo']
                                      ['flag'],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountryDetailsPage(
                                        countryData: snapshot.data![index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else if (name.toLowerCase().contains(
                            _searchEditingController.text.toLowerCase())) {
                          return Column(
                            children: [
                              ListTile(
                                title: Text(
                                  snapshot.data![index]['country'].toString(),
                                ),
                                subtitle: Text(
                                  snapshot.data![index]['cases'].toString(),
                                ),
                                leading: CachedNetworkImage(
                                  height: 50,
                                  width: 50,
                                  imageUrl: snapshot.data![index]['countryInfo']
                                      ['flag'],
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                      value: downloadProgress.progress,
                                      color: Colors.white,
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => CountryDetailsPage(
                                        countryData: snapshot.data![index],
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ],
                          );
                        } else {
                          return Container();
                        }
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

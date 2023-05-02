import 'package:covid_tracker/View/world_stats.dart';
import 'package:flutter/material.dart';
import 'package:share/share.dart';

class CountryDetailsPage extends StatefulWidget {
  final Map<String, dynamic> countryData;

  const CountryDetailsPage({Key? key, required this.countryData})
      : super(key: key);

  @override
  _CountryDetailsPageState createState() => _CountryDetailsPageState();
}

class _CountryDetailsPageState extends State<CountryDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        title: Text(widget.countryData['country']),
        shadowColor: Colors.grey.shade100,
        actions: [
          IconButton(
            icon: const Icon(Icons.share),
            onPressed: () {
              Share.share('Country: ${widget.countryData['country']}\n'
                  'Cases: ${widget.countryData['cases']}\n'
                  'Today Cases: ${widget.countryData['todayCases']}\n'
                  'Deaths: ${widget.countryData['deaths']}\n'
                  'Recovered: ${widget.countryData['recovered']}\n'
                  'Active: ${widget.countryData['active']}\n'
                  'Tests: ${widget.countryData['tests']}\n'
                  'Continent: ${widget.countryData['continent']}');
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              alignment: Alignment.topCenter,
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height * .066,
                    // horizontal: MediaQuery.of(context).size.height * .001,
                  ),
                  child: Card(
                    color: Colors.grey.shade700,
                    child: Column(
                      children: [
                        SizedBox(
                            height: MediaQuery.of(context).size.height * .067),
                        ReusableRow(
                          title: 'Cases',
                          value: widget.countryData['cases'].toString(),
                        ),
                        ReusableRow(
                          title: 'Today Cases',
                          value: widget.countryData['todayCases'].toString(),
                        ),
                        ReusableRow(
                          title: 'Deaths',
                          value: widget.countryData['deaths'].toString(),
                        ),
                        ReusableRow(
                          title: 'Recovered',
                          value: widget.countryData['recovered'].toString(),
                        ),
                        ReusableRow(
                          title: 'Cases',
                          value: widget.countryData['cases'].toString(),
                        ),
                        ReusableRow(
                          title: 'Active',
                          value: widget.countryData['active'].toString(),
                        ),
                        ReusableRow(
                          title: 'Tests',
                          value: widget.countryData['tests'].toString(),
                        ),
                        ReusableRow(
                          title: 'Continent',
                          value: widget.countryData['continent'].toString(),
                        ),
                      ],
                    ),
                  ),
                ),
                CircleAvatar(
                  radius: 50,
                  backgroundImage:
                      NetworkImage(widget.countryData['countryInfo']['flag']),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

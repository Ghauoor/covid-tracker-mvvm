import 'package:covid_tracker/Model/world_state_model.dart';
import 'package:flutter/material.dart';
import 'package:pie_chart/pie_chart.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../Services/states_services.dart';
import './countries_list.dart';

class WorldStatsScreen extends StatefulWidget {
  const WorldStatsScreen({super.key});

  @override
  State<WorldStatsScreen> createState() => _WorldStatsScreenState();
}

class _WorldStatsScreenState extends State<WorldStatsScreen>
    with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  final colorList = <Color>[
    const Color(0xff4285f4),
    const Color(0xff1aa260),
    const Color(0xffde5246)
  ];

  @override
  Widget build(BuildContext context) {
    StatesServices statesServices = StatesServices();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              SizedBox(height: MediaQuery.of(context).size.height * .01),
              FutureBuilder(
                  future: statesServices.fetchWorldStatesRecords(),
                  builder: (context, AsyncSnapshot<WorldStatesModel> snapshot) {
                    statesServices.fetchWorldStatesRecords();
                    if (!snapshot.hasData) {
                      return Expanded(
                        flex: 1,
                        child: SpinKitFadingCircle(
                          color: Colors.white,
                          size: 50,
                          controller: _controller,
                        ),
                      );
                    } else {
                      return Column(
                        children: [
                          PieChart(
                            dataMap: {
                              "Total": double.parse(
                                  snapshot.data!.cases!.toString()),
                              "Recovered": double.parse(
                                  snapshot.data!.recovered!.toString()),
                              "Deaths": double.parse(
                                  snapshot.data!.deaths!.toString())
                            },
                            animationDuration:
                                const Duration(milliseconds: 1200),
                            chartType: ChartType.ring,
                            colorList: colorList,
                            chartRadius:
                                MediaQuery.of(context).size.width / 3.2,
                            legendOptions: const LegendOptions(
                              legendPosition: LegendPosition.left,
                            ),
                            chartValuesOptions: const ChartValuesOptions(
                              showChartValuesInPercentage: true,
                              showChartValueBackground: true,
                              decimalPlaces: 2,
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.symmetric(
                              vertical:
                                  MediaQuery.of(context).size.height * .06,
                            ),
                            child: Card(
                              child: Column(
                                children: [
                                  ReusableRow(
                                      title: 'Total',
                                      value: snapshot.data!.cases!.toString()),
                                  ReusableRow(
                                      title: 'Recovered',
                                      value: snapshot.data!.cases!.toString()),
                                  ReusableRow(
                                      title: 'Deaths',
                                      value: snapshot.data!.deaths!.toString()),
                                  ReusableRow(
                                      title: 'Active',
                                      value: snapshot.data!.active!.toString()),
                                  ReusableRow(
                                      title: 'Today Recovered',
                                      value: snapshot.data!.todayRecovered!
                                          .toString()),
                                ],
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CountriesList(),
                                ),
                              );
                            },
                            child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: colorList[1],
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: const Center(
                                child: Text('Track Countires'),
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }),
            ],
          ),
        ),
      ),
    );
  }
}

class ReusableRow extends StatelessWidget {
  //Todo: Remove Final and const in case of error
  final String title, value;
  const ReusableRow({
    Key? key,
    required this.title,
    required this.value,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          const SizedBox(height: 5.0),
          const Divider(),
        ],
      ),
    );
  }
}

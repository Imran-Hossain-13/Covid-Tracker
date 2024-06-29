import 'package:covid_tracker/Services/world_state_service.dart';
import 'package:covid_tracker/View/country_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:pie_chart/pie_chart.dart';

class WorldState extends StatefulWidget {
  const WorldState({super.key});

  @override
  State<WorldState> createState() => _WorldStateState();
}

class _WorldStateState extends State<WorldState> with TickerProviderStateMixin {
  late final AnimationController _animeController = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat();
  @override
  void dispose() {
    // TODO: implement dispose
    _animeController.dispose();
    super.dispose();
  }
  final colorList = <Color>[
    const Color(0xff4285F4),
    const Color(0xff1aa260),
    const Color(0xffde5246),
  ];

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    WorldStateService worldStateService = WorldStateService();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              SizedBox(height: size.height * .04,),
              Expanded(child: FutureBuilder(
                future: worldStateService.fetchWorldStateRecord(),
                builder: (context, snapshot){
                  if(snapshot.hasData){
                    return Column(
                      children: [
                        PieChart(
                          dataMap: {
                            'Total': snapshot.data!.cases!.toDouble(),
                            'Recovered': snapshot.data!.recovered!.toDouble(),
                            'Death': snapshot.data!.deaths!.toDouble(),
                          },
                          animationDuration: Duration(milliseconds: 1200),
                          chartRadius: size.width * .35,
                          chartType: ChartType.ring,
                          legendOptions: const LegendOptions(legendPosition: LegendPosition.left),
                          chartValuesOptions: const ChartValuesOptions(showChartValuesInPercentage: true),
                          colorList: colorList,
                        ),
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: size.height * .08,),
                          child: Card(
                            child: Column(
                              children: [
                                ReusableRow(title: 'Total', value: snapshot.data!.cases!.toString()),
                                ReusableRow(title: 'Death', value: snapshot.data!.deaths!.toString()),
                                ReusableRow(title: 'Recovered', value: snapshot.data!.recovered!.toString()),
                                ReusableRow(title: 'Active', value: snapshot.data!.active!.toString()),
                                ReusableRow(title: 'Critical', value: snapshot.data!.critical!.toString()),
                                ReusableRow(title: 'Today Death', value: snapshot.data!.todayDeaths!.toString()),
                                ReusableRow(title: 'Today Recovered', value: snapshot.data!.todayRecovered!.toString()),
                              ],
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>const CountryList()));
                          },
                          child: Container(
                            height: 50,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: const Color(0xff1aa260)
                            ),
                            child: const Center(child: Text("Track Countries"),),
                          ),
                        )],
                    );
                  }else{
                    return SpinKitSpinningLines(
                      controller: _animeController,
                      size: 120,
                      color: Colors.teal,
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}


class ReusableRow extends StatelessWidget {
  final String title;
  final String value;
  const ReusableRow({super.key, required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10,right: 10,top: 13,bottom: 5),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title),
              Text(value),
            ],
          ),
          // const SizedBox(height: 2,),
          const Divider()
        ],
      ),
    );
  }
}

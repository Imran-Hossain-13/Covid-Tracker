import 'package:covid_tracker/View/world_state.dart';
import 'package:flutter/material.dart';

class DetailScreen extends StatefulWidget {
  final String name;
  final String image;
  final int totalCases, totalDeath, totalRecovered, active, critical, todayRecovered, test;
  const DetailScreen({
    super.key,
    required this.name, required this.image, required this.totalCases,
    required this.totalDeath, required this.totalRecovered, required this.active,
    required this.critical, required this.todayRecovered, required this.test
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: (){
            Navigator.pop(context);
          },
          icon: const Icon(Icons.arrow_back_ios,size: 35,),
        ),
        title: Text(widget.name),
        centerTitle: true,
        automaticallyImplyLeading: false,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              Padding(
                padding: EdgeInsets.only(top: size.height * .067),
                child: Card(
                  child: Column(
                    children: [
                      SizedBox(height: size.height * .06,),
                      ReusableRow(title: "Total", value: widget.totalCases.toString()),
                      ReusableRow(title: "Death", value: widget.totalDeath.toString()),
                      ReusableRow(title: "Recovered", value: widget.todayRecovered.toString()),
                      ReusableRow(title: "Active", value: widget.active.toString()),
                      ReusableRow(title: "Critical", value: widget.critical.toString()),
                      ReusableRow(title: "Today Death", value: widget.totalDeath.toString()),
                      ReusableRow(title: "Today Recovered", value: widget.todayRecovered.toString()),
                    ],
                  ),
                ),
              ),
              CircleAvatar(
                radius: 50,
                backgroundImage: NetworkImage(widget.image),
              )
            ],
          ),
        ],
      ),
      resizeToAvoidBottomInset: false,
    );
  }
}

import 'package:covid_tracker/Services/world_state_service.dart';
import 'package:covid_tracker/View/detail_screen.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class CountryList extends StatefulWidget {
  const CountryList({super.key});

  @override
  State<CountryList> createState() => _CountryListState();
}

class _CountryListState extends State<CountryList> {
  TextEditingController searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    WorldStateService worldStateService = WorldStateService();
    Size size =MediaQuery.of(context).size;
    return GestureDetector(
      onTap: (){FocusScope.of(context).unfocus();},
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          leading: Padding(
            padding: const EdgeInsets.only(left: 15),
            child: IconButton(
              onPressed: (){Navigator.pop(context);},
              icon: const Icon(Icons.arrow_back_ios,size: 35,),
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              TextFormField(
                controller: searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(20),
                  hintText: "Search by country name",
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: BorderSide(color: Colors.blue.shade200,width: 2),
                  ),
                ),
                onChanged: (value){
                  setState(() {

                  });
                },
              ),
              const SizedBox(height: 20,),
              Expanded(child: FutureBuilder(
                future: worldStateService.fetchWorldName(),
                builder: (context,AsyncSnapshot<List<dynamic>> snapshot){
                  if(snapshot.hasData){
                    return ListView.builder(
                          itemCount: snapshot.data!.length,
                          itemBuilder: (context, index){
                            String countryName = snapshot.data![index]["country"].toString();
                            if(searchController.text.isEmpty){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                    name: countryName,
                                    image: snapshot.data![index]["countryInfo"]["flag"],
                                    totalCases: snapshot.data![index]["cases"],
                                    totalDeath: snapshot.data![index]["deaths"],
                                    totalRecovered: snapshot.data![index]["recovered"],
                                    active: snapshot.data![index]["active"],
                                    critical: snapshot.data![index]["critical"],
                                    todayRecovered: snapshot.data![index]["todayRecovered"],
                                    test: snapshot.data![index]["tests"],
                                  )));
                                },
                                child: ListTile(
                                    leading: Image(
                                      image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"]),
                                      height: 50,
                                      width: 50,
                                    ),
                                    title: Text(snapshot.data![index]["country"].toString()),
                                    subtitle: Text(snapshot.data![index]["cases"].toString()),
                                  ),
                              );
                            }else if(countryName.toLowerCase().contains(searchController.text.toLowerCase())){
                              return InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context)=>DetailScreen(
                                    name: countryName,
                                    image: snapshot.data![index]["countryInfo"]["flag"],
                                    totalCases: snapshot.data![index]["cases"],
                                    totalDeath: snapshot.data![index]["deaths"],
                                    totalRecovered: snapshot.data![index]["recovered"],
                                    active: snapshot.data![index]["active"],
                                    critical: snapshot.data![index]["critical"],
                                    todayRecovered: snapshot.data![index]["todayRecovered"],
                                    test: snapshot.data![index]["tests"],
                                  )));
                                },
                                child: ListTile(
                                  leading: Image(
                                    image: NetworkImage(snapshot.data![index]["countryInfo"]["flag"]),
                                    height: 50,
                                    width: 50,
                                  ),
                                  title: Text(snapshot.data![index]["country"].toString()),
                                  subtitle: Text(snapshot.data![index]["cases"].toString()),
                                ),
                              );
                            }else{
                              return Container();
                            }
                          }
                      );
                  }else{
                    return ListView.builder(
                        itemCount: size.height~/90,
                        itemBuilder: (context, index){
                          return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            child: Column(
                              children: [
                                ListTile(
                                  leading: Container(height: 50,width: 50,color: Colors.white,),
                                  title: Container(height: 10,width: size.width * .9,color: Colors.white),
                                  subtitle: Container(height: 10,width: size.width * .9,color: Colors.white),
                                ),
                              ],
                            ),
                          );
                        }
                    );
                  }
                },
              )),
            ],
          ),
        ),
      ),
    );
  }
}

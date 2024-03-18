import 'package:flutter/material.dart';
import 'package:vlille/api_model.dart';
import 'package:vlille/station_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController stationTextController = TextEditingController();
  String station = "";
  late Future<List<dynamic>> veloDataFuture;
  int limit = 100;

  @override
  void initState() {
    super.initState();
    // Initial loading of data
    veloDataFuture = getVlilleData(limit, station);
  }

  Future<List<dynamic>> getVlilleData(int limit, String station) async {
    return await ApiModel.getData(limit, station);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("V'Lille data"),
        centerTitle: true,
        backgroundColor: Colors.blue.shade900,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: stationTextController,
              decoration: InputDecoration(
                labelText: 'Enter station name',
                suffixIcon: IconButton(
                  onPressed: () {
                    setState(() {
                      veloDataFuture =
                          getVlilleData(limit, stationTextController.text);
                    });
                  },
                  icon: const Icon(Icons.search),
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async {
                setState(() {
                  veloDataFuture =
                      getVlilleData(limit, stationTextController.text);
                });
              },
              child: FutureBuilder(
                future: veloDataFuture,
                builder: ((context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        backgroundColor: Colors.blue,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text('No data for this station'),
                    );
                  } else {
                    final veloData = snapshot.data as List<dynamic>;
                    final displayData = veloData.map((data) {
                      final singleData = StationModel.fromJson(data);
                      return Card(
                        shadowColor: Colors.blue.shade900,
                        elevation: 3,
                        child: ListTile(
                          title: Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Nom",
                                          style: TextStyle(color: Colors.green),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(singleData.nom)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Adresse",
                                          style: TextStyle(color: Colors.green),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(singleData.adresse)
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Commune",
                                          style: TextStyle(color: Colors.green),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(singleData.commune)
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Vélos disponibles",
                                          style: TextStyle(
                                              color: Colors.deepPurple),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          "${singleData.nbvelosdispo}",
                                          style: const TextStyle(
                                              fontSize: 25, color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Places disponibles",
                                          style: TextStyle(
                                              color: Colors.deepPurple),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          "${singleData.nbplacesdispo}",
                                          style: const TextStyle(
                                              fontSize: 25, color: Colors.blue),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Expanded(
                                    child: Column(
                                      children: [
                                        const Text(
                                          "Etat",
                                          style: TextStyle(
                                              color: Colors.deepPurple),
                                          overflow: TextOverflow.clip,
                                        ),
                                        Text(
                                          singleData.etat,
                                          style: const TextStyle(
                                              color: Colors.deepOrangeAccent),
                                          overflow: TextOverflow.clip,
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    }).toList();
                    return ListView(
                      children: [
                        ...displayData,
                      ],
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

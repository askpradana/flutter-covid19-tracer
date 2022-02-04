import 'package:covid_tracer/api/webservice.dart';
import 'package:covid_tracer/components/text.dart';
import 'package:flutter/material.dart';
import 'package:humanize_big_int/humanize_big_int.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class Model {
  final String negara;
  final int konfirmasi;
  final int sembuh;
  final int kritis;
  final int meninggal;
  final String lastUpdate;

  Model({
    required this.negara,
    required this.konfirmasi,
    required this.sembuh,
    required this.kritis,
    required this.meninggal,
    required this.lastUpdate,
  });

  factory Model.fromJson(Map<String, dynamic> json) {
    return Model(
      negara: json['country'],
      konfirmasi: json['confirmed'],
      sembuh: json['recovered'],
      kritis: json['critical'],
      meninggal: json['deaths'],
      lastUpdate: json['lastUpdate'],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Model> future;

  @override
  void initState() {
    super.initState();
    future = fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(0),
          child: AppBar(
            backgroundColor: Colors.white,
            elevation: 0,
          ),
        ),
        backgroundColor: Colors.white,
        body: SafeArea(
          child: FutureBuilder<Model>(
            future: future,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return BuildHomePage(snapshot: snapshot);
              } else if (snapshot.hasError) {
                return const Center(child: Text('Ada masalah'));
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ));
  }
}

List<String> dropdownItem = [
  'Indonesia',
  'Inggris',
  'USA',
];

class BuildHomePage extends StatefulWidget {
  const BuildHomePage({Key? key, required this.snapshot}) : super(key: key);

  final AsyncSnapshot snapshot;

  @override
  State<BuildHomePage> createState() => _BuildHomePageState();
}

class _BuildHomePageState extends State<BuildHomePage> {
  String choosenVal = 'Indonesia';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  TextTitle(
                    text: 'Spread',
                    fontWeight: FontWeight.normal,
                  ),
                  TextTitle(
                    text: 'Statistic',
                  ),
                ],
              ),
              DropdownButton(
                  value: choosenVal,
                  items: dropdownItem.map((e) {
                    return DropdownMenuItem(child: Text(e), value: e);
                  }).toList(),
                  onChanged: (String? val) {
                    //TODO => ubah jadi stateless
                    setState(() {
                      choosenVal = val!;
                    });
                  })
            ],
          ),
          const Spacer(),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 32,
                child: Card(
                  child: Column(
                    children: [
                      Text(
                        humanizeInt(widget.snapshot.data!.konfirmasi),
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide / 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Text('Confirmed'),
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 32,
                child: Card(
                  child: Column(
                    children: [
                      Text(
                        humanizeInt(widget.snapshot.data!.meninggal),
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide / 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Text('Death')
                    ],
                  ),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width / 3 - 16,
                child: Card(
                  child: Column(
                    children: [
                      Text(
                        humanizeInt(widget.snapshot.data!.sembuh),
                        style: TextStyle(
                          fontSize:
                              MediaQuery.of(context).size.shortestSide / 12,
                          fontWeight: FontWeight.w300,
                        ),
                      ),
                      const Text('Recovered')
                    ],
                  ),
                ),
              ),
            ],
          ),
          Center(
            child: SizedBox(
              height: MediaQuery.of(context).size.shortestSide / 8,
              width: MediaQuery.of(context).size.shortestSide / 4,
              child: Card(
                color: Colors.purple,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const IconButton(
                      onPressed: null,
                      icon: Icon(
                        Icons.person_outlined,
                        color: Colors.white,
                      ),
                    ),
                    const Divider(
                      height: 2,
                      color: Colors.black,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.bar_chart_outlined,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Text('Update terakhir pada : ${widget.snapshot.data!.lastUpdate}'),
        ],
      ),
    );
  }
}

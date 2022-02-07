import 'package:covid_tracer/api/webservice.dart';
import 'package:covid_tracer/components/constant.dart';
import 'package:covid_tracer/components/picture.dart';
import 'package:covid_tracer/components/text.dart';
import 'package:covid_tracer/model/model.dart';
import 'package:covid_tracer/style/color.dart';
import 'package:flutter/material.dart';

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
            backgroundColor: BasicColor.lightGreenMin,
            elevation: 0,
          ),
        ),
        backgroundColor: BasicColor.lightGreenMin,
        body: FutureBuilder<Model>(
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
        ));
  }
}

List<String> dropdownItem = [
  'Indonesia',
  'Coming soon',
  'Coming soon',
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
    return Stack(
      children: [
        SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(32, 16, 32, 0),
            child: Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextTitle(
                          text: ConstText.cobaString[0],
                          fontWeight: FontWeight.normal,
                        ),
                        TextTitle(
                          text: ConstText.cobaString[1],
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
                      },
                    ),
                  ],
                ),
                const MainBackground(),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              topLeft: Radius.circular(32),
              topRight: Radius.circular(32),
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              //TODO => Bikin orientationbuilder tapi mvvm biar ngga passing2
              height: MediaQuery.of(context).size.shortestSide / 2,
              color: Colors.white,
              child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.shortestSide / 10,
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          TextBigData(
                            text: widget.snapshot.data!.konfirmasi,
                            title: 'Confirmed',
                          ),
                          TextBigData(
                            text: widget.snapshot.data!.meninggal,
                            title: 'Death',
                          ),
                          TextBigData(
                              text: widget.snapshot.data!.sembuh,
                              title: 'Recovered')
                        ],
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.shortestSide / 8,
                        width: MediaQuery.of(context).size.shortestSide / 4,
                        child: Card(
                          color: BasicColor.darkPurple,
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
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:techwise_pub/services/data_services.dart';

class ExamplePage extends StatefulWidget {
  const ExamplePage({super.key});

  @override
  State<ExamplePage> createState() => _ExamplePageState();
}

class _ExamplePageState extends State<ExamplePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Text('Example'),
        ),
        body: FutureBuilder(
          future: DataServices().getData(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                  child: SpinKitChasingDots(
                size: 50,
                color: Theme.of(context).primaryColor,
              ));
            } else if (snapshot.connectionState == ConnectionState.done) {
              return ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  var item = snapshot.data?[index];
                  return Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          '${item?.name}',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            right: 8.0, left: 8.0, bottom: 12),
                        child: ListView.builder(
                          primary: false,
                          shrinkWrap: true,
                          itemCount: item?.keyProperties.length,
                          itemBuilder: (context, index) {
                            var property =
                                item?.keyProperties.values.toList()[index];
                            var propertyName =
                                item?.keyProperties.keys.toList()[index];
                            return Table(
                              // border: TableBorder.all(),
                              children: [
                                TableRow(
                                    // decoration: BoxDecoration(
                                    //   border: index == 0 ? Border.all(): BorderDirectional(
                                    //     start: BorderSide(),
                                    //     end: BorderSide(),
                                    //     bottom: BorderSide()
                                    //   )
                                    // ),
                                    children: [
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[400],
                                            border: BorderDirectional(
                                                bottom: BorderSide(
                                                    color: Colors.white))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text(
                                            '${propertyName}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                      ),
                                      Container(
                                        decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            border: BorderDirectional(
                                                bottom: BorderSide(
                                                    color: Colors.white))),
                                        child: Padding(
                                          padding: const EdgeInsets.all(8.0),
                                          child: Text('${property}'),
                                        ),
                                      )
                                    ])
                              ],
                            );
                          },
                        ),
                      )
                    ],
                  );
                },
              );
            } else {
              return Center(
                child: Text(
                  'Oops, an error occured!',
                  style: TextStyle(fontSize: 30),
                ),
              );
            }
          },
        ));
  }
}

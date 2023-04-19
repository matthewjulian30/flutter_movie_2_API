import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

import '../../data/data_movie_detail.dart';

class DetailPage extends StatefulWidget {
  final String id;
  final String title;

  const DetailPage({super.key, required this.id, required this.title});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  String title = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: FutureBuilder<MovieDetail>(
          // GA PERLU PAKAI INITSTATE
          // PAKAI FUTURE:
          future: MovieDetail.fetchMovie(widget.id),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final details = snapshot.data!;
              title = details.title;
              return Stack(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(details.title, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(Icons.star, size: 15, color: Colors.amber,),
                                const SizedBox(
                                  width: 5,
                                ),
                                Text('${details.rating} / 10'),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Text(details.description, textAlign: TextAlign.center,),
                            const SizedBox(
                              height: 20,
                            ),
                            Image.network(details.posters, width: 350,)
                          ],
                        ),
                  )
                ],
              );
              // return Text(snapshot.data!.name);
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }

            // By default, show a loading spinner.
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}

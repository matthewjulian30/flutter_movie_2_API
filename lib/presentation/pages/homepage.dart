import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:uts_2072001/data/data_movie.dart';
import 'package:uts_2072001/presentation/pages/detailpage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController controller = TextEditingController();
  final List<String> ids = [];
  final List<String> titles = [];
  final List<String> actors = [];
  final List<String> posters = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Column(
            children: [
              const SizedBox(
                height: 50,
              ),
              const Center(
                  child: Text(
                'Movie Search Engine',
                style: TextStyle(fontSize: 25),
              )),
              const SizedBox(
                height: 20,
              ),
              TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                ),
                onChanged: (value) {
                  setState(() {});
                },
                controller: controller,
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                ),
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                    onPressed: () {
                      ids.clear();
                      titles.clear();
                      actors.clear();
                      posters.clear();
                      Movie.fetchMovie(controller.text).then((value) {
                        for (int i = 0; i < value.length; i++) {
                          ids.add(value[i].id);
                          titles.add(value[i].title);
                          actors.add(value[i].actors);
                          (value[i].posters != null)
                              ? posters.add(value[i].posters)
                              : posters.add('');
                        }
                        setState(() {});
                      });
                      print(posters);
                    },
                    child: const Text('Search')),
              ),
              const SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.builder(
                    scrollDirection: Axis.vertical,
                    itemCount: titles.length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (context) {
                              return DetailPage(
                                id: ids[index],
                                title: titles[index],
                              );
                            }));
                          },
                          child: Column(
                            children: [
                              Row(
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Column(
                                    children: [
                                      posters[index] == ''
                                          ? const Icon(Icons.error)
                                          : Image.network(
                                              posters[index],
                                              height: 150,
                                            ),
                                    ],
                                  ),
                                  const SizedBox(
                                    width: 15,
                                  ),
                                  Expanded(
                                    child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            titles[index],
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 1,
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              )
                            ],
                          ));
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

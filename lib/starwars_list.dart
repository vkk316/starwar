import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwar/starwars_repo.dart';

class StarwarsList extends StatefulWidget {
  @override
  _StarwarsListState createState() => _StarwarsListState();
}

class _StarwarsListState extends State<StarwarsList> {
  static const maxpage = 0;
  final StarwarsRepo _repo;
  late List<People> _people;
  late int _page;

  _StarwarsListState() : _repo = new StarwarsRepo();

  ScrollController _listviewController = ScrollController();
  
  @override
  void initState() {
    super.initState();
    _page = 1;
    _people = [];
    fetchPeople();
  }

  Future<void> fetchPeople() async {
    var people = await _repo.fetchPeople(page: _page);
    setState(() {
      _people.addAll(people);
      _page < maxpage ? _page++ : _page = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (noti) {
        if(noti is ScrollEndNotification){
          if(noti.metrics.maxScrollExtent == _listviewController.position.pixels){
             fetchPeople();
          }
        }

        return false;
      },
      child: ListView.builder(
          controller: _listviewController,
          padding: const EdgeInsets.all(8),
          itemCount: _people.length,
          itemBuilder: (BuildContext context, int index) {
            final data = _people[index];
            return Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                onTap: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (BuildContext context) {
                    return DetailPage(
                      people: data,
                    );
                  }));
                },
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                title: Text(data.name),
              ),
            );
          }),
    );
  }
}

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, this.people}) : super(key: key);

  final People? people;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          pinned: true,
          title: Text(people!.name),
          backgroundColor: Theme.of(context).accentColor,
          expandedHeight: MediaQuery.of(context).size.height * (6 / 8),
          flexibleSpace: FlexibleSpaceBar(
              background: FittedBox(
                  fit: BoxFit.cover,
                  child: Image.network(
                      'https://starwars-visualguide.com/assets/img/characters/${people!.url.splitMapJoin(RegExp('[0-9]'), onNonMatch: (str) => '')}.jpg'))),
        ),
        SliverList(
          delegate: SliverChildListDelegate(
            [
              Container(height: 220, color: Colors.red),
              Container(height: 30, color: Colors.greenAccent),
              Container(color: Colors.red),
            ],
          ),
        )
      ],
    );
  }
}

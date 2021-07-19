import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:starwar/starwars_repo.dart';

class StarwarsList extends StatefulWidget {
  @override
  _StarwarsListState createState() => _StarwarsListState();
}

class _StarwarsListState extends State<StarwarsList> {
  final StarwarsRepo _repo;
  late List<People> _people;
  late int _page;

  _StarwarsListState() : _repo = new StarwarsRepo();

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
      _people = people;
    });
  }

  @override
  Widget build(BuildContext context) {
    
    return ListView.builder(
        padding: const EdgeInsets.all(8),
        itemCount: _people.length,
        itemBuilder: (BuildContext context, int index) {
          final title = _people[index].name;
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
                    title: title,
                  );
                }));
              },
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
              title: Text(title),
            ),
          );
        });
  }
}

class DetailPage extends StatelessWidget {
  DetailPage({Key? key, this.title}) : super(key: key);

  final String? title;
  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
    slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        title: Text(title!),
        backgroundColor: Theme.of(context).accentColor,
        expandedHeight: MediaQuery.of(context).size.height * (6/8),
        flexibleSpace: FlexibleSpaceBar(
          background:FittedBox(fit: BoxFit.cover,child: Image.network('https://starwars-visualguide.com/assets/img/characters/1.jpg'))),
        ),
      SliverFixedExtentList(
        itemExtent: 150.0,
        delegate: SliverChildListDelegate(
          [
            Container(color: Colors.red),

          ],
        ),
      ),
    ],
);
  }
}

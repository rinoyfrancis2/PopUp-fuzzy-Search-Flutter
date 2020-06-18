import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo search'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List _searchArray = [];
  final _controller = TextEditingController();

  List _list = ['rinoy', 'babu', 'sambu', 'soman'];

  bool _isSearching;

StateSetter _setState;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    _isSearching = false;
  }

  void _handleSearch() {
    setState(() {
      _isSearching = true;
    });
  }

  Widget _Listresultview() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _searchArray.length,
        itemBuilder: (BuildContext context, int index) {
          String listData = _searchArray[index];
          return new ListTile(
            title: Text(listData.toString()),
          );
        });
  }

  Widget _Listview() {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          String listData = _list[index];
          return new ListTile(
            title: Text(listData.toString()),
          );
        });
  }

  void _funcSearch() {
    showDialog(
        context: context,

        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              _setState = setState;
            return Dialog(
              child: Container(
                height: 300,
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextField(
                        controller: _controller,
                        onTap: _handleSearch,
                        decoration: InputDecoration(hintText: 'search'),
                        onChanged: _searchOp,
                      ),
                      Flexible(
                        child: _searchArray.length != 0 ||
                                _controller.text.isNotEmpty
                            ? _Listresultview()
                            : _Listview(),
                      )
                    ],
                  ),
                ),
              ),
            
            );
            }
          );
            
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: null,
      floatingActionButton: FloatingActionButton(
        onPressed: _funcSearch,
        tooltip: 'search',
        child: Icon(Icons.search),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  void _searchOp(String searchText) {
    _searchArray.clear();
    if (_isSearching != false) {
      for (int i = 0; i < _list.length; i++) {
        String data = _list[i];
        if (data.toLowerCase().contains(searchText.toLowerCase())) {
          _setState(() {
            _searchArray.add(data);
          });
        }
      }
    }
  }
}

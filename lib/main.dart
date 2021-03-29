import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: home());
  }

  Widget home() {
    return Scaffold(
        appBar: AppBar(
            leading: Icon(Icons.menu),
            title: Text('hiru~'),
            actions: <Widget>[
              IconButton(
                  icon: Icon(Icons.mode_comment),
                  onPressed: () {
                    print('눌렀어');
                  }),
              IconButton(
                  icon: Icon(Icons.money_off), onPressed: () => print('애로우!'))
            ]),
        body: body()
    );
  }

  Widget body() {
    return Container(
      padding: EdgeInsets.all(20),
      // decoration: BoxDecoration(
      //   color: Colors.red,
      // ),
      child: testList()
    );
  }

  Widget testList() {
    // List<String> items = [];
    // for (var i = 0; i < 100; i++) 
    //   items.add('a $i');
    List<String> items = List.generate(100, (index) => '리스트 테스트 $index');

    // return Column(
    //   children: List.generate(items.length, (index) => Text(items[index]))
    // );
    return ListView.builder(
      itemCount: items.length,
      itemBuilder: (context, i) {
        return ListTile(
          title: Text(items[i]),
          subtitle: Text('this is test $i ㅎㅎㅎㅎㅎ'),
        );
      } 
    );
  }
  
  Widget cols() {
    return Column(
      children: [
        rows(), rows(), rows()
      ],
    );
  }
  
  Widget rows() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Text('111'),
        Text('222'),
        Text('333'),
        Text('444'),
        Text('555'),
        Text('666'),
        Text('777'),
        Text('888'),
        Text('999'),
      ],
    );
  }
}

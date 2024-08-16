import 'package:flutter/material.dart';


class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  Map data = {};

  @override
  Widget build(BuildContext context) {

    data = data.isNotEmpty ? data : ModalRoute.of(context)!.settings.arguments as Map;
    print(data);
    print(data['isDayTime']);
    String bgImage = (data['isDayTime'] ?? false) ? 'day.png' : 'night.png';
    print(bgImage);

    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/$bgImage'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 120.0, 0, 0),
          child: Column(
            children: [
              TextButton.icon(
                onPressed: () async{
                  dynamic result = await Navigator.pushNamed(context, '/location');
                  if(result != null){
                    setState(() {
                      data = {
                        'time': result['time'],
                        'location': result['location'],
                        'isDayTime': result['isDayTime'],
                        'flag': result['flag']
                      };
                    });
                  }
                },
                label: Text(
                  'Edit Location',
                  style: TextStyle(
                    fontSize: 18.0,
                    color: Colors.grey[300],
                  ),
                ) ,
                icon: Icon(
                  Icons.edit_location,
                  color: Colors.grey[300],
                  size: 30.0,
                ),
              ),
              const SizedBox(height: 20.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    data['location'] ?? 'Loading...',
                    style: TextStyle(
                      color: (data['isDayTime'] ?? false) ? Colors.grey[300] : Colors.blue[200],
                      fontSize: 35.0,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 2.0,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20.0),
              Text(
                data['time'] ?? 'Loading...',
                style: TextStyle(
                  color: (data['isDayTime'] ?? false) ? Colors.grey[300] : Colors.blue[200],
                  fontSize: 65.0,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 2.0,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

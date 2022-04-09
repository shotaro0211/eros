import 'package:eros/ui/theme/default_theme.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '走れエロス',
      theme: defaultTheme,
      home: const MyHomePage(title: '走れエロス'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  String _currentLocation = "";
  final LocatioinPainter _painter = LocatioinPainter();

  @override
  void initState() {
    super.initState();
  }

  void _listenLocation() async {
    Location location = Location();

    bool _serviceEnabled;
    PermissionStatus _permissionGranted;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    location.onLocationChanged.listen((LocationData currentLocation) {
      setState(() {
        _currentLocation = currentLocation.toString();
        _painter.add(currentLocation.latitude!, currentLocation.longitude!);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            SizedBox(
              width: 400,
              height: 400,
              child: CustomPaint(
                painter: _painter,
              ),
            ),
            const Text(
              'You location:',
            ),
            Text(
              _currentLocation,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _listenLocation,
        tooltip: 'Start Run',
        child: const Icon(Icons.run_circle_rounded),
      ),
    );
  }
}

class LocatioinPainter extends CustomPainter {
  List<double> lats = [];
  List<double> longs = [];

  void add(double lat, double long) {
    lats.add(lat);
    longs.add(long);
  }

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.pink;
    for (var i = 0; i < lats.length; i++) {
      canvas.drawCircle(
          Offset((lats[1] - lats[i]) * 100000 + 200,
              (longs[1] - longs[i]) * 100000 + 200),
          3,
          paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}

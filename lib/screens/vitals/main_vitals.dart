import 'dart:async';
import 'dart:math';
import 'dart:typed_data';
import 'package:chronos_health/screens/doctor_screen/doctor_dashboard.dart';
import 'package:chronos_health/screens/doctor_screen/doctor_search.dart';
import 'package:chronos_health/utils/colors.dart';
import 'package:chronos_health/video_screen/video_call.dart';
import 'package:flutter/material.dart';
import 'package:usb_serial/transaction.dart';
import 'package:usb_serial/usb_serial.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:fl_chart/fl_chart.dart';

class MainVitals extends StatefulWidget {
  const MainVitals({Key? key}) : super(key: key);

  @override
  _MainVitalsState createState() => _MainVitalsState();
}

class _MainVitalsState extends State<MainVitals> {
  /// method to generate a Test  Wave Pattern Sets
  /// this gives us a value between +1  & -1 for sine & cosine

  String hr = '0';
  List yaxis = [];
  List xaxis = [];
  List<FlSpot> _spots = [
    FlSpot(2, 3),
    FlSpot(2.6, 2),
    FlSpot(4.9, 5),
    FlSpot(6.8, 2.5),
    FlSpot(8, 4),
    FlSpot(9.5, 3),
    FlSpot(11, 4),
  ];
  UsbPort? _port;
  String _status = "Idle";
  List<Widget> _ports = [];
  List<Widget> _serialData = [];
  List myValue = [];

  StreamSubscription<String>? _subscription;
  Transaction<String>? _transaction;
  UsbDevice? _device;

  Future<bool> _connectTo(device) async {
    _serialData.clear();

    if (_subscription != null) {
      _subscription!.cancel();
      _subscription = null;
    }

    if (_transaction != null) {
      _transaction!.dispose();
      _transaction = null;
    }

    if (_port != null) {
      _port!.close();
      _port = null;
    }

    if (device == null) {
      _device = null;
      if (mounted) {
        setState(() {
          _status = "Disconnected";
        });
      }

      return true;
    }

    _port = await device.create();
    if (await (_port!.open()) != true) {
      if (mounted) {
        setState(() {
          _status = "Failed to open port";
        });
      }

      return false;
    }
    _device = device;

    await _port!.setDTR(true);
    await _port!.setRTS(true);
    await _port!.setPortParameters(
        115200, UsbPort.DATABITS_8, UsbPort.STOPBITS_1, UsbPort.PARITY_NONE);

    _transaction = Transaction.stringTerminated(
        _port!.inputStream as Stream<Uint8List>, Uint8List.fromList([13, 10]));

    _subscription = _transaction!.stream.listen((String line) {
      if (mounted) {
        setState(() {
          _serialData.clear();
          _serialData.add(Text(
            line + "BPM",
            style: const TextStyle(
                fontSize: 20, color: Colors.green, fontWeight: FontWeight.bold),
          ));

          myValue.add(line);
          hr = line.split(",")[0];

          yaxis.add(line.split(",")[1]);
          xaxis.add(line.split(",")[2]);
        });
      }

      for (var i in yaxis) {
        for (var j in xaxis) {
          if (mounted) {
            setState(() {
              _spots.add(FlSpot(i, j));
            });
          }
        }
      }
    });
    if (mounted) {
      setState(() {
        _status = "Connected";
      });
    }

    return true;
  }

  void _getPorts() async {
    _ports = [];
    List<UsbDevice> devices = await UsbSerial.listDevices();
    if (!devices.contains(_device)) {
      _connectTo(null);
    }
    print(devices);

    devices.forEach((device) {
      _ports.add(ListTile(
          leading: Icon(Icons.usb),
          title: Text(device.productName!),
          subtitle: Text(device.manufacturerName!),
          trailing: ElevatedButton(
            child: Text(_device == device ? "Disconnect" : "Connect"),
            onPressed: () {
              _connectTo(_device == device ? null : device).then((res) {
                _getPorts();
              });
            },
          )));
    });
    if (mounted) {
      setState(() {
        print(_ports);
      });
    }
  }

  @override
  void initState() {
    super.initState();

    // _timer = Timer.periodic(Duration(milliseconds: 60), _generateTrace);
    UsbSerial.usbEventStream!.listen((UsbEvent event) {
      _getPorts();
    });
    _getPorts();
  }

  @override
  void dispose() {
    // _timer!.cancel();

    _connectTo(null);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => DoctorDashboard()));
            },
            icon: Icon(Icons.arrow_back)),
        title: Text("Patient's clinical Vitals"),
        backgroundColor: primaryColor,
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(top: 10),
          child: Column(
            children: <Widget>[
              const SizedBox(
                height: 10,
              ),

              SizedBox(
                height: 20,
              ),
              ..._serialData,
              ..._ports,
              Text('Status: $_status\n'),
              RaisedButton(
                  child: Text("Exit"),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => DoctorDashboard()));
                  }),
              Container(
                width: 300,
                child: Divider(),
              ),
              SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/images/pulse.png",
                    scale: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Heart rate:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text(hr)
                ],
              ),

              // Container(
              // padding: EdgeInsets.symmetric(horizontal: 1),
              // height: 200,
              // child: LineChart(
              //       LineChartData(
              //           borderData: FlBorderData(
              //             show: false,
              //           ),
              //           titlesData: FlTitlesData(
              //             show: false,
              //           ),
              //           minX: 0,
              //           minY: 0,
              //           maxX: 5,
              //           maxY: 15,
              //           gridData: FlGridData(
              //               show: true,
              //               getDrawingVerticalLine: (value) {
              //                 return FlLine(color: Colors.transparent);
              //               },
              //               getDrawingHorizontalLine: (value) {
              //                 return FlLine(
              //                     color: secondaryColor, strokeWidth: 0.1);
              //               }),
              //           lineBarsData: [
              //             LineChartBarData(
              //                 isCurved: true,
              //                 dotData: FlDotData(show: false),
              //                 colors: [primaryColor],
              //                 spots: _spots
              //     [
              // FlSpot(0, 3),
              // FlSpot(2.6, 2),
              // FlSpot(4.9, 5),
              // FlSpot(6.8, 2.5),
              // FlSpot(8, 4),
              // FlSpot(9.5, 3),
              // FlSpot(11, 4),
              // ]
              //             )
              //       ]),
              // )),
              Text(
                "Interbeat interval(IBI)",
                style: TextStyle(),
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/images/temperature.png",
                    scale: 15,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Temperature:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Not connected")
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.air,
                    color: Colors.blue,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "SpO2:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Not connected")
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Image.asset(
                    "assets/images/pulse.png",
                    scale: 15,
                    color: Colors.green,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "ECG:",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Not connected")
                ],
              ),
              SizedBox(
                height: 80,
              ),
              Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Icon(
                    Icons.monitor,
                    color: Colors.amber,
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Text(
                    "Ultrasound",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
                  ),
                  SizedBox(
                    width: 20,
                  ),
                  Text("Not connected")
                ],
              ),
              SizedBox(
                height: 80,
              ),
              // SfRadialGauge(
              //   axes: <RadialAxis>[
              //     RadialAxis(
              //       axisLineStyle: AxisLineStyle(color: Colors.blue),
              //       minimum: 0,
              //       maximum: 200,
              //       pointers: <GaugePointer>[
              //         NeedlePointer(value: 100),
              //       ],
              //     ),
              //   ],
              // ),

              //
            ],
          ),
        ),
      ),
    );
  }
}

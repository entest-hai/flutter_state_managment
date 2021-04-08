import 'package:flutter/material.dart';

class BondedApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: BondedView(),
    );
  }
}

class BondedView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("BondedPage"),
        ),
        body: SafeArea(
          child: Center(
            child: ElevatedButton(
              child: Text("Connect"),
              onPressed: () async {
                final String selectedDevice = await Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => ListDevicesView()),
                );

                if (selectedDevice != null) {
                  showDevice(context, selectedDevice);
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  void showDevice(BuildContext context, String selectedDevice) {
    print(selectedDevice);
    Navigator.of(context).push(MaterialPageRoute(builder: (context) {
      return DeviceView(
        selectedDevice: selectedDevice,
      );
    }));
  }
}

class DeviceView extends StatelessWidget {
  final String selectedDevice;
  DeviceView({this.selectedDevice});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Device"),
      ),
      body: SafeArea(
        child: Center(
          child: Text("$selectedDevice"),
        ),
      ),
    );
  }
}

class ListDevicesView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Devices"),
      ),
      body: Center(
        child: ElevatedButton(
          child: Text("Choose"),
          onPressed: () {
            Navigator.of(context).pop("Selected Device");
          },
        ),
      ),
    );
  }
}

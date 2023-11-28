import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';

class InternetConnectionProvider with ChangeNotifier {
  bool widgetCalled = false;
  bool _internetStatus = false;
  bool get internetStatus => _internetStatus;
  GlobalKey<NavigatorState> key = GlobalKey<NavigatorState>();

  InternetConnectionProvider() {
    deviceCheck();
    InternetConnectionChecker().onStatusChange.listen((status) {
      switch (status) {
        case InternetConnectionStatus.connected:
          debugPrint("InternetConnectionStatus==>connected");
          updateConnectionStatus(true);
          break;
        case InternetConnectionStatus.disconnected:
          debugPrint("InternetConnectionStatus==>disconnected");
          updateConnectionStatus(false);
          break;
      }
    });
  }

// Use to check device
  deviceCheck() {
    Connectivity().onConnectivityChanged.listen((result) async {
      if (result == ConnectivityResult.mobile ||
          result == ConnectivityResult.wifi) {
        bool result = await InternetConnectionChecker().hasConnection;
        if (result == true) {
          updateConnectionStatus(true);
        }
      } else {
        debugPrint("device check called");
        if (widgetCalled == false) {
          updateConnectionStatus(false);
        }
      }
    });
  }

// Use to update internet status
  updateConnectionStatus(bool conneted) async {
    debugPrint("widget called Status ====> $widgetCalled");
    var connectivityResult = await (Connectivity().checkConnectivity());
    if ((connectivityResult == ConnectivityResult.mobile ||
            connectivityResult == ConnectivityResult.wifi) &&
        conneted) {
      _internetStatus = true;
      notifyListeners();
      debugPrint("Internet Status ===*****===> $_internetStatus");
      if (widgetCalled == true) {
        closeDialog(
          key.currentState!.context,
        );
      }
    } else {
      _internetStatus = false;
      notifyListeners();
      debugPrint("Internet Status ======> $_internetStatus");
      if (widgetCalled == false) {
        showToastMessage();
      }
    }
  }

  showToastMessage() {
    widgetCalled = true;
    showModalBottomSheet(
      context: key.currentState!.context,
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(
                Icons.wifi_off,
                size: 64,
                color: Colors.red,
              ),
              const SizedBox(height: 10),
              const Text(
                'No Internet Connection',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Please check your internet connection and try again.',
// "There seems to be a problem with your internet.",
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  closeDialog(context);
                },
                child: const Text('OK'),
              ),
            ],
          ),
        );
      },
    ).whenComplete(() {
      widgetCalled = false;
    });
  }

  closeDialog(BuildContext context) {
    widgetCalled = false;
    Navigator.of(context).pop();
  }
}

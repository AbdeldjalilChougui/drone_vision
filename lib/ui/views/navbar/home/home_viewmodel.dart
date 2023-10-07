import 'dart:async';
import 'dart:typed_data';
import 'dart:ui';

import 'package:drone_vision/services/api_service.dart';
import 'package:drone_vision/services/token_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:drone_vision/app/app.locator.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

class HomeViewModel extends FutureViewModel {
  HomeViewModel({this.context});
  BuildContext? context;

  CameraPosition? kGooglePlex;
  Completer<GoogleMapController> controller = Completer();
  List<Marker> customMarkers = [];
  final _apiService = locator<ApiService>();
  final _tokenService = locator<TokenService>();
  final _navigationService = locator<NavigationService>();

  navigateTo({view}) {
    _navigationService.navigateWithTransition(view, curve: Curves.easeIn, duration: const Duration(milliseconds: 300));
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    Codec codec = await instantiateImageCodec(data.buffer.asUint8List(), targetWidth: width);
    FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ImageByteFormat.png))!.buffer.asUint8List();
  }

  mapToMarkers(LatLng latLng) async {
    final Uint8List markerIcon = await getBytesFromAsset('assets/icons/logo_50_70.png', 100);

    customMarkers.add(Marker(
      markerId: const MarkerId("markerId"),
      position: latLng,
      icon: await BitmapDescriptor.fromBytes(markerIcon),
    ));

    notifyListeners();
  }

  setMapAndMarker({String? lat, String? long}) {
    kGooglePlex = const CameraPosition(
      target: LatLng(36.729983, 3.083609),
      zoom: 13.4746,
    );

    mapToMarkers(LatLng(double.parse(lat!), double.parse(long!)));
  }

  Future getDrones() async {
    setMapAndMarker(
      lat: "36.729983",
      long: "3.083609",
    );
    String? token = await _tokenService.getTokenValue();
    return await _apiService.getDrones(
      context: context,
      token: token,
    ).then((value) {
      for (var drone in value!) {
        if (drone.lat != null && drone.long != null) {
          setMapAndMarker(
            lat: drone.lat,
            long: drone.long,
          );
        } else {
          setMapAndMarker(lat: "36.729983", long: "3.083609");
        }
      }
    });
  }

  @override
  Future futureToRun() async {
    return await getDrones();
  }
}
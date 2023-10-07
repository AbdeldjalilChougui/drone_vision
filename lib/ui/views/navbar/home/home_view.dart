import 'package:drone_vision/shared/colors.dart';
import 'package:drone_vision/ui/views/navbar/home/home_viewmodel.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:stacked/stacked.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter/material.dart';
import 'package:drone_vision/ui/widgets/loader.dart';

class HomeView extends HookWidget {
  const HomeView({Key? key,}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          backgroundColor: kMainColor1,
          child: const Icon(Icons.table_rows),
        ),
        body: model.isBusy ? const Loader() : Container(
          child: Stack(
            children: [
              model.kGooglePlex == null ? const SizedBox() : SizedBox(
                height: MediaQuery.of(context).size.height,
                child: GoogleMap(
                  mapType: MapType.normal,
                  initialCameraPosition: model.kGooglePlex!,
                  onMapCreated: (GoogleMapController controller) {
                    model.controller.complete(controller);
                  },
                  markers: model.customMarkers.toSet(),
                  myLocationEnabled: true,
                  gestureRecognizers: Set()..add(Factory<EagerGestureRecognizer>(() => EagerGestureRecognizer())),
                  myLocationButtonEnabled: true,
                  zoomControlsEnabled: false,
                ),
              ),
              model.kGooglePlex == null ? const SizedBox() : Container(
                  margin: const EdgeInsets.only(top: 45),
                  height: 50,
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: TextField(
                    textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderSide: BorderSide.none,
                          borderRadius: BorderRadius.circular(10)),
                      filled: true,
                      fillColor: Colors.white.withOpacity(0.8),
                      contentPadding: const EdgeInsets.symmetric(vertical: 1),
                      prefixIcon: const Icon(
                        Icons.search,
                        size: 30,
                      ),
                      hintText: "Search drone ...",
                      hintStyle: const TextStyle(fontSize: 16, ),
                    ),
                    controller: TextEditingController(text: ""),
                  )
              ),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => HomeViewModel(context: context),
    );
  }
}
import 'dart:convert';


import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:workmanager/workmanager.dart';
import 'package:drone_vision/app/app.locator.dart';
import 'package:drone_vision/foreground_notifications.dart';
import 'package:drone_vision/services/api_service.dart';
import 'package:drone_vision/services/token_service.dart';
import 'package:drone_vision/shared/colors.dart';
import 'package:drone_vision/shared/ui_helpers.dart';
import 'package:drone_vision/ui/views/index/index_viewmodel.dart';
import 'package:drone_vision/ui/views/navbar/etape/etape_view.dart';
import 'package:drone_vision/ui/views/navbar/home/home_view.dart';
import 'package:drone_vision/ui/views/navbar/reunion/reunion_view.dart';
import 'package:drone_vision/ui/views/navbar/settings/settings_view.dart';
import 'package:drone_vision/ui/widgets/loader.dart';
import 'package:stacked/stacked.dart';
import 'package:animations/animations.dart';
import 'package:styled_widget/styled_widget.dart';
import 'package:drone_vision/ui/widgets/nav_item.dart';

class WebSocketListener extends StatelessWidget {
  const WebSocketListener({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<WebSocketListenerViewModel>.reactive(
      viewModelBuilder: () => WebSocketListenerViewModel(),
      builder: (context, model, child) {
        return !model.dataReady ? const SizedBox() : StreamBuilder<dynamic>(
          stream: model.data!.stream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              LocalNotificationService.display(jsonDecode(snapshot.data));
              Workmanager().registerPeriodicTask(
                "2",
                "simplePeriodicTask",
                inputData: jsonDecode(snapshot.data),
                frequency: const Duration(seconds: 1),
              );
            }

            return const IndexView();
          },
        );
      },
    );
  }
}

class WebSocketListenerViewModel extends FutureViewModel<WebSocketChannel?> {
  final _apiService = locator<ApiService>();
  final _tokenService = locator<TokenService>();

  Future<WebSocketChannel?> getWebSocket() async {
    String? token = await _tokenService.getTokenValue();

    LocalNotificationService.initialize();

    return _apiService.webSocket(token: token);
  }

  @override
  Future<WebSocketChannel?> futureToRun() {
    return getWebSocket();
  }
}

class IndexView extends StatelessWidget {
  const IndexView({Key? key, }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<IndexViewModel>.reactive(
      builder: (context, model, child) {
        return Scaffold(
          body: !model.thereIsConnection! ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Text('No Internet Connection, please check your internet', textAlign: TextAlign.center,).center().padding(horizontal: 20),
              verticalSpaceSmall,
              Container(
                width: MediaQuery.of(context).size.width - 60,
                height: 50,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  color: kMainColor1,
                ),
                child: model.isReload! ? const Loader(color: Colors.white,).center() : const Center(
                  child: Text('Reload internet', style: TextStyle(color: Colors.white, fontFamily: 'Poppins', fontSize: 16, fontWeight: FontWeight.w500),),
                ),
              ).gestures(
                onTap: () {
                  model.updateIsReload();
                  model.getConnectivityStatus();
                },
              )
            ],
          ) : model.isBusy ? const Loader() : PageTransitionSwitcher(
            duration: const Duration(milliseconds: 300),
            reverse: model.reverse,
            transitionBuilder: (
                Widget child,
                Animation<double> animation,
                Animation<double> secondaryAnimation,
                ) {
              return SharedAxisTransition(
                animation: animation,
                secondaryAnimation: secondaryAnimation,
                transitionType: SharedAxisTransitionType.horizontal,
                child: child,
              );
            },
            child: getViewForIndex(index: model.currentIndex,),
          ),
          bottomNavigationBar: Container(
            alignment: Alignment.bottomCenter,
            height: 65,
            color: Colors.white,
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                NavItem(
                  onTap: () => model.setIndex(0),
                  label: 'Home',
                  isSelected: model.currentIndex == 0,
                  image: "assets/icons/home.png",
                ),
                NavItem(
                  onTap: () => model.setIndex(1),
                  label: 'History',
                  isSelected: model.currentIndex == 1,
                  image: "assets/icons/history.png",
                ),
                NavItem(
                  onTap: () => model.setIndex(2),
                  label: 'Add User',
                  isSelected: model.currentIndex == 2,
                  image: "assets/icons/user.png",
                ),
                NavItem(
                  onTap: () => model.setIndex(3),
                  label: 'Settings',
                  isSelected: model.currentIndex == 3,
                  image: "assets/icons/settings.png",
                ),
              ],
            ),
          ),
        );
      },
      viewModelBuilder: () => IndexViewModel(),
      onViewModelReady: (model) => model.getConnectivityStatus(context: context),
    );
  }

  Widget getViewForIndex({int? index,}) {
    switch (index) {
      case 0:
        return const HomeView();
      case 1:
        return const ReunionView();
      case 2:
        return const EtapeView();
      case 3:
        return const SettingsView();
      case 4:
        return const SettingsView();
      default:
        return Container();
    }
  }
}
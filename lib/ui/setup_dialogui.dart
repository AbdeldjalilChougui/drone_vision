import 'package:flutter/material.dart';
import 'package:drone_vision/app/app.locator.dart';
import 'package:drone_vision/enum/dialog_type.dart';
import 'package:stacked_services/stacked_services.dart';
import 'package:drone_vision/ui/dialogs/payment_attention/payment_attention_view.dart';

void setupDialogUi() {
  var dialogService = locator<DialogService>();

  var builders = {
    DialogType.basic : (BuildContext context, DialogRequest dialogRequest, Function(DialogResponse) completer)
        => Container(),
    DialogType.paymentAttention : (BuildContext context, DialogRequest dialogRequest, Function(DialogResponse) completer)
        => Dialog(child: PaymentAttentionView(request: dialogRequest, completer: completer),),
  };

  dialogService.registerCustomDialogBuilders(builders);
}
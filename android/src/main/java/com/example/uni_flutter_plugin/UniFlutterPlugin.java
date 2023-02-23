package com.example.uni_flutter_plugin;

import android.os.RemoteException;

import androidx.annotation.NonNull;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * UniFlutterPlugin
 */
public class UniFlutterPlugin implements FlutterPlugin, MethodCallHandler {
    /// The MethodChannel that will the communication between Flutter and native Android
    ///
    /// This local reference serves to register the plugin with the Flutter Engine and unregister it
    /// when the Flutter Engine is detached from the Activity
    private MethodChannel channel;

    private PrinterService printerService;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), SDKConstants.MAIN_CHANNEL_NAME);
        channel.setMethodCallHandler(this);
        printerService = new PrinterService(flutterPluginBinding.getApplicationContext());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {
        if (call.method.equals(SDKConstants.PRINTER_INIT_PRINTER)) {
            int ret = printerService.initPrinter();
            result.success(ret);
        } else if (call.method.equals(SDKConstants.PRINTER_CLOSE_PRINTER)) {
            int ret = printerService.closePrinter();
            result.success(ret);
        } else if (call.method.equals(SDKConstants.PRINTER_PRINT_TEXT)) {
            String data = call.argument("data");
            int ret = printerService.printText(data);
            result.success(ret);
        } else if (call.method.equals(SDKConstants.PRINTER_PRINT_IMG)) {
            String data = call.argument("data");
            int ret = printerService.printImg(data);
            result.success(ret);
        } else {
            result.notImplemented();
        }

    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        printerService = null;
    }
}

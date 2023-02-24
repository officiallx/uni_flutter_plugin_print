package com.example.uni_flutter_plugin;

import android.os.RemoteException;
import android.util.Log;

import androidx.annotation.NonNull;

import java.lang.reflect.Array;
import java.util.ArrayList;
import java.util.Arrays;

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
    private final String TAG = "UniFlutterPlugin";
    private PrinterService printerService;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), SDKConstants.MAIN_CHANNEL_NAME);
        channel.setMethodCallHandler(this);
        printerService = new PrinterService(flutterPluginBinding.getApplicationContext());
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        switch (call.method) {
            case SDKConstants.PRINTER_INIT_PRINTER: {
                printerService.initPrinter(result);
                break;
            }
            case SDKConstants.PRINTER_PRINT_TEXT: {
                String data = call.arguments();
                int ret = printerService.printText(data);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_PRINT_IMG: {
                ArrayList<Integer> data = call.arguments();
                int ret = printerService.printImg(data);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_I_FLUSH_BUFFER: {
                int ret = printerService.iFlushBuffer();
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_PRINT_LINE: {
                int line = call.arguments();
                int ret = printerService.printLine(line);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_CHECK_PAPER: {
                int ret = printerService.checkPaper();
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_I_START_PRINTING: {
                int ret = printerService.iStartPrinting();
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_I_GET_PRINTER_STATUS: {
                int ret = printerService.iGetPrinterStatus();
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_GET_VERSION: {
                String ret = printerService.getVersion();
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_CLOSE_PRINTER: {
                int ret = printerService.closePrinter();
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_I_SET_PRINTER_PROPERTIES: {
                int fontSize = call.argument("font_size");
                int textAlignment = call.argument("text_alignment");
                int ret = printerService.iSetPrinterProperties(fontSize, textAlignment);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_I_UPDATE_BUFFER_STRING: {
                String data = call.arguments();
                int ret = printerService.iUpdatedBuffer(data);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_I_UPDATE_BUFFER_BYTE_ARRAY: {
                ArrayList<Integer> data = call.arguments();
                int ret = printerService.iUpdatedBuffer(data);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_I_UPDATE_BUFFER_FONT_SIZE: {
                int data = call.arguments();
                int ret = printerService.iUpdatedBufferFontSize(data);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_I_UPDATE_BUFFER_TEXT_ALIGNMENT: {
                int data = call.arguments();
                int ret = printerService.iUpdatedBufferTextAlignment(data);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_PRINT_QR_CODE: {
                String data = call.arguments();
                int ret = printerService.printQRCode(data);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_PRINT_QR_CODE_WIDTH: {
                String data = call.argument("data");
                int width = call.argument("width");
                int ret = printerService.printQRCode(data, width);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_PRINT_QR_CODE_WIDTH_IMAGE_ALIGNMENT: {
                String data = call.argument("data");
                int width = call.argument("width");
                int imageAlignment = call.argument("image_alignment");
                int ret = printerService.printQRCode(data, width, imageAlignment);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_SET_LOG_ENABLE: {
                boolean data = call.arguments();
                int ret = printerService.setLogEnable(data);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_I_PRINT_EAN_BARCODE: {
                String data = call.argument("data");
                int height = call.argument("height");
                int ret = printerService.iPrintEANBarcode(data, height);
                result.success(ret);
                break;
            }
            case SDKConstants.PRINTER_SEND_RAW_DATA: {
                ArrayList<Integer> data = call.arguments();
                int ret = printerService.sendRawData(data);
                result.success(ret);
                break;
            }
            default: {
                result.notImplemented();
                break;
            }
        }
    }

    @Override
    public void onDetachedFromEngine(@NonNull FlutterPluginBinding binding) {
        channel.setMethodCallHandler(null);
        printerService = null;
    }
}

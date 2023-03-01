package com.evolute.uni_flutter_plugin;

import androidx.annotation.NonNull;

import com.evolute.uni_flutter_plugin.utility.SDKConstants;
import com.evolute.uni_flutter_plugin.service.FPSService;
import com.evolute.uni_flutter_plugin.service.PrinterService;

import java.util.ArrayList;
import java.util.Map;

import io.flutter.embedding.engine.plugins.FlutterPlugin;
import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodCall;
import io.flutter.plugin.common.MethodChannel;
import io.flutter.plugin.common.MethodChannel.MethodCallHandler;
import io.flutter.plugin.common.MethodChannel.Result;

/**
 * UniFlutterPlugin
 */
public class UniFlutterPlugin implements FlutterPlugin, MethodCallHandler {
    private MethodChannel channel;
    private EventChannel fingerPositionCallbackChannel;
    private final String TAG = "UniFlutterPlugin";
    private PrinterService printerService;
    private FPSService fpsService;

    @Override
    public void onAttachedToEngine(@NonNull FlutterPluginBinding flutterPluginBinding) {
        channel = new MethodChannel(flutterPluginBinding.getBinaryMessenger(), SDKConstants.MAIN_CHANNEL_NAME);
        fingerPositionCallbackChannel = new EventChannel(flutterPluginBinding.getBinaryMessenger(), SDKConstants.FINGER_POSITION_CALLBACK_EVENT_CHANNEL);
        channel.setMethodCallHandler(this);
        printerService = new PrinterService(flutterPluginBinding.getApplicationContext());
        fpsService = new FPSService(flutterPluginBinding.getApplicationContext());
        fingerPositionCallbackChannel.setStreamHandler(fpsService.fingerPositionCallbackStreamHandler);
    }

    @Override
    public void onMethodCall(@NonNull MethodCall call, @NonNull Result result) {

        switch (call.method) {
            //***************************Printer APIs Plugin Mapping***********************
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
            //************************FPS Plugins Mapping***********************
            case SDKConstants.FPS_INIT_FPS: {
                fpsService.initFPS(result);
                break;
            }
            case SDKConstants.FPS_CLOSE_FPS: {
                int ret = fpsService.closeFPS();
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_CAPTURE_FPS: {
                fpsService.captureFPS(result);
//                result.success(ret);
                break;
            }
            case SDKConstants.FPS_SET_TEMPLATE: {
                int template = call.arguments();
                int ret = fpsService.setTemplate(template);
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_GET_TEMPLATE: {
                int ret = fpsService.getTemplate();
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_SET_IMG_COMPRESSION_ALGO: {
                int imageCompressionAlgo = call.arguments();
                int ret = fpsService.setImgCompressionAlgo(imageCompressionAlgo);
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_GET_IMG_COMPRESSION_ALGO: {
                int ret = fpsService.getImgCompressionAlgo();
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_GET_IMAGE_QUALITY: {
                int ret = fpsService.getImageQuality();
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_SET_TIMEOUT: {
                int timeout = call.arguments();
                int ret = fpsService.setTimeout(timeout);
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_GET_TIMEOUT: {
                int ret = fpsService.getTimeout();
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_SET_FFD_SECURITY_LEVEL: {
                int ffdLevel = call.arguments();
                int ret = fpsService.setFFDSecurityLevel(ffdLevel);
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_VERIFY_FPS_MATCH: {
                ArrayList<Integer> fingerData1 = call.argument("finger_data_1");
                ArrayList<Integer> fingerData2 = call.argument("finger_data_2");
                String ret = fpsService.verifyFPSMatch(fingerData1, fingerData2);
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_VERIFY_FPS: {
                ArrayList<Integer> fingerData1 = call.argument("finger_data_1");
                boolean fingerDataEnabled = call.argument("finger_data_enabled");
                fpsService.verifyFPS(result, fingerData1, fingerDataEnabled);
                break;
            }
            case SDKConstants.FPS_GET_FPS_DEVICE_INFO: {
                String ret = fpsService.getFPSDeviceInfo();
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_VERIFY_FPS_WITH_TEMPLATE: {
                ArrayList<Map<String, ?>> data = call.argument("template_data_list");
                boolean fingerDataEnabled = call.argument("finger_data_enabled");
                fpsService.verifyFPSWithTemplate(result, data, fingerDataEnabled);
                break;
            }
            case SDKConstants.FPS_ENABLE_FINGER_POSITION_UPDATES: {
                int ret = fpsService.enableFingerPositionUpdates();
                result.success(ret);
                break;
            }
            case SDKConstants.FPS_DISABLE_FINGER_POSITION_UPDATES: {
                int ret = fpsService.disableFingerPositionUpdates();
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
        fingerPositionCallbackChannel.setStreamHandler(null);
        printerService = null;
        fpsService = null;
    }


}

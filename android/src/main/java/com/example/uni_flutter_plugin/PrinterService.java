package com.example.uni_flutter_plugin;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.graphics.Bitmap;
import android.graphics.BitmapFactory;
import android.os.IBinder;
import android.util.Log;

import com.evolute.printservice.AidlPrint;
import com.evolute.sdkservice.ESDKConstant;

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.io.IOException;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.flutter.plugin.common.MethodChannel;

public class PrinterService {

    private final String TAG = "PrinterService";
    private final Context context;
    private volatile AidlPrint aidlPrint = null;
    private final ExecutorService executorService = Executors.newSingleThreadExecutor();

    private final ServiceConnection printerServiceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            aidlPrint = AidlPrint.Stub.asInterface(service);
            Log.e(TAG, "onServiceConnected: Service Connected");
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            aidlPrint = null;
            Log.e(TAG, "onServiceDisconnected: Disconnected");
        }
    };

    public PrinterService(Context context) {
        this.context = context;
    }


    void initPrinter(MethodChannel.Result result) {
        if (aidlPrint == null) {
            Intent intent = new Intent();
            intent.setAction("com.evolute.service.printservice");
            intent.setPackage("com.evolute.sdkservice");
            context.bindService(intent, printerServiceConnection, Context.BIND_AUTO_CREATE);
            executorService.execute(() -> {
                int count = 10;
                while (aidlPrint == null && count > 0) {
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException e) {
                        Log.e(TAG, "initPrinter: Error");
                    }
                    Log.e(TAG, "initPrinter: Value : " + count);
                    count--;
                }
                if (aidlPrint != null) {
                    result.success(ESDKConstant.PRINTER_SUCCESS);
                } else {
                    result.success(ESDKConstant.PRINTER_FAILURE);
                }
            });
        } else {
            result.success(ESDKConstant.PRINTER_SUCCESS);
        }
    }

    int printLine(int line) {
        try {
            aidlPrint.printLine(line);
            return ESDKConstant.PRINTER_SUCCESS;
        } catch (Exception e) {
            Log.e(TAG, "printLine: Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int iFlushBuffer() {
        try {
            int ret = aidlPrint.iFlushBuffer();
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "iFlushBuffer: Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int checkPaper() {
        try {
            boolean status = aidlPrint.checkPaper();
            return status ? 1 : 0;
        } catch (Exception e) {
            Log.e(TAG, "checkPaper: Error : " + e.getMessage());
            return 0;
        }
    }

    int iStartPrinting() {
        try {
            int ret = aidlPrint.iStartPrinting();
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "iStartPrinting : Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int iGetPrinterStatus() {
        try {
            int ret = aidlPrint.iGetPrinterStatus();
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "iGetPrinterStatus : Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int setLogEnable(boolean enable) {
        try {
            aidlPrint.vSetLogEnable(enable);
            return ESDKConstant.PRINTER_SUCCESS;
        } catch (Exception e) {
            Log.e(TAG, "iGetPrinterStatus : Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    String getVersion() {
        try {
            String ret = aidlPrint.getVersion();
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "getVersion : Error : " + e.getMessage());
            return "";
        }
    }

    int iSetPrinterProperties(int fontSize, int textAlignment) {
        try {
            int ret = aidlPrint.iSetPrinterProperties(ESDKConstant.FontSize.valueOf(fontSize), ESDKConstant.TextAlignment.valueOf(textAlignment));
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "iSetPrinterProperties: Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int printQRCode(String data) {
        try {
            int ret = aidlPrint.printQRCode(data);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "printQRCode : Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int printQRCode(String data, int width) {
        try {
            int ret = aidlPrint.printQRCode(data, width);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "printQRCode : Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int printQRCode(String data, int width, int imageAlignment) {
        try {
            int ret = aidlPrint.printQRCode(data, width, imageAlignment);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "printQRCode : Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int sendRawData(ArrayList<Integer> data) {
        try {
            byte[] byteData = arrayListToByteArray(data);
            aidlPrint.sendRAWData(byteData);
            return ESDKConstant.PRINTER_SUCCESS;
        } catch (Exception e) {
            Log.e(TAG, "sendRawData: Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int iUpdatedBuffer(String data) {
        try {
            int ret = aidlPrint.iUpdateBuffer(data);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "iUpdatedBuffer : Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }


    int iUpdatedBuffer(ArrayList<Integer> data) {
        try {
            byte[] byteData = arrayListToByteArray(data);
            int ret = aidlPrint.iUpdateBuffer(byteData);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "iUpdatedBuffer: Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int iPrintEANBarcode(String data, int height) {
        try {
            int ret = aidlPrint.iPrintEAN_Barcode(data, height);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "iUpdatedBuffer: Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int iUpdatedBufferFontSize(int fontSize) {
        try {
            int ret = aidlPrint.iUpdateBuffer(ESDKConstant.FontSize.valueOf(fontSize));
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "iUpdatedBufferFontSize: Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }


    int iUpdatedBufferTextAlignment(int textAlignment) {
        try {
            int ret = aidlPrint.iUpdateBuffer(ESDKConstant.TextAlignment.valueOf(textAlignment));
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "iUpdatedBufferTextAlignment: Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int printText(String data) {
        try {
            aidlPrint.printText(data);
            return ESDKConstant.PRINTER_SUCCESS;
        } catch (Exception e) {
            Log.e(TAG, "printText: Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }


    int printImg(ArrayList<Integer> data) {
        try {
            byte[] byteData = arrayListToByteArray(data);
            Bitmap bitmap = BitmapFactory.decodeByteArray(byteData, 0, byteData.length);
            aidlPrint.printImg(bitmap);
            return ESDKConstant.PRINTER_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(TAG, "printImg : Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int closePrinter() {
        Log.e(TAG, "closePrinter: Printer Closed");
        context.unbindService(printerServiceConnection);
        aidlPrint = null;
        return ESDKConstant.PRINTER_SUCCESS;
    }

    private byte[] arrayListToByteArray(ArrayList<Integer> data) throws IOException {
        ByteArrayOutputStream byteOut = new ByteArrayOutputStream();
        DataOutputStream out = new DataOutputStream(byteOut);
        for (int element : data) {
            out.write(element);
        }
        return byteOut.toByteArray();
    }
}

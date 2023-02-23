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

import java.nio.charset.StandardCharsets;

public class PrinterService {

    private final String TAG = "PrinterService";
    private final Context context;
    private AidlPrint aidlPrint = null;

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


    int initPrinter() {
        if (aidlPrint == null) {
            Intent intent = new Intent();
            intent.setAction("com.evolute.service.printservice");
            intent.setPackage("com.evolute.sdkservice");
            context.bindService(intent, printerServiceConnection, Context.BIND_AUTO_CREATE);
            int count = 20;
            while (aidlPrint == null && count > 0) {
                try {
                    Thread.sleep(100);
                } catch (InterruptedException e) {
                    Log.e(TAG, "initPrinter: Error");
                }
                count--;
            }
            return ESDKConstant.PRINTER_SUCCESS;
        }
        return ESDKConstant.PRINTER_SUCCESS;
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


    int printImg(String data) {
        try {
            byte[] byteData = data.getBytes(StandardCharsets.UTF_8);
            Bitmap bitmap = BitmapFactory.decodeByteArray(byteData, 0, byteData.length);
            aidlPrint.printImg(bitmap);
            return ESDKConstant.PRINTER_SUCCESS;
        } catch (Exception e) {
            e.printStackTrace();
            Log.e(TAG, "print: Error : " + e.getMessage());
            return ESDKConstant.PRINTER_FAILURE;
        }
    }

    int closePrinter() {
        Log.e(TAG, "closePrinter: Printer Closed");
        aidlPrint = null;
        context.unbindService(printerServiceConnection);
        return ESDKConstant.PRINTER_SUCCESS;
    }
}

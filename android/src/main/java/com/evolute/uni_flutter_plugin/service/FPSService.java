package com.evolute.uni_flutter_plugin.service;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Handler;
import android.os.IBinder;
import android.os.Looper;
import android.os.Message;
import android.os.RemoteException;
import android.util.Log;

import androidx.annotation.NonNull;

import com.evolute.uni_flutter_plugin.utility.Utility;
import com.fpscommonSDK.fpssdkservice.FPS.AidlFPS;
import com.fpscommonSDK.fpssdkservice.FPS.FingerPositionCallback;
import com.fpscommonSDK.fpssdkservice.FPS.SDKConstants;
import com.fpscommonSDK.fpssdkservice.FPS.SensorResponse;
import com.fpscommonSDK.fpssdkservice.FPS.SensorVerifyImageResponse;
import com.fpscommonSDK.fpssdkservice.FPS.SensorVerifyResponse;
import com.fpscommonSDK.fpssdkservice.FPS.TemplateData;
import com.google.gson.Gson;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Map;
import java.util.concurrent.ExecutorService;
import java.util.concurrent.Executors;

import io.flutter.plugin.common.EventChannel;
import io.flutter.plugin.common.MethodChannel;

public class FPSService {

    private final String TAG = "PrinterService";
    private final Context context;
    private volatile AidlFPS aidlFPS = null;
    private final ExecutorService executorService = Executors.newFixedThreadPool(2);
    private final Gson gson = new Gson();
    private EventChannel.EventSink fingerPositionCallbackSink = null;

    private final ServiceConnection fpsServiceConnection = new ServiceConnection() {
        @Override
        public void onServiceConnected(ComponentName name, IBinder service) {
            aidlFPS = AidlFPS.Stub.asInterface(service);
            Log.e(TAG, "onServiceConnected: ");
        }

        @Override
        public void onServiceDisconnected(ComponentName name) {
            aidlFPS = null;
            Log.e(TAG, "onServiceDisconnected: ");
        }
    };

    private final FingerPositionCallback fingerPositionCallback = new FingerPositionCallback.Stub() {
        @Override
        public void getFingerPositionUpdates(int fingerPosition) {
            new Handler(Looper.getMainLooper()).post(() -> fingerPositionUpdate(fingerPosition));
        }
    };

    private void fingerPositionUpdate(int fingerPosition) {
        if (fingerPositionCallbackSink != null) {
            fingerPositionCallbackSink.success(fingerPosition);
        }
    }

    public final EventChannel.StreamHandler fingerPositionCallbackStreamHandler = new EventChannel.StreamHandler() {
        @Override
        public void onListen(Object arguments, EventChannel.EventSink events) {
            fingerPositionCallbackSink = events;
        }

        @Override
        public void onCancel(Object arguments) {
            fingerPositionCallbackSink = null;
        }
    };


    public FPSService(Context context) {
        this.context = context;
    }

    public void initFPS(MethodChannel.Result result) {
        if (aidlFPS == null) {
            Intent intent = new Intent();
            intent.setAction("com.fpscommonSDK.fpssdkservice.FPS_Service");
            intent.setPackage("com.fpscommonSDK.fpssdkservice");
            context.bindService(intent, fpsServiceConnection, Context.BIND_AUTO_CREATE);
            executorService.execute(() -> {
                int count = 10;
                while (aidlFPS == null && count > 0) {
                    try {
                        Thread.sleep(100);
                    } catch (InterruptedException e) {
                        Log.e(TAG, "initFPS: Error : " + e.getMessage());
                    }
                    Log.e(TAG, "initFPS: Value : " + count);
                    count--;
                }
                try {
                    if (aidlFPS != null) {
                        int ret = aidlFPS.InitFPS(SDKConstants.CommType_USB);
                        result.success(ret);
                    } else {
                        result.success(SDKConstants.SDK_ERR_INTERNAL);
                    }
                } catch (RemoteException e) {
                    Log.e(TAG, "initFPS: Error : " + e.getMessage());
                    result.success(SDKConstants.SDK_ERR_INTERNAL);
                }
            });
        } else {
            result.success(SDKConstants.SDK_OK);
        }
    }

    public void captureFPS(MethodChannel.Result result) {
        executorService.execute(() -> {
            try {
                SensorResponse sensorResponse = aidlFPS.captureFPS();
                String value = gson.toJson(sensorResponse, SensorResponse.class);
                result.success(value);
            } catch (Exception e) {
                Log.e(TAG, "captureFPS: Error: " + e.getMessage());
                SensorResponse sensorResponse = new SensorResponse();
                sensorResponse.responseCode = SDKConstants.SDK_ERR_INTERNAL;
                result.success(gson.toJson(sensorResponse, SensorResponse.class));
            }
        });
    }


    public int setTemplate(int template) {
        try {
            int ret = aidlFPS.setTemplate(template);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "setTemplate: Error: " + e.getMessage());
            return SDKConstants.SDK_ERR_INTERNAL;
        }
    }

    public int getTemplate() {
        try {
            int ret = aidlFPS.getTemplate();
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "getTemplate: Error: " + e.getMessage());
            return SDKConstants.SDK_ERR_INTERNAL;
        }
    }

    public int setImgCompressionAlgo(int compressionAlgorithm) {
        try {
            int ret = aidlFPS.setImgCompressionAlgo(compressionAlgorithm);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "setImgCompressionAlgo: Error: " + e.getMessage());
            return SDKConstants.SDK_ERR_INTERNAL;
        }
    }

    public int getImgCompressionAlgo() {
        try {
            int ret = aidlFPS.getImgCompressionAlgo();
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "getImgCompressionAlgo: Error: " + e.getMessage());
            return SDKConstants.SDK_ERR_INTERNAL;
        }
    }

    public int getImageQuality() {
        try {
            int ret = aidlFPS.getImageQuality();
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "getImageQuality: Error: " + e.getMessage());
            return SDKConstants.SDK_ERR_INTERNAL;
        }
    }

    public int setTimeout(int timeout) {
        try {
            int ret = aidlFPS.setTimeout(timeout);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "setTimeout: Error: " + e.getMessage());
            return SDKConstants.SDK_ERR_INTERNAL;
        }
    }

    public int getTimeout() {
        try {
            int ret = aidlFPS.getTimeout();
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "getTimeout: Error: " + e.getMessage());
            return SDKConstants.SDK_ERR_INTERNAL;
        }
    }

    public int setFFDSecurityLevel(int ffdSecurityLevel) {
        try {
            int ret = aidlFPS.setFFDSecurityLevel(ffdSecurityLevel);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "setFFDSecurityLevel: Error: " + e.getMessage());
            return SDKConstants.SDK_ERR_INTERNAL;
        }
    }

    public void verifyFPS(MethodChannel.Result result, ArrayList<Integer> fingerData1, boolean fingerDataEnabled) {
        executorService.execute(() -> {
            try {
                byte[] fingerData1Value = Utility.arrayListToByteArray(fingerData1);
                SensorVerifyImageResponse sensorVerifyImageResponse = aidlFPS.verifyFPS(fingerData1Value, fingerDataEnabled);
                result.success(gson.toJson(sensorVerifyImageResponse));
            } catch (Exception e) {
                Log.e(TAG, "verifyFPS: Error: " + e.getMessage());
                SensorVerifyImageResponse sensorVerifyImageResponse = new SensorVerifyImageResponse();
                sensorVerifyImageResponse.isMatched = false;
                sensorVerifyImageResponse.matchedTemplate = 0;
                sensorVerifyImageResponse.similarity = 0;
                sensorVerifyImageResponse.responseCode = SDKConstants.SDK_ERR_INTERNAL;
                result.success(gson.toJson(sensorVerifyImageResponse));
            }
        });
    }

    public String verifyFPSMatch(ArrayList<Integer> fingerData1, ArrayList<Integer> fingerData2) {
        try {
            byte[] fingerData1Value = Utility.arrayListToByteArray(fingerData1);
            byte[] fingerData2Value = Utility.arrayListToByteArray(fingerData2);
            SensorVerifyResponse sensorVerifyResponse = aidlFPS.verifyFPSMatch(fingerData1Value, fingerData2Value);
            return gson.toJson(sensorVerifyResponse);
        } catch (Exception e) {
            Log.e(TAG, "verifyFPSMatch: Error: " + e.getMessage());
            SensorVerifyResponse sensorVerifyResponse = new SensorVerifyResponse();
            sensorVerifyResponse.similarity = 0;
            sensorVerifyResponse.matchedTemplate = 0;
            sensorVerifyResponse.isMatched = false;
            sensorVerifyResponse.responseCode = SDKConstants.SDK_ERR_INTERNAL;
            return gson.toJson(sensorVerifyResponse);
        }
    }

    public void verifyFPSWithTemplate(MethodChannel.Result result, ArrayList<Map<String, ?>> data, boolean fingerDataEnabled) {
        executorService.execute(() -> {
            try {
                TemplateData[] templateData = getTemplateDataArray(data);
                SensorVerifyImageResponse sensorVerifyImageResponse = aidlFPS.verifyFPSWithTemplate(templateData, fingerDataEnabled);
                result.success(gson.toJson(sensorVerifyImageResponse));
            } catch (Exception e) {
                Log.e(TAG, "verifyFPSWithTemplate: Error: " + e.getMessage());
                SensorVerifyImageResponse sensorVerifyImageResponse = new SensorVerifyImageResponse();
                sensorVerifyImageResponse.isMatched = false;
                sensorVerifyImageResponse.matchedTemplate = 0;
                sensorVerifyImageResponse.similarity = 0;
                sensorVerifyImageResponse.responseCode = SDKConstants.SDK_ERR_INTERNAL;
                result.success(gson.toJson(sensorVerifyImageResponse));
            }
        });
    }

    public String getFPSDeviceInfo() {
        try {
            com.fpscommonSDK.fpssdkservice.FPS.FPSDeviceInfo fpsDeviceInfo = aidlFPS.getFPSDeviceInfo();
            return gson.toJson(fpsDeviceInfo);
        } catch (Exception e) {
            Log.e(TAG, "getFPSDeviceInfo: Error: " + e.getMessage());
            com.fpscommonSDK.fpssdkservice.FPS.FPSDeviceInfo fpsDeviceInfo = new com.fpscommonSDK.fpssdkservice.FPS.FPSDeviceInfo();
            fpsDeviceInfo.setResponseCode(SDKConstants.SDK_ERR_INTERNAL);
            return gson.toJson(fpsDeviceInfo);
        }
    }

    public int enableFingerPositionUpdates() {
        try {
            int ret = aidlFPS.enableFingerPositionUpdates(fingerPositionCallback);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "enableFingerPositionUpdates: Error: " + e.getMessage());
            return SDKConstants.SDK_ERR_INTERNAL;
        }
    }

    public int disableFingerPositionUpdates() {
        try {
            int ret = aidlFPS.enableFingerPositionUpdates(null);
            return ret;
        } catch (Exception e) {
            Log.e(TAG, "disableFingerPositionUpdates: Error: " + e.getMessage());
            return SDKConstants.SDK_ERR_INTERNAL;
        }
    }

    public int closeFPS() {
        if (aidlFPS != null) {
            Log.e(TAG, "closeFPS: FPS Closed");
            context.unbindService(fpsServiceConnection);
            aidlFPS = null;
        }
        return SDKConstants.SDK_OK;
    }

    private TemplateData[] getTemplateDataArray(ArrayList<Map<String, ?>> data) throws IOException {
        TemplateData[] templateData = new TemplateData[data.size()];
        for (int i = 0; i < data.size(); i++) {
            byte[] fingerData = Utility.arrayListToByteArray((ArrayList<Integer>) data.get(i).get("template_data"));
            templateData[i] = new TemplateData(fingerData, (int) data.get(i).get("template_type"));
        }
        return templateData;
    }
}

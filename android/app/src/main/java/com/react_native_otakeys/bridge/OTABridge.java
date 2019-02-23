package com.react_native_otakeys.bridge;

import android.content.Context;

import com.facebook.react.bridge.Promise;
import com.facebook.react.bridge.ReactApplicationContext;
import com.facebook.react.bridge.ReactContextBaseJavaModule;
import com.facebook.react.bridge.ReactMethod;
import com.otakeys.sdk.service.OtaKeysService;
import com.otakeys.sdk.service.api.callback.AuthenticateCallback;
import com.otakeys.sdk.service.api.callback.CreateKeyCallback;
import com.otakeys.sdk.service.api.callback.EnableKeyCallback;
import com.otakeys.sdk.service.api.callback.EndKeyCallback;
import com.otakeys.sdk.service.api.callback.GenerateTokensCallback;
import com.otakeys.sdk.service.api.callback.GetKeyCallback;
import com.otakeys.sdk.service.api.callback.GetKeysCallback;
import com.otakeys.sdk.service.api.callback.SyncVehicleDataCallback;
import com.otakeys.sdk.service.api.callback.UpdateKeyCallback;
import com.otakeys.sdk.service.api.enumerator.ApiCode;
import com.otakeys.sdk.service.api.enumerator.HttpStatus;
import com.otakeys.sdk.service.api.enumerator.Url;
import com.otakeys.sdk.service.ble.callback.BleConnectionCallback;
import com.otakeys.sdk.service.ble.callback.BleDisableEngineCallback;
import com.otakeys.sdk.service.ble.callback.BleDisconnectionCallback;
import com.otakeys.sdk.service.ble.callback.BleEnableEngineCallback;
import com.otakeys.sdk.service.ble.callback.BleLockDoorsCallback;
import com.otakeys.sdk.service.ble.callback.BleScanCallback;
import com.otakeys.sdk.service.ble.callback.BleUnlockDoorsCallback;
import com.otakeys.sdk.service.ble.callback.BleUnnamedActionFiveCallback;
import com.otakeys.sdk.service.ble.callback.BleUnnamedActionFourCallback;
import com.otakeys.sdk.service.ble.callback.BleUnnamedActionOneCallback;
import com.otakeys.sdk.service.ble.callback.BleUnnamedActionSixCallback;
import com.otakeys.sdk.service.ble.callback.BleUnnamedActionThreeCallback;
import com.otakeys.sdk.service.ble.callback.BleUnnamedActionTwoCallback;
import com.otakeys.sdk.service.ble.callback.BleVehicleDataCallback;
import com.otakeys.sdk.service.ble.enumerator.BleError;
import com.otakeys.sdk.service.core.callback.SwitchToKeyCallback;
import com.otakeys.sdk.service.nfc.callback.LastNfcDataCallback;
import com.otakeys.sdk.service.nfc.callback.NfcEventCallback;
import com.otakeys.sdk.service.nfc.enumerator.NfcError;
import com.otakeys.sdk.service.object.request.OtaSessionRequest;
import com.otakeys.sdk.service.object.response.OtaEvent;
import com.otakeys.sdk.service.object.response.OtaKey;
import com.otakeys.sdk.service.object.response.OtaLastVehicleData;
import com.otakeys.sdk.service.object.response.OtaVehicleData;
import com.react_native_otakeys.MainActivity;
import com.react_native_otakeys.Utils.OTASDKUtils;

import java.util.List;

public class OTABridge extends ReactContextBaseJavaModule {

  private Context context;

  OTABridge(ReactApplicationContext reactContext) {
      super(reactContext);
      context = reactContext;
  }

  private OtaKeysService getOtaSdk() {
    if (context instanceof  MainActivity) {
      return ((MainActivity) context).getOtaKeysService();
    }

    return null;
  }

  @Override
  public String getName() {
      return "OTABridge";
  }

  /*
   The easiest way to start creating a bridge, send a string get it back and print
   I left this one just for an example so you guys can use as a guide
   */
  @ReactMethod
  public void printSomething(String awesomeText, Promise promise) {
    if (awesomeText != null)
      promise.resolve(awesomeText);
    else
      promise.reject("error", "C'mom gimme some text!");
  }

  @ReactMethod
  public void configureEnvironment(String url, Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      try {
        Url otaUrl = Url.valueOf(url);
        getOtaSdk().configureEnvironment(otaUrl);
        promise.resolve(true);
      } catch (Exception e) {
        promise.reject("configureEnvironment", "Error trying to configure Environment");
      }
    }
  }

  @ReactMethod
  public void getAccessDeviceToken(Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      promise.resolve(getOtaSdk().getAccessDeviceToken());
    }
  }

  @ReactMethod
  public void accessDeviceTokenWithForceRefresh(boolean forceReload, Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      promise.resolve(getOtaSdk().getAccessDeviceToken(forceReload));
    }
  }

  /*
    No iOS esse método recebe uma String com o token, não sei qual é o atributo do @OtaSessionRequest
    que representa este token, então vou deixar um snnipet aqui.

    @ReactMethod
    public void openSessionWithToken(String token, final Promise promise) {
      if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
        OtaSessionRequest sessionRequest = new OtaSessionRequest();
        sessionRequest.<AQUI O ATRIBUTO ONDE VOCES TEM QUE SETAR O TOKEN> = token;
        getOtaSdk().openSession(sessionRequest, new AuthenticateCallback() {
          @Override
          public void onAuthenticated() {
            promise.resolve(true);
          }

          @Override
          public void onApiError(HttpStatus httpStatus, ApiCode apiCode) {
            OTABridge.onApiError(promise, httpStatus, apiCode);
          }
        });
      }
   */
  @ReactMethod
  public void openSession(String otaSessionRequestJson, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      OtaSessionRequest sessionRequest = OTASDKUtils.getOtaSessionRequestFromJson(otaSessionRequestJson);
      getOtaSdk().openSession(sessionRequest, new AuthenticateCallback() {
        @Override
        public void onAuthenticated() {
          promise.resolve(true);
        }

        @Override
        public void onApiError(HttpStatus httpStatus, ApiCode apiCode) {
          OTABridge.onApiError(promise, httpStatus, apiCode);
        }
      });
    }
  }

  @ReactMethod
  public void createKey(String otaKeyRequestJson, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().createKey(OTASDKUtils.getOtaKeyRequestFromJson(otaKeyRequestJson), new CreateKeyCallback() {
        @Override
        public void onCreateKey(OtaKey otaKey) {
          promise.resolve(OTASDKUtils.getJsonFromOtaKey(otaKey));
        }

        @Override
        public void onApiError(HttpStatus httpStatus, ApiCode apiCode) {
          OTABridge.onApiError(promise, httpStatus, apiCode);
        }
      });
    }
  }

  @ReactMethod
  public void authenticated(Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      if (getOtaSdk().isAuthenticated())
        promise.resolve(true);
      else
        promise.reject("Error", "Error get informed by authentication status");
    }
  }

  @ReactMethod
  public void enableKey(String otaKeyRequestJson, final Promise promise) {
    if(OTASDKUtils.isSdkReady()) {
      getOtaSdk().enableKey(OTASDKUtils.getOtaKeyRequestFromJson(otaKeyRequestJson), new EnableKeyCallback() {
        @Override
        public void onEnableKey(OtaKey otaKey) {
          promise.resolve(OTASDKUtils.getJsonFromOtaKey(otaKey));
        }

        @Override
        public void onApiError(HttpStatus httpStatus, ApiCode apiCode) {
          OTABridge.onApiError(promise, httpStatus, apiCode);
        }
      });
    }
  }

  @ReactMethod
  public void generateTokens(String otaKeyRequestJson, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().generateVirtualKeys(OTASDKUtils.getOtaKeyRequestFromJson(otaKeyRequestJson), new GenerateTokensCallback() {
        @Override
        public void onTokensUpdated(OtaKey otaKey) {
          promise.resolve(OTASDKUtils.getJsonFromOtaKey(otaKey));
        }

        @Override
        public void onApiError(HttpStatus httpStatus, ApiCode apiCode) {
          OTABridge.onApiError(promise, httpStatus, apiCode);
        }
      });
    }
  }

  @ReactMethod
  public void updateKey(String otaKeyRequestJson, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().updateKey(OTASDKUtils.getOtaKeyRequestFromJson(otaKeyRequestJson), new UpdateKeyCallback() {
        @Override
        public void onUpdateKey(OtaKey otaKey) {
          promise.resolve(OTASDKUtils.getJsonFromOtaKey(otaKey));
        }

        @Override
        public void onApiError(HttpStatus httpStatus, ApiCode apiCode) {
          OTABridge.onApiError(promise, httpStatus, apiCode);
        }
      });
    }
  }

  @ReactMethod
  public void endKey(String otaKeyRequestJson, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().endKey(OTASDKUtils.getOtaKeyRequestFromJson(otaKeyRequestJson), new EndKeyCallback() {
        @Override
        public void onEndKey(OtaKey otaKey) {
          promise.resolve(OTASDKUtils.getJsonFromOtaKey(otaKey));
        }

        @Override
        public void onApiError(HttpStatus httpStatus, ApiCode apiCode) {
          OTABridge.onApiError(promise, httpStatus, apiCode);
        }
      });
    }
  }

  @ReactMethod
  public void getKey(String otaKeyRequestJson, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().getKey(OTASDKUtils.getOtaKeyRequestFromJson(otaKeyRequestJson), new GetKeyCallback() {
        @Override
        public void onGetKey(OtaKey otaKey) {
          promise.resolve(OTASDKUtils.getJsonFromOtaKey(otaKey));
        }

        @Override
        public void onApiError(HttpStatus httpStatus, ApiCode apiCode) {
          OTABridge.onApiError(promise, httpStatus, apiCode);
        }
      });
    }
  }

  @ReactMethod
  public void keysWithSuccess(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().getKeys(new GetKeysCallback() {
        @Override
        public void onGetKeys(List<OtaKey> list) {
          promise.resolve(OTASDKUtils.getJsonFromOtaKeys(list));
        }

        @Override
        public void onApiError(HttpStatus httpStatus, ApiCode apiCode) {
          OTABridge.onApiError(promise, httpStatus, apiCode);
        }
      });
    }
  }

  @ReactMethod
  public void syncVehicleDataWithSuccess(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().syncVehicleData(new SyncVehicleDataCallback() {
        @Override
        public void onVehicleDataSync() {
          promise.resolve(true);
        }

        @Override
        public void onApiError(HttpStatus httpStatus, ApiCode apiCode) {
          OTABridge.onApiError(promise, httpStatus, apiCode);
        }
      });
    }
  }

  @ReactMethod
  public void registerBleEvents(int id, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && context instanceof MainActivity) {
      promise.resolve(getOtaSdk().registerBleEvents(id, ((MainActivity) context)));
    }
  }

  @ReactMethod
  public void scan(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().scan(new BleScanCallback() {
        @Override
        public void onDeviceFound() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void stopScanning(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().stopScanning();
      promise.resolve(true);
    }
  }

  @ReactMethod
  public void connect(boolean showNotification, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().connect(showNotification, new BleConnectionCallback() {
        @Override
        public void onConnected() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void disconnect(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().disconnect(new BleDisconnectionCallback() {
        @Override
        public void onDisconnected() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void unlockDoorsWithRequestVehicleData(boolean requesVehicleData, boolean authStart, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().unlockDoors(requesVehicleData, authStart, new BleUnlockDoorsCallback() {
        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void lockDoorsWithRequestVehicleData(boolean requestVehicleData, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().lockDoors(requestVehicleData, new BleLockDoorsCallback() {
        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void enableEngineWithRequestVehicleData(boolean requestVehicleData, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().enableEngine(requestVehicleData, new BleEnableEngineCallback() {
        @Override
        public void onEnableEngine() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void disableEngineWithRequestVehicleData(boolean requestVehicleData, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().disableEngine(requestVehicleData, new BleDisableEngineCallback() {
        @Override
        public void onDisableEngine() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void getVehicleData(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().getVehicleData(new BleVehicleDataCallback() {
        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void unnamedAction1WithRequestVehicleData(boolean requestVehicleData, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().unnamedActionOne(requestVehicleData, new BleUnnamedActionOneCallback() {

        @Override
        public void onUnnamedActionOne() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void unnamedAction2WithRequestVehicleData(boolean requestVehicleData, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().unnamedActionTwo(requestVehicleData, new BleUnnamedActionTwoCallback() {

        @Override
        public void onUnnamedActionTwo() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void unnamedAction3WithRequestVehicleData(boolean requestVehicleData, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().unnamedActionThree(requestVehicleData, new BleUnnamedActionThreeCallback() {

        @Override
        public void onUnnamedActionThree() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void unnamedAction4WithRequestVehicleData(boolean requestVehicleData, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().unnamedActionFour(requestVehicleData, new BleUnnamedActionFourCallback() {

        @Override
        public void onUnnamedActionFour() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void unnamedAction5WithRequestVehicleData(boolean requestVehicleData, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().unnamedActionFive(requestVehicleData, new BleUnnamedActionFiveCallback() {

        @Override
        public void onUnnamedActionFive() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void unnamedAction6WithRequestVehicleData(boolean requestVehicleData, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().unnamedActionSix(requestVehicleData, new BleUnnamedActionSixCallback() {

        @Override
        public void onUnnamedActionSix() {
          promise.resolve(true);
        }

        @Override
        public void onBleError(BleError bleError) {
          promise.reject("BleError", bleError.name());
        }
      });
    }
  }

  @ReactMethod
  public void connectedToVehicle(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      promise.resolve(getOtaSdk().isConnectedToVehicle());
    }
  }

  @ReactMethod
  public void getBluetoothState(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      promise.resolve(getOtaSdk().getBluetoothState().name());
    }
  }

  @ReactMethod
  public void isOperationInProgress(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      promise.resolve(getOtaSdk().isOperationInProgress());
    }
  }

  @ReactMethod
  public void setNfcEnabled(boolean enabled, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().setNfcEnabled(enabled);
      promise.resolve(true);
    }
  }

  @ReactMethod
  public void getLastNfcData(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().getLastNfcData(new LastNfcDataCallback() {
        @Override
        public void onNfcLastData(OtaEvent otaEvent, OtaVehicleData otaVehicleData) {
          promise.resolve(OTASDKUtils.getJsonFromOtaVehicleData(otaVehicleData));
        }

        @Override
        public void onNfcError(NfcError nfcError) {
          promise.reject("NfcError", nfcError.name());
        }
      });
    }
  }

  @ReactMethod
  public void registerNfcEvent(int id, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().registerNfcEvent(id, new NfcEventCallback() {
        @Override
        public void onNfcEvent(OtaEvent otaEvent, OtaVehicleData otaVehicleData) {
          promise.resolve(OTASDKUtils.getJsonFromOtaVehicleData(otaVehicleData));
        }

        @Override
        public void onNfcError(NfcError nfcError) {
          promise.reject("NfcError", nfcError.name());
        }
      });
    }
  }

  @ReactMethod
  public void unregisterNfcEvent(int id, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null)
      promise.resolve(getOtaSdk().unregisterNfcEvent(id));
  }

  @ReactMethod
  public void getVehicleDataHistory(String otaKeyJson, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      List<OtaVehicleData> otaVehiclesData =
              getOtaSdk().getVehicleDataHistory(OTASDKUtils.getOtaKeyFromJson(otaKeyJson));

      if (otaVehiclesData != null || !otaVehiclesData.isEmpty())
        promise.resolve(OTASDKUtils.getJsonFromOtaVehicleDataList(otaVehiclesData));
      else
        promise.reject("Error", "Error getting data from vehicle data history.");
    }
  }

  @ReactMethod
  public void localKeys(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      List<OtaKey> otaKeys = getOtaSdk().getLocalKeys();
      if (otaKeys != null || !otaKeys.isEmpty())
        promise.resolve(OTASDKUtils.getJsonFromOtaKeys(otaKeys));
      else
        promise.reject("Error", "Error getting local keys.");
    }
  }

  @ReactMethod
  public void localKey(long id, String extId, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      OtaKey key = getOtaSdk().getOtaKey(id, extId);
      if (key != null)
        promise.resolve(OTASDKUtils.getJsonFromOtaKey(key));
    }
  }

  @ReactMethod
  public void isAuthenticated(Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      promise.resolve(getOtaSdk().isAuthenticated());
    }
  }

  @ReactMethod
  public void vehicleDataWithSuccess(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      final OtaVehicleData vehicleData = getOtaSdk().getLastVehicleData();
      if (vehicleData != null)
        promise.resolve(OTASDKUtils.getJsonFromOtaVehicleData(vehicleData));
      else
        promise.reject("Error", "Error getting vehicle data with success.");
    }
  }

  @ReactMethod
  public void lastVehicleSynthesisWithSuccess(String otaKeyJson, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      OtaKey key = OTASDKUtils.getOtaKeyFromJson(otaKeyJson);
      final OtaLastVehicleData lastVehicleData = getOtaSdk().getLastVehicleData(key);
      if (lastVehicleData != null)
        promise.resolve(OTASDKUtils.getJsonFromOtaLastVehicleData(lastVehicleData));
      else
        promise.reject("Error", "Error getting last vehicle synthesis with success.");
    }
  }

  @ReactMethod
  public void configureNetworkTimeouts(int connectTimeout, int readTimeout, Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      promise.resolve(getOtaSdk().configureNetworkTimeouts(connectTimeout, readTimeout));
    }
  }

  @ReactMethod
  public void switchToKeyWithId(String otaKeyId, final Promise promise) {
    OtaKey otaKey = new OtaKey();
    otaKey.setOtaId(Long.getLong(otaKeyId));
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().switchToKey(otaKey, new SwitchToKeyCallback() {
        @Override
        public void onKeySwitched(OtaKey otaKey) {
          promise.resolve(OTASDKUtils.getJsonFromOtaKey(otaKey));
        }
      });
    }
  }

  @ReactMethod
  public void currentKey(final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      OtaKey key = getOtaSdk().getUsedKey();
      if (key != null)
        promise.resolve(OTASDKUtils.getJsonFromOtaKey(key));
      else
        promise.reject("Error", "Error getting current key.");
    }
  }

  @ReactMethod
  public void getRemainingTokenAmount(String otaKeyJson, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      OtaKey key = OTASDKUtils.getOtaKeyFromJson(otaKeyJson);
      promise.resolve(getOtaSdk().getRemainingTokenAmount(key));
    }
  }

  @ReactMethod
  public void cleanTokens(String otaKeyJson, final Promise promise) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      OtaKey key = OTASDKUtils.getOtaKeyFromJson(otaKeyJson);
      promise.resolve(getOtaSdk().cleanTokens(key));
    }
  }

  @ReactMethod
  public void enablePhoneGpsPosition(boolean enable) {
    if (OTASDKUtils.isSdkReady() && getOtaSdk() != null) {
      getOtaSdk().enablePhoneGpsPosition(enable);
    }
  }

  private static void onApiError(Promise promise, HttpStatus httpStatus, ApiCode apiCode) {
    promise.reject(String.valueOf(httpStatus.ordinal()), apiCode.name());
  }
}

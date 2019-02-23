package com.react_native_otakeys;

import android.content.ComponentName;
import android.content.Context;
import android.content.Intent;
import android.content.ServiceConnection;
import android.os.Bundle;
import android.os.IBinder;

import com.facebook.react.ReactActivity;
import com.otakeys.sdk.service.OtaKeysService;
import com.otakeys.sdk.service.ble.callback.BleListener;
import com.otakeys.sdk.service.ble.enumerator.BluetoothState;
import com.otakeys.sdk.service.object.response.OtaOperation;
import com.otakeys.sdk.service.object.response.OtaState;
import com.react_native_otakeys.Utils.OTASDKUtils;

public class MainActivity extends ReactActivity implements BleListener {

  private static Intent callingIntent;

  public OtaKeysService mOtaKeysService;
  /**
   * Returns the name of the main component registered from JavaScript.
   * This is used to schedule rendering of the component.
   */
  @Override
  protected String getMainComponentName() {
      return "react_native_otakeys";
  }

  @Override
  protected void onCreate(Bundle savedInstanceState) {
    super.onCreate(savedInstanceState);

    if (!OTASDKUtils.isSdkReady()) {
        callingIntent = new Intent(this, OtaKeysService.class);
        bindService(callingIntent, mConnection, BIND_AUTO_CREATE);
    }
  }

  public OtaKeysService getOtaKeysService() {
    return mOtaKeysService;
  }

  public static Intent getCallingIntent(Context context) {
    return callingIntent != null ? callingIntent : new Intent();
  }

  private ServiceConnection mConnection = new ServiceConnection() {
    @Override
    public void onServiceConnected(ComponentName className, IBinder service) {
        OtaKeysService.SekorBinder binder = (OtaKeysService.SekorBinder) service;
        mOtaKeysService = binder.getService();
        OTASDKUtils.setSdkReady(true);
    }
    @Override
    public void onServiceDisconnected(ComponentName arg0) {
        OTASDKUtils.setSdkReady(false);
    }
  };

  @Override
  public void onActionPerformed(OtaOperation otaOperation, OtaState otaState) {

  }

  @Override
  public void onBluetoothStateChanged(BluetoothState bluetoothState, BluetoothState bluetoothState1) {

  }
}

package com.app;

import android.os.Bundle;

import com.facebook.react.ReactActivity;
import com.otakeys.sdk.service.OtaKeysService;
import com.otakeys.sdk.service.ble.callback.BleListener;
import com.otakeys.sdk.service.ble.enumerator.BluetoothState;
import com.otakeys.sdk.service.object.response.OtaOperation;
import com.otakeys.sdk.service.object.response.OtaState;

public class MainActivity extends ReactActivity implements BleListener {

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
  }

  public OtaKeysService getOtaKeysService(MainActivity activity) {
    return activity.getOtaKeysServicePrivate();
  }

  private OtaKeysService getOtaKeysServicePrivate() {
    return mOtaKeysService;
  }

  @Override
  public void onActionPerformed(OtaOperation otaOperation, OtaState otaState) {

  }

  @Override
  public void onBluetoothStateChanged(BluetoothState bluetoothState, BluetoothState bluetoothState1) {

  }
}

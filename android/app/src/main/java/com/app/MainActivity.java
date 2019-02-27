package com.app;

import android.os.Bundle;

import com.facebook.react.ReactActivity;
import com.otakeys.sdk.service.OtaKeysService;

public class MainActivity extends ReactActivity {

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
}

package com.react_native_otakeys.Utils;

import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.google.gson.TypeAdapter;
import com.google.gson.stream.JsonReader;
import com.google.gson.stream.JsonWriter;
import com.otakeys.sdk.service.object.request.OtaKeyRequest;
import com.otakeys.sdk.service.object.request.OtaSessionRequest;
import com.otakeys.sdk.service.object.response.OtaKey;
import com.otakeys.sdk.service.object.response.OtaLastVehicleData;
import com.otakeys.sdk.service.object.response.OtaVehicleData;

import org.joda.time.DateTime;

import java.io.IOException;
import java.util.List;

public class OTASDKUtils {
  private static boolean SDK_READY = false;

  public static OtaSessionRequest getOtaSessionRequestFromJson(String json) {
    return getGson().fromJson(json, OtaSessionRequest.class);
  }

  public static OtaKeyRequest getOtaKeyRequestFromJson(String json) {
    Gson gson = getGson();
    return gson.fromJson(json, OtaKeyRequest.class);
  }

  public static OtaKey getOtaKeyFromJson(String json) {
    Gson gson = getGson();
    return gson.fromJson(json, OtaKey.class);
  }

  public static boolean isSdkReady() {
      return SDK_READY;
  }

  public static void setSdkReady(boolean isReady) {
      SDK_READY = isReady;
  }

  public static String getJsonFromOtaKey(OtaKey key) {
    Gson gson = getGson();
    return gson.toJson(key);
  }

  public static String getJsonFromOtaKeys(List<OtaKey> keys) {
    Gson gson = getGson();
    return gson.toJson(keys);
  }

  public static String getJsonFromOtaVehicleData(OtaVehicleData otaVehicleData) {
    Gson gson = getGson();
    return gson.toJson(otaVehicleData);
  }

  public static String getJsonFromOtaVehicleDataList(List<OtaVehicleData> otaVehiclesData) {
    return getGson().toJson(otaVehiclesData);
  }

  public static String getJsonFromOtaLastVehicleData(OtaLastVehicleData otaLastVehicleData) {
    return getGson().toJson(otaLastVehicleData);
  }

  private static Gson getGson() {
    return new GsonBuilder()
            .registerTypeAdapter(DateTime.class, new DateLongFormatTypeAdapter())
            .create();
  }
}

class DateLongFormatTypeAdapter extends TypeAdapter<DateTime> {

  @Override
  public void write(JsonWriter out, DateTime value) throws IOException {
    out.value(value.getMillis());
  }

  @Override
  public DateTime read(JsonReader in) throws IOException {
    return new DateTime(in.nextLong());
  }

}

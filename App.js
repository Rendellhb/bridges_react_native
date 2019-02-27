/**
 * OTASDK API - Implemented only for iOS
 * https://github.com/Rendellhb
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, { Component } from 'react';
import {
  StyleSheet,
  Text,
  View,
  Button,
  ScrollView,
  NativeModules,
  Platform
} from 'react-native';

let isAndroidServiceReady = false;

const lastVehicleSynthesis = {
  lastCaptureDate: 1550685803,
  gpsCoordinates: {
    initialCaptureDate: 1550685803,
    lastCaptureDate: 1550685803,
    latitude: -9873.084,
    longitude: 727734.09884,
  },
  doorsState: 1,
  engineRunning: true,
  lastMileageCaptureDate: 1550685803,
  mileage: 234,
  lastEnergyCaptureDate: 1550685803,
  energyLevel: 2,
  batteryVoltage: 12,
  connectedToCharger: false,
  malfunctionIndicatorLamp: false,
  energyType: 0,
  fuelUnit: 0,
  odometerUnit: 1,
  activeDtcNumber: 2
};

const vehicleData = {
  date: 1550685803,
  mileageStart: 23784,
  mileageCurrent: 893795,
  connectedToLoader: true,
  energyStart: 9374,
  energyCurrent: 91,
  engineRunning: false,
  doorsState: 0,
  malfunctionIndicatorLamp: true,
  gpsLatitude: -9873.084,
  gpsLongitude: 727734.09884,
  gpsAccuracy: 30,
  gpsCaptureDate: 1550685803,
  gprsLatitude: 8374,
  gprsLongitude: 9264,
  gprsLastCaptureDate: 1550685803,
  gprsInitialCaptureDate: 1550685803,
  lastMileageCaptureDate: 1550685803,
  lastEnergyCaptureDate: 1550685803,
  fuelUnit: 1,
  odometerUnit: 1,
  synthesisVersion: 2,
  activeDtcErrorCode: 3,
  batteryVoltage: 12,
  energyType: 1,
  distanceType: 2,
  timestamp: 1550520159,
  sdkGpsLatitude: 773,
  sdkGpsLongitude: 97623,
  sdkGpsAccuracy: 823664,
  sdkGpsCaptureDate: 1550685803
};

const otaKeyRequest = {
  otaId: '1',
  extId: '1',
  beginDate: 1550685803,
  endDate: 1550685803,
  vehicleId: '1',
  vehicleExtId: '1',
  enableNow: true,
  tokenAmount: '16',
  singleShotSecurity: true,
  security: 'token'
};

const otaKeyPublic = {
  otaId: '1',
  extId: '1',
  beginDate: 1550685803,
  endDate: 1550685803,
  enabled: true,
  mileageLimit: '16',
  singleShotSecurity: true,
  keyArgs: 'keyArgs',
  keySensitiveArgs: 'KeySensitiveArgs',
  vehicle: {
    otaId: '1',
    extId: '1',
    vin: 'vin',
    brand: 'brand',
    model: 'model',
    plate: 'plate',
    year: 1998,
    enabled: true,
    engine: 'engine',
    mileageOffset: '123',
    vehicleData
  },
  lastVehicleSynthesis
};

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = { something: '' };

    if (Platform.OS === 'android') this.startService();
  }

  async getAccessDeviceToken() {
    try {
      const result = await NativeModules.OTABridge.getAccessDeviceToken();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async authenticated() {
    try {
      const result = await NativeModules.OTABridge.authenticated();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async configureWithAppId() {
    try {
      const result = await NativeModules.OTABridge.configureWithAppId('appId', 'sdkInstanceId');
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async closeSession() {
    try {
      const result = await NativeModules.OTABridge.closeSession();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async switchToKeyWithID() {
    try {
      const result = await NativeModules.OTABridge.switchToKeyWithID('otaKey');
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async accessDeviceTokenWithForceRefresh() {
    try {
      const result = await NativeModules.OTABridge.accessDeviceTokenWithForceRefresh(false);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async createKey() {
    try {
      const result = await NativeModules.OTABridge.createKey(JSON.stringify(otaKeyRequest));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async updateKey() {
    try {
      const result = await NativeModules.OTABridge.updateKey(JSON.stringify(otaKeyRequest));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async enableKey() {
    try {
      const result = await NativeModules.OTABridge.enableKey(JSON.stringify(otaKeyRequest));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async endKey() {
    try {
      const result = await NativeModules.OTABridge.endKey(JSON.stringify(otaKeyRequest));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async endKeyWithId() {
    try {
      const result = await NativeModules.OTABridge.endKeyWithId('keyID');
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async keysWithSuccess() {
    try {
      const result = await NativeModules.OTABridge.keysWithSuccess();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }


  async scanForVehicleWithCompletion() {
    try {
      const result = await NativeModules.OTABridge.scanForVehicleWithCompletion();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async scanForVehicleWithTimeout() {
    try {
      const result = await NativeModules.OTABridge.scanForVehicleWithTimeout(30);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async connectToVehicle() {
    try {
      const result = await NativeModules.OTABridge.connectToVehicle();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async connectToVehicleWithCompletion() {
    try {
      const result = await NativeModules.OTABridge.connectToVehicleWithCompletion();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async connectToVehicleWithTimeout() {
    try {
      const result = await NativeModules.OTABridge.connectToVehicleWithTimeout(30);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async connectedToVehicle() {
    try {
      const result = await NativeModules.OTABridge.connectedToVehicle();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async isAuthenticated() {
    try {
      const result = await NativeModules.OTABridge.isAuthenticated();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async currentConnectionStatus() {
    try {
      const result = await NativeModules.OTABridge.currentConnectionStatus();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async disconnectFromVehicle() {
    try {
      const result = await NativeModules.OTABridge.disconnectFromVehicle();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async unlockDoorsWithRequestVehicleData() {
    try {
      const result = await NativeModules.OTABridge.unlockDoorsWithRequestVehicleData(true, true);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async lockDoorsWithRequestVehicleData() {
    try {
      const result = await NativeModules.OTABridge.lockDoorsWithRequestVehicleData(true);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async vehicleDataWithSuccess() {
    try {
      const result = await NativeModules.OTABridge.vehicleDataWithSuccess();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async lastVehicleSynthesisWithSuccess() {
    try {
      const result = await NativeModules.OTABridge.lastVehicleSynthesisWithSuccess(JSON.stringify(otaKeyPublic));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async lastVehicleSynthesis() {
    try {
      const result = await NativeModules.OTABridge
        .lastVehicleSynthesis(JSON.stringify(otaKeyRequest));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async lastVehicleSynthesisForKeyWithId() {
    try {
      const result = await NativeModules.OTABridge.lastVehicleSynthesisForKeyWithId('keyId');
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async enableEngineWithRequestVehicleData() {
    try {
      const result = await NativeModules.OTABridge.enableEngineWithRequestVehicleData(true);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async disableEngineWithRequestVehicleData() {
    try {
      const result = await NativeModules.OTABridge.disableEngineWithRequestVehicleData(true);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async unnamedAction1WithRequestVehicleData() {
    try {
      const result = await NativeModules.OTABridge
        .unnamedAction1WithRequestVehicleData(true);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async unnamedAction2WithRequestVehicleData() {
    try {
      const result = await NativeModules.OTABridge
        .unnamedAction2WithRequestVehicleData(false);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async unnamedAction3WithRequestVehicleData() {
    try {
      const result = await NativeModules.OTABridge
        .unnamedAction3WithRequestVehicleData(JSON.stringify(true));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async unnamedAction4WithRequestVehicleData() {
    try {
      const result = await NativeModules.OTABridge
        .unnamedAction4WithRequestVehicleData(false);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async unnamedAction5WithRequestVehicleData() {
    try {
      const result = await NativeModules.OTABridge
        .unnamedAction5WithRequestVehicleData(true);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async unnamedAction6WithRequestVehicleData() {
    try {
      const result = await NativeModules.OTABridge
        .unnamedAction6WithRequestVehicleData(false);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async generateTokens() {
    try {
      const result = await NativeModules.OTABridge.generateTokens(JSON.stringify(otaKeyRequest));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async localKeys() {
    try {
      const result = await NativeModules.OTABridge.localKeys(1234567890, '1');
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async localKey() {
    try {
      const result = await NativeModules.OTABridge.localKey();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async currentKey() {
    try {
      const result = await NativeModules.OTABridge.currentKey();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async syncVehicleDataWithSuccess() {
    try {
      const result = await NativeModules.OTABridge.syncVehicleDataWithSuccess();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async activateLogging() {
    try {
      const result = await NativeModules.OTABridge.activateLogging(true);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async localKeyWithCompletionBlock() {
    try {
      const result = await NativeModules.OTABridge
        .localKeyWithCompletionBlock(JSON.stringify(otaKeyPublic));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async getKey() {
    try {
      const result = await NativeModules.OTABridge.getKey(JSON.stringify(otaKeyRequest));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async registerBleEvents() {
    try {
      const result = await NativeModules.OTABridge.registerBleEvents(30);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async scan() {
    try {
      const result = await NativeModules.OTABridge.scan();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async stopScanning() {
    try {
      const result = await NativeModules.OTABridge.stopScanning();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async connect() {
    try {
      const result = await NativeModules.OTABridge.connect(true);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async disconnect() {
    try {
      const result = await NativeModules.OTABridge.disconnect();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async getVehicleData() {
    try {
      const result = await NativeModules.OTABridge.getVehicleData();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async getBluetoothState() {
    try {
      const result = await NativeModules.OTABridge.getBluetoothState();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async isOperationInProgress() {
    try {
      const result = await NativeModules.OTABridge.isOperationInProgress();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async setNfcEnabled() {
    try {
      const result = await NativeModules.OTABridge.setNfcEnabled(true);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async getLastNfcData() {
    try {
      const result = await NativeModules.OTABridge.getLastNfcData();
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async registerNfcEvent() {
    try {
      const result = await NativeModules.OTABridge.registerNfcEvent(12356);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async unregisterNfcEvent() {
    try {
      const result = await NativeModules.OTABridge.unregisterNfcEvent(12356);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async getVehicleDataHistory() {
    try {
      const result = await NativeModules.OTABridge
        .getVehicleDataHistory(JSON.stringify(otaKeyPublic));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async configureNetworkTimeouts() {
    try {
      const result = await NativeModules.OTABridge.configureNetworkTimeouts(3, 8);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async getRemainingTokenAmount() {
    try {
      const result = await NativeModules.OTABridge
        .getRemainingTokenAmount(JSON.stringify(otaKeyPublic));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async openSessionWithToken() {
    try {
      const result = await NativeModules.OTABridge.openSessionWithToken('VCpCTVlS3P535Y7ZpGjE0YGJ91dfgqRA');
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async cleanTokens() {
    try {
      const result = await NativeModules.OTABridge
        .cleanTokens(JSON.stringify(otaKeyPublic));
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async enablePhoneGpsPosition() {
    try {
      const result = await NativeModules.OTABridge.enablePhoneGpsPosition(true);
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  async configureEnvironment() {
    try {
      const result = await NativeModules.OTABridge.configureEnvironment('http://url.com.br');
      App.success(result);
    } catch (e) {
      App.errors(e);
    }
  }

  static success(result) {
    // console.log('SUCESSO:');
    // console.log(result);
  }

  static errors(e) {
    console.error(e);
  }

  /*
                      ****** UNCOMENT FOR LEARNING PURPOSES ******
    The easiest way to start creating a bridge, send a string get it back and print
    I left this one just for an example so you guys can use as a guide
  */
  async printAwesometext() {
    try {
      const something1 = await NativeModules.OTABridge.printSomething('Funcionalidades do OTAManager');
      this.setState(() => ({
        something: something1
      }));
    } catch (e) {
      App.errors(e);
    }
  }

  startService() {
    NativeModules.OTABridge.startService().then(() => {
      isAndroidServiceReady = true;
    });
  }

  render() {
    this.printAwesometext();
    const { something } = this.state;
    return (
      <ScrollView>
        <View style={styles.container}>
          <Text style={styles.title}>{something}</Text>
          <View style={styles.container}>
            <Text style={styles.subtitle}>Métodos iOS/Android</Text>
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="getAccessDeviceToken"
              onPress={this.getAccessDeviceToken}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="accessDeviceTokenWithForceRefresh"
              onPress={this.accessDeviceTokenWithForceRefresh}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="createKey"
              onPress={this.createKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="authenticated"
              onPress={this.authenticated}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="enableKey"
              onPress={this.enableKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="generateTokens"
              onPress={this.generateTokens}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="updateKey"
              onPress={this.updateKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="endKey"
              onPress={this.endKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="keysWithSuccess"
              onPress={this.keysWithSuccess}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="syncVehicleDataWithSuccess"
              onPress={this.syncVehicleDataWithSuccess}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unlockDoorsWithRequestVehicleData"
              onPress={this.unlockDoorsWithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="lockDoorsWithRequestVehicleData"
              onPress={this.lockDoorsWithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="vehicleDataWithSuccess"
              onPress={this.vehicleDataWithSuccess}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="lastVehicleSynthesisWithSuccess"
              onPress={this.lastVehicleSynthesisWithSuccess}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="enableEngineWithRequestVehicleData"
              onPress={this.enableEngineWithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="disableEngineWithRequestVehicleData"
              onPress={this.disableEngineWithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="openSessionWithToken"
              onPress={this.openSessionWithToken}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction1WithRequestVehicleData"
              onPress={this.unnamedAction1WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction2WithRequestVehicleData"
              onPress={this.unnamedAction2WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction3WithRequestVehicleData"
              onPress={this.unnamedAction3WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction4WithRequestVehicleData"
              onPress={this.unnamedAction4WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction5WithRequestVehicleData"
              onPress={this.unnamedAction5WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unnamedAction6WithRequestVehicleData"
              onPress={this.unnamedAction6WithRequestVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="localKeys"
              onPress={this.localKeys}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="localKey"
              onPress={this.localKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="currentKey"
              onPress={this.currentKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="connectedToVehicle"
              onPress={this.connectedToVehicle}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="isAuthenticated"
              onPress={this.isAuthenticated}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="switchToKeyWithID"
              onPress={this.switchToKeyWithID}
            />
          </View>
          <View style={styles.container}>
            <Text style={styles.subtitle}>Métodos iOS exclusivo</Text>
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="lastVehicleSynthesis"
              onPress={this.lastVehicleSynthesis}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="lastVehicleSynthesisForKeyWithId"
              onPress={this.lastVehicleSynthesisForKeyWithId}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="configureWithAppId"
              onPress={this.configureWithAppId}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="closeSession"
              onPress={this.closeSession}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="endKeyWithId"
              onPress={this.endKeyWithId}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="scanForVehicleWithCompletion"
              onPress={this.scanForVehicleWithCompletion}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="scanForVehicleWithTimeout"
              onPress={this.scanForVehicleWithTimeout}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="connectToVehicle"
              onPress={this.connectToVehicle}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="connectToVehicleWithCompletion"
              onPress={this.connectToVehicleWithCompletion}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="connectToVehicleWithTimeout"
              onPress={this.connectToVehicleWithTimeout}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="currentConnectionStatus"
              onPress={this.currentConnectionStatus}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="disconnectFromVehicle"
              onPress={this.disconnectFromVehicle}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="activateLogging"
              onPress={this.activateLogging}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="localKeyWithCompletionBlock"
              onPress={this.localKeyWithCompletionBlock}
            />
          </View>
          <View style={styles.container}>
            <Text style={styles.subtitle}>Métodos Android exclusivo</Text>
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="getKey"
              onPress={this.getKey}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="registerBleEvents"
              onPress={this.registerBleEvents}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="scan"
              onPress={this.scan}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="stopScanning"
              onPress={this.stopScanning}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="connect"
              onPress={this.connect}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="disconnect"
              onPress={this.disconnect}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="getVehicleData"
              onPress={this.getVehicleData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="getBluetoothState"
              onPress={this.getBluetoothState}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="isOperationInProgress"
              onPress={this.isOperationInProgress}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="setNfcEnabled"
              onPress={this.setNfcEnabled}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="getLastNfcData"
              onPress={this.getLastNfcData}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="registerNfcEvent"
              onPress={this.registerNfcEvent}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="unregisterNfcEvent"
              onPress={this.unregisterNfcEvent}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="getVehicleDataHistory"
              onPress={this.getVehicleDataHistory}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="configureNetworkTimeouts"
              onPress={this.configureNetworkTimeouts}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="getRemainingTokenAmount"
              onPress={this.getRemainingTokenAmount}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="cleanTokens"
              onPress={this.cleanTokens}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="enablePhoneGpsPosition"
              onPress={this.enablePhoneGpsPosition}
            />
          </View>
          <View style={styles.buttonbg}>
            <Button
              color="lightBlue"
              title="configureEnvironment"
              onPress={this.configureEnvironment}
            />
          </View>
        </View>
      </ScrollView>
    );
  }
}

const styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  buttonbg: {
    backgroundColor: 'darkblue',
    margin: 8,
    alignSelf: 'stretch',
  },
  title: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
    marginTop: 40,
  }
});

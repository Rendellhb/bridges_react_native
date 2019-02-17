/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 *
 * @format
 * @flow
 * @lint-ignore-every XPLATJSCOPYRIGHT1
 */

import React, { Component } from 'react';
import {
  Platform,
  StyleSheet,
  Text,
  View,
  NativeModules
} from 'react-native';

const instructions = Platform.select({
  ios: 'Press Cmd+R to reload,\n Cmd+D or shake for dev menu',
  android:
    'Double tap R on your keyboard to reload,\n' +
    'Shake or press menu button for dev menu',
});

export default class App extends Component {
  constructor(props) {
    super(props);
    this.state = { something: '' };
  }

  async printname() {
    try {
      const something1 = await NativeModules.OTABridge.printSomething('something');
      this.setState(() => ({
        something: something1
      }));
    } catch (e) {
      console.log(e);
    }
  }

  async openSessionWithToken() {
    try {
      this.result = await NativeModules.OTABridge.openSessionWithToken('VCpCTVlS3P535Y7ZpGjE0YGJ91dfgqRA');
      console.log(this.result);
    } catch (e) {
      console.log(`Erro do OTA ${e}`);
    }
  }

  async createKey() {
    this.otaKeyRequest = {
      otaId: '1',
      extId: '1',
      beginDate: '01-03-2019',
      endDate: '01-03-2019',
      vehicleId: '1',
      vehicleExtId: '1',
      enableNow: true,
      tokenAmount: '16',
      singleShotSecurity: true,
      security: 'token'
    };

    try {
      const result = await NativeModules.OTABridge.createKey(JSON.stringify(this.otaKeyRequest));
      console.log(`SUCESSO: ${result}`);
    } catch (e) {
      console.log(`ERRO: ${e}`);
    }
  }

  render() {
    this.printname();
    this.createKey();
    return (
      <View style={styles.container}>
        <Text style={styles.welcome}>Welcome to React Native!</Text>
        <Text style={styles.instructions}>To get started, edit App.js</Text>
        <Text style={styles.instructions}>{instructions}</Text>
        <Text style={styles.instructions}>{this.state.something}</Text>
      </View>
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
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

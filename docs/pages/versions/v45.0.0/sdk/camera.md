---
title: Camera
sourceCodeUrl: 'https://github.com/expo/expo/tree/sdk-45/packages/expo-camera'
packageName: 'expo-camera'
---

import APISection from '~/components/plugins/APISection';
import {APIInstallSection} from '~/components/plugins/InstallSection';
import PlatformsSection from '~/components/plugins/PlatformsSection';
import SnackInline from '~/components/plugins/SnackInline';

**`expo-camera`** provides a React component that renders a preview for the device's front or back camera. The camera's parameters like zoom, auto focus, white balance and flash mode are adjustable. With the use of `Camera`, one can also take photos and record videos that are then saved to the app's cache. Morever, the component is also capable of detecting faces and bar codes appearing in the preview. Run the [example](#usage) on your device to see all these features working together!

<PlatformsSection android ios web />

> 💡 Android devices can use one of two available Camera APIs: you can opt-in to using [`Camera2`](https://developer.android.com/reference/android/hardware/camera2/package-summary) with the `useCamera2Api` prop.

## Installation

<APIInstallSection />

## Configuration

In managed apps, `Camera` requires `Permissions.CAMERA`. Video recording requires `Permissions.AUDIO_RECORDING`.

## Usage

> ⚠️ Only one Camera preview can be active at any given time. If you have multiple screens in your app, you should unmount `Camera` components whenever a screen is unfocused.

<SnackInline label='Basic Camera usage' dependencies={['expo-camera']}>

```jsx
import React, { useState, useEffect } from 'react';
import { StyleSheet, Text, View, TouchableOpacity } from 'react-native';
import { Camera, CameraType } from 'expo-camera';

export default function App() {
  const [hasPermission, setHasPermission] = useState(null);
  const [type, setType] = useState(CameraType.back);

  useEffect(() => {
    (async () => {
      const { status } = await Camera.requestCameraPermissionsAsync();
      setHasPermission(status === 'granted');
    })();
  }, []);

  if (hasPermission === null) {
    return <View />;
  }
  if (hasPermission === false) {
    return <Text>No access to camera</Text>;
  }
  return (
    <View style={styles.container}>
      <Camera style={styles.camera} type={type}>
        <View style={styles.buttonContainer}>
          <TouchableOpacity
            style={styles.button}
            onPress={() => {
              setType(type === CameraType.back ? CameraType.front : CameraType.back);
            }}>
            <Text style={styles.text}> Flip </Text>
          </TouchableOpacity>
        </View>
      </Camera>
    </View>
  );
}

/* @hide const styles = StyleSheet.create({ ... }); */
const styles = StyleSheet.create({
  container: {
    flex: 1,
  },
  camera: {
    flex: 1,
  },
  buttonContainer: {
    flex: 1,
    backgroundColor: 'transparent',
    flexDirection: 'row',
    margin: 20,
  },
  button: {
    flex: 0.1,
    alignSelf: 'flex-end',
    alignItems: 'center',
  },
  text: {
    fontSize: 18,
    color: 'white',
  },
});
/* @end */
```

</SnackInline>

## Web Support

Luckily most browsers support at least some form of web camera functionality, you can check out the [web camera browser support here](https://caniuse.com/#feat=stream). Image URIs are always returned as base64 strings because local file system paths are not available in the browser.

### Chrome `iframe` usage

When using **Chrome versions 64+**, if you try to use a web camera in a cross-origin iframe nothing will render. To add support for cameras in your iframe simply add the attribute `allow="microphone; camera;"` to the iframe element:

```html
<iframe src="..." allow="microphone; camera;">
  <!-- <Camera /> -->
</iframe>
```

## API

```js
import { Camera } from 'expo-camera';
```

<APISection packageName="expo-camera" apiName="Camera" />

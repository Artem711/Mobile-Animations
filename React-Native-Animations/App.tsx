// # PLUGINS IMPORTS //
import React from 'react'
import { NavigationContainer } from '@react-navigation/native'
import { SafeAreaProvider } from 'react-native-safe-area-context'

// # COMPONENTS IMPORTS //
import BottomSheetPreview from '~/screens/Scenes/BottomSheet/BottomSheetPreview'
import { RootStackNavigator } from '~/navigators/index'

// # EXTRA IMPORTS //

/////////////////////////////////////////////////////////////////////////////

export default function App() {
  return (
    <NavigationContainer>
      <SafeAreaProvider>
        <BottomSheetPreview />
        {/* <RootStackNavigator /> */}
      </SafeAreaProvider>
    </NavigationContainer>
  )
}

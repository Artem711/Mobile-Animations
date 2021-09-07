// PLUGINS IMPORTS //
import React from "react"
import { View, StyleSheet } from "react-native"
import { SafeAreaView } from "react-native-safe-area-context"

// COMPONENTS IMPORTS //
import Slider1 from "./slider1"
import Slider2 from "./slider2"

// EXTRA IMPORTS //

/////////////////////////////////////////////////////////////////////////////

export default function Sliders() {
  return (
    <SafeAreaView style={styles.wrapper}>
      <Slider1 />
      <View style={styles.divider} />
      <Slider2 />
    </SafeAreaView>
  )
}

const styles = StyleSheet.create({
  wrapper: {
    flex: 1,
    alignItems: "center",
    justifyContent: "center",
  },

  divider: {
    marginTop: 60,
  },
})

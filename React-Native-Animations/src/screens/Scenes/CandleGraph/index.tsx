// # PLUGINS IMPORTS //
import React from "react"
import { StyleSheet, View } from "react-native"
import { SafeAreaView } from "react-native-safe-area-context"

// # COMPONENTS IMPORTS //
import BodyChart from "./BodyChart"

// # EXTRA IMPORTS //
import { candles } from "./constants"

/////////////////////////////////////////////////////////////////////////////

export default function CandleGraph() {
  return (
    <SafeAreaView style={styles.wrapper}>
      <BodyChart data={candles} />
    </SafeAreaView>
  )
}

const styles = StyleSheet.create({
  wrapper: {
    backgroundColor: "black",
    flex: 1,
  },
})

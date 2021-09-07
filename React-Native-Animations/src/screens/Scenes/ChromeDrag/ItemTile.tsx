// # PLUGINS IMPORTS //
import React from "react"
import { StyleSheet, View } from "react-native"

// # COMPONENTS IMPORTS //

// # EXTRA IMPORTS //
import { MARGIN, SIZE } from "./config"

/////////////////////////////////////////////////////////////////////////////

export default function Tile(props: { id: string }) {
  return (
    <View style={styles.wrapper} pointerEvents="none">
      <View style={styles.container} />
    </View>
  )
}

const styles = StyleSheet.create({
  wrapper: {
    width: SIZE,
    height: SIZE,
  },

  container: {
    flex: 1,
    backgroundColor: "white",
    margin: MARGIN * 2,
    borderRadius: MARGIN,
  },
})

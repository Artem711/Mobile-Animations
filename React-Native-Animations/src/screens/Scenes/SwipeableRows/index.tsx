// # PLUGINS IMPORTS //
import React from "react"
import { View, StyleSheet } from "react-native"
import { FlatList } from "react-native-gesture-handler"

// # COMPONENTS IMPORTS //
import Row from "./Row"

// # EXTRA IMPORTS //
import { DATA } from "./data"

/////////////////////////////////////////////////////////////////////////////

export default function SwipeableRows() {
  return (
    <FlatList
      data={DATA}
      ItemSeparatorComponent={() => <View style={styles.separator} />}
      renderItem={({ item, index }) => (
        <Row key={index} item={item} onPress={() => {}} />
      )}
    />
  )
}

const styles = StyleSheet.create({
  separator: {
    backgroundColor: "rgb(200, 199, 204)",
    height: StyleSheet.hairlineWidth,
  },
})

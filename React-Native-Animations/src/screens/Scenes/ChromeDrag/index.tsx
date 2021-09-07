// # PLUGINS IMPORTS //
import React from "react"
import { StyleSheet } from "react-native"
import { SafeAreaView } from "react-native-safe-area-context"

// # COMPONENTS IMPORTS //
import ItemTile from "./ItemTile"
import SortableList from "./SortableList"

// # EXTRA IMPORTS //
import { MARGIN } from "./config"
import { tiles } from "./data"

/////////////////////////////////////////////////////////////////////////////

export default function ChromeDrag() {
  return (
    <SafeAreaView style={styles.wrapper}>
      <SortableList
        onDragEnd={(positions) =>
          console.log(JSON.stringify(positions, null, 2))
        }
      >
        {[...tiles, ...tiles].map((tile, index) => (
          <ItemTile key={tile.id + "-" + index} id={tile.id + "-" + index} />
        ))}
      </SortableList>
    </SafeAreaView>
  )
}

const styles = StyleSheet.create({
  wrapper: { flex: 1, backgroundColor: "black", paddingHorizontal: MARGIN },
})

// # PLUGINS IMPORTS //
import React from "react"
import { Text, StyleSheet } from "react-native"
import { RectButton } from "react-native-gesture-handler"

// # COMPONENTS IMPORTS //
import SwipeWrapper from "./SwipeWrapper"

// # EXTRA IMPORTS //

/////////////////////////////////////////////////////////////////////////////

interface IProps {
  item: {
    from: string
    message?: string
    when: string
  }
  onPress: () => void
}

export default function Row(props: IProps) {
  return (
    <SwipeWrapper>
      <RectButton style={styles.button} onPress={props.onPress}>
        <Text style={styles.fromText}>{props.item.from}</Text>
        {props.item.message && (
          <Text numberOfLines={2} style={styles.messageText}>
            {props.item.message}
          </Text>
        )}
        <Text style={styles.dateText}>
          {props.item.when} {"❭"}
        </Text>
      </RectButton>
    </SwipeWrapper>
  )
}

const styles = StyleSheet.create({
  button: {
    flex: 1,
    height: 80,
    paddingVertical: 10,
    paddingHorizontal: 20,
    justifyContent: "space-between",
    flexDirection: "column",
    backgroundColor: "white",
  },

  fromText: {
    fontWeight: "bold",
    backgroundColor: "transparent",
  },

  messageText: {
    color: "#999",
    backgroundColor: "transparent",
  },

  dateText: {
    backgroundColor: "transparent",
    position: "absolute",
    right: 20,
    top: 10,
    color: "#999",
    fontWeight: "bold",
  },
})

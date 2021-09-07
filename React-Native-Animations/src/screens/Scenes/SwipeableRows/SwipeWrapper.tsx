// PLUGINS IMPORTS //
import React, { ReactNode, useRef } from "react"
import { Animated, StyleSheet, I18nManager } from "react-native"
import { RectButton } from "react-native-gesture-handler"
import Swipeable from "react-native-gesture-handler/Swipeable"

// COMPONENTS IMPORTS //

// EXTRA IMPORTS //
import { Ionicons } from "@expo/vector-icons"

/////////////////////////////////////////////////////////////////////////////

const AnimatedIcon = Animated.createAnimatedComponent(Ionicons)
export default function SwipeWrapper(props: { children: ReactNode }) {
  const rowRef = useRef<Swipeable>(null)

  const closeRow = () => {
    rowRef.current && rowRef.current.close()
  }

  const renderLeftActions = () => {
    return (
      <RectButton style={styles.leftAction} onPress={closeRow}>
        <AnimatedIcon
          name="archive"
          size={30}
          color="#fff"
          style={styles.icon}
        />
      </RectButton>
    )
  }
  const renderRightActions = () => {
    return (
      <RectButton style={styles.rightAction} onPress={closeRow}>
        <AnimatedIcon
          name="ios-trash-bin"
          size={30}
          color="#fff"
          style={styles.icon}
        />
      </RectButton>
    )
  }

  return (
    <Swipeable
      ref={rowRef}
      friction={2}
      leftThreshold={80}
      rightThreshold={41}
      renderLeftActions={renderLeftActions}
      renderRightActions={renderRightActions}
    >
      {props.children}
    </Swipeable>
  )
}

const styles = StyleSheet.create({
  icon: {
    width: 30,
    marginHorizontal: 10,
  },

  rightAction: {
    alignItems: "center",
    flexDirection: I18nManager.isRTL ? "row-reverse" : "row",
    backgroundColor: "#dd2c00",
    flex: 1,
    justifyContent: "flex-end",
  },

  leftAction: {
    flex: 1,
    backgroundColor: "#388e3c",
    justifyContent: "flex-end",
    alignItems: "center",
    flexDirection: I18nManager.isRTL ? "row" : "row-reverse",
  },
})

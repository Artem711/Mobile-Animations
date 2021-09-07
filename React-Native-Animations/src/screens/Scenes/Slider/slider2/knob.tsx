// PLUGINS IMPORTS //
import React from "react"
import { StyleSheet } from "react-native"
import Animated, { useAnimatedStyle } from "react-native-reanimated"

// COMPONENTS IMPORTS //

// EXTRA IMPORTS //

/////////////////////////////////////////////////////////////////////////////

export default function Knob(props: {
  isSliding: Animated.SharedValue<boolean>
  rotateStyle: Animated.AnimateStyle<{ transform: [{ rotate: string }] }>
}) {
  const knobUpStyle = useAnimatedStyle(() => ({
    opacity: props.isSliding.value ? 1 : 0,
  }))

  const knobDownStyle = useAnimatedStyle(() => ({
    opacity: props.isSliding.value ? 0 : 1,
  }))

  return (
    <Animated.View style={[styles.wrapper, props.rotateStyle]}>
      <Animated.Image
        source={require("../assets/down.png")}
        style={[styles.image, knobUpStyle]}
      />
      <Animated.Image
        source={require("../assets/up.png")}
        style={[styles.image, knobDownStyle]}
      />
    </Animated.View>
  )
}

const styles = StyleSheet.create({
  wrapper: {
    width: 50,
    height: 50,
  },

  image: {
    ...StyleSheet.absoluteFillObject,
    width: undefined,
    height: undefined,
  },
})

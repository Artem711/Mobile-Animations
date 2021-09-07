// PLUGINS IMPORTS //
import React from "react"
import { View, Button, StyleSheet, Alert } from "react-native"
import { PanGestureHandler } from "react-native-gesture-handler"
import Animated, {
  Easing,
  Extrapolate,
  interpolate,
  useAnimatedStyle,
  withTiming,
} from "react-native-reanimated"
import { useSlider } from "../hooks/useSlider"

// COMPONENTS IMPORTS //
import AnimatedText from "../shared/AnimatedText"
import Knob from "./knob"

// EXTRA IMPORTS //
import { shadowStyle } from "../shared/style"

/////////////////////////////////////////////////////////////////////////////

const SLIDER_WIDTH = 300
const KNOB_SIZE = 30
const SLIDER_RANGE = SLIDER_WIDTH - KNOB_SIZE
export default function Slider2() {
  const {
    onGestureEvent,
    values: { translateX, isSliding, stepText },
    styles: { progressStyle, scrollTranslationStyle },
  } = useSlider(
    SLIDER_WIDTH,
    KNOB_SIZE,
    () => Alert.alert(stepText.value, translateX.value.toString()),
    200
  )

  const rotateStyle = useAnimatedStyle(() => {
    const rotate = interpolate(
      translateX.value,
      [0, SLIDER_RANGE], // between beginning and end of the slider
      [0, 4 * 360], // penguin make 4 full spins
      Extrapolate.CLAMP
    )

    return {
      transform: [{ rotate: `${rotate}deg` }],
    }
  })

  const backgroundStyle = useAnimatedStyle(() => {
    const R = Math.round(
      interpolate(
        translateX.value,
        [0, SLIDER_RANGE],
        [123, 3],
        Extrapolate.CLAMP
      )
    )

    const G = Math.round(
      interpolate(
        translateX.value,
        [0, SLIDER_RANGE],
        [212, 169],
        Extrapolate.CLAMP
      )
    )
    const B = Math.round(
      interpolate(
        translateX.value,
        [0, SLIDER_RANGE],
        [250, 244],

        Extrapolate.CLAMP
      )
    )

    const backgroundColor = `rgb(${R}, ${G}, ${B})`
    return {
      backgroundColor,
    }
  })

  function slideToStart() {
    isSliding.value = true
    translateX.value = withTiming(
      0,
      {
        duration: 3000,
        easing: Easing.bounce,
      },
      () => {
        isSliding.value = false
      }
    )
  }

  function slideToEnd() {
    isSliding.value = true
    translateX.value = withTiming(
      SLIDER_RANGE,
      {
        duration: 1000,
        easing: Easing.linear,
      },
      () => {
        isSliding.value = false
      }
    )
  }

  return (
    <>
      <View style={styles.slider}>
        <Animated.View
          style={[styles.progress, progressStyle, backgroundStyle]}
        />
        <PanGestureHandler onGestureEvent={onGestureEvent}>
          <Animated.View style={[styles.knob, scrollTranslationStyle]}>
            <Knob isSliding={isSliding} rotateStyle={rotateStyle} />
          </Animated.View>
        </PanGestureHandler>
      </View>

      <View style={styles.footer}>
        <AnimatedText text={stepText} />
        <Button title={"Slide to beginning"} onPress={slideToStart} />
        <Button title={"Slide to end"} onPress={slideToEnd} />
      </View>
    </>
  )
}

const styles = StyleSheet.create({
  slider: {
    height: 20,
    width: SLIDER_WIDTH,
    backgroundColor: "#ddd",
    justifyContent: "center",
    borderRadius: 25,
    ...shadowStyle.shadow,
  },

  progress: {
    ...StyleSheet.absoluteFillObject,
    backgroundColor: "#3f51b5",
    borderRadius: KNOB_SIZE / 2,
  },

  knob: {
    height: KNOB_SIZE,
    width: KNOB_SIZE,
    justifyContent: "center",
    alignItems: "center",
  },

  footer: { marginTop: 40, alignItems: "center" },
})

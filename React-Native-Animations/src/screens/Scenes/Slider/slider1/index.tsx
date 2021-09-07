// PLUGINS IMPORTS //
import React from "react"
import { View, StyleSheet, Alert } from "react-native"
import {
  PanGestureHandler,
  PanGestureHandlerGestureEvent,
} from "react-native-gesture-handler"
import Animated, {
  runOnJS,
  useAnimatedGestureHandler,
  useAnimatedStyle,
  useDerivedValue,
  useSharedValue,
} from "react-native-reanimated"
import { clamp } from "react-native-redash"

// COMPONENTS IMPORTS //
import AnimatedText from "../shared/AnimatedText"

// EXTRA IMPORTS //
import { shadowStyle } from "../shared/style"

/////////////////////////////////////////////////////////////////////////////

const MAX_RANGE = 20
const SLIDER_WIDTH = 300
const KNOB_SIZE = 53
export default function Slider1() {
  const translateX = useSharedValue(0)
  const isSliding = useSharedValue(false)

  function onDragSuccess() {
    Alert.alert("Dragged successfully")
  }

  const onGestureEvent = useAnimatedGestureHandler<
    PanGestureHandlerGestureEvent,
    { offsetX: number }
  >({
    onStart: (_, ctx) => {
      ctx.offsetX = translateX.value
    },
    onActive: (event, ctx) => {
      isSliding.value = true
      translateX.value = clamp(
        event.translationX + ctx.offsetX,
        0,
        SLIDER_WIDTH - KNOB_SIZE
      )
    },
    onEnd: () => {
      isSliding.value = false

      if (translateX.value > SLIDER_WIDTH - KNOB_SIZE - 3) {
        runOnJS(onDragSuccess)()
      }
    },
  })

  const progressStyle = useAnimatedStyle(() => ({
    width: translateX.value + KNOB_SIZE,
  }))

  const knobStyle = useAnimatedStyle(() => ({
    transform: [{ translateX: translateX.value }],
  }))

  const stepText = useDerivedValue(() => {
    const range = SLIDER_WIDTH - KNOB_SIZE
    const oneStep = range / MAX_RANGE
    const step = Math.ceil(translateX.value / oneStep)
    return step.toString()
  })

  return (
    <View style={styles.wrapper}>
      <Animated.View style={[styles.progress, progressStyle]} />
      <PanGestureHandler onGestureEvent={onGestureEvent}>
        <Animated.View style={[styles.knob, knobStyle]}>
          <AnimatedText text={stepText} />
        </Animated.View>
      </PanGestureHandler>
    </View>
  )
}

const styles = StyleSheet.create({
  wrapper: {
    height: KNOB_SIZE,
    width: SLIDER_WIDTH,
    borderRadius: KNOB_SIZE / 2,
    backgroundColor: "#ddd",
    justifyContent: "center",
    ...shadowStyle.shadow,
  },

  progress: {
    ...StyleSheet.absoluteFillObject,
    width: KNOB_SIZE,
    backgroundColor: "#3f51b5",
    borderRadius: KNOB_SIZE / 2,
  },

  knob: {
    height: KNOB_SIZE,
    width: KNOB_SIZE,
    borderRadius: KNOB_SIZE / 2,
    backgroundColor: "#757de8",
    justifyContent: "center",
    alignItems: "center",
  },
})

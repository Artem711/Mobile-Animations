// # PLUGINS IMPORTS //
import React, { useEffect } from 'react'
import { View, Text, useWindowDimensions, StyleSheet } from 'react-native'
import {
  PanGestureHandler,
  PanGestureHandlerGestureEvent,
} from 'react-native-gesture-handler'
import Animated, {
  runOnJS,
  useAnimatedGestureHandler,
  useAnimatedStyle,
  useSharedValue,
  withSpring,
} from 'react-native-reanimated'
import { animationConfig } from '../ChromeDrag/config'

// # COMPONENTS IMPORTS //

// # EXTRA IMPORTS //

/////////////////////////////////////////////////////////////////////////////

interface IProps {
  isOpened: boolean
  setIsOpened: (isOpened: boolean) => void
}

export default function BottomSheet(props: IProps) {
  const dimensions = useWindowDimensions()
  const top = useSharedValue(dimensions.height)

  useEffect(() => {
    if (props.isOpened) {
      top.value = withSpring(dimensions.height / 2, SPRING_CONFIG)
    }
  }, [props.isOpened])

  const gestureHandler = useAnimatedGestureHandler<
    PanGestureHandlerGestureEvent,
    { startTop: number }
  >({
    onStart: (_, context) => {
      context.startTop = top.value
    },
    onActive: (event, context) => {
      if (top.value > dimensions.height / 4) {
        top.value = event.translationY + context.startTop
      }
    },
    onEnd: () => {
      // Dismissing snap point
      if (top.value > dimensions.height / 2 + 200) {
        top.value = dimensions.height
        runOnJS(props.setIsOpened)(false)
      } else {
        top.value = dimensions.height / 2
      }
    },
  })

  const style = useAnimatedStyle(() => ({
    top: withSpring(top.value, SPRING_CONFIG),
  }))

  return (
    <PanGestureHandler onGestureEvent={gestureHandler}>
      <Animated.View style={[styles.wrapper, style]}>
        <Text>Some text</Text>
      </Animated.View>
    </PanGestureHandler>
  )
}

const BORDER_TOP_RADIUS = 20
const styles = StyleSheet.create({
  wrapper: {
    position: 'absolute',
    left: 0,
    right: 0,
    bottom: 0,
    backgroundColor: 'white',
    borderTopLeftRadius: BORDER_TOP_RADIUS,
    borderTopRightRadius: BORDER_TOP_RADIUS,
    shadowColor: '#000',
    shadowOffset: {
      width: 0,
      height: 2,
    },
    shadowOpacity: 1.25,
    shadowRadius: 3.84,
    elevation: 5,
    padding: 20,
    justifyContent: 'center',
    alignItems: 'center',
  },
})

const SPRING_CONFIG = {
  damping: 80,
  overshootClamping: true,
  restDisplacementThreshold: 0.1,
  restSpeedThreshold: 0.1,
  stiffness: 500,
}

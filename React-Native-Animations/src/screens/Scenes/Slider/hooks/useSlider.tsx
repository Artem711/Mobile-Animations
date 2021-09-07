import { PanGestureHandlerGestureEvent } from "react-native-gesture-handler"
import {
  useSharedValue,
  useAnimatedGestureHandler,
  useAnimatedStyle,
  useDerivedValue,
  runOnJS,
} from "react-native-reanimated"
import { clamp } from "react-native-redash"

export const useSlider = (
  sliderWidth: number,
  knobSize: number,
  onDraggedSuccess: () => void,
  maxValue = 10,
  initialValue = 0
) => {
  const SLIDER_RANGE = sliderWidth - knobSize
  const STEP = SLIDER_RANGE / maxValue

  const translateX = useSharedValue(STEP * initialValue)
  const isSliding = useSharedValue(false)

  const onGestureEvent = useAnimatedGestureHandler<
    PanGestureHandlerGestureEvent,
    { offsetX: number }
  >({
    onStart: (_, ctx) => {
      ctx.offsetX = translateX.value
    },
    onActive: ({ translationX }, ctx) => {
      isSliding.value = true
      translateX.value = clamp(translationX + ctx.offsetX, 0, SLIDER_RANGE)
    },
    onEnd: () => {
      isSliding.value = false

      if (translateX.value > SLIDER_RANGE - 3) {
        runOnJS(onDraggedSuccess)()
      }
    },
  })

  const progressStyle = useAnimatedStyle(() => ({
    width: translateX.value + knobSize,
  }))

  const scrollTranslationStyle = useAnimatedStyle(() => ({
    transform: [{ translateX: translateX.value }],
  }))

  const stepText = useDerivedValue(() => {
    const step = Math.ceil(translateX.value / STEP)
    return step.toString()
  }, [translateX])

  return {
    onGestureEvent,
    values: {
      isSliding,
      translateX,
      stepText,
    },
    styles: {
      progressStyle,
      scrollTranslationStyle,
    },
  }
}

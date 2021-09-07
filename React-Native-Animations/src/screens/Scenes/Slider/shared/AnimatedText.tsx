import React from "react"
import Animated, { useAnimatedProps } from "react-native-reanimated"
import { TextInput } from "react-native-gesture-handler"

interface IProps {
  text: Animated.SharedValue<string | number>
}

const AnimatedTextInput = Animated.createAnimatedComponent(TextInput)
export default function AnimatedText({ text }: IProps) {
  const animatedProps = useAnimatedProps(() => ({
    text: text.value,
  }))

  return (
    <AnimatedTextInput
      underlineColorAndroid={"transparent"}
      editable={false}
      value={text.value.toString()}
      animatedProps={animatedProps}
    />
  )
}

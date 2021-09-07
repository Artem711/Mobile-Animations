// # PLUGINS IMPORTS //
import React from "react"
import { Text, TextInput, View, StyleSheet } from "react-native"
import Animated, {
  interpolate,
  useAnimatedScrollHandler,
  useAnimatedStyle,
  useDerivedValue,
  useSharedValue,
} from "react-native-reanimated"
import { SafeAreaView } from "react-native-safe-area-context"

// # COMPONENTS IMPORTS //

// # EXTRA IMPORTS //

/////////////////////////////////////////////////////////////////////////////

export default function AppleHeader() {
  const scrollY = useSharedValue(0)

  const scrollHandler = useAnimatedScrollHandler({
    onBeginDrag: (e) => {},
    onScroll: (event: { contentOffset: { y: number } }) => {
      scrollY.value = event.contentOffset.y
    },
    onEndDrag: (e) => {},
  })

  const originalheight = 100
  const additionalheight = 20

  const inputHeight = useDerivedValue(() => {
    return interpolate(
      scrollY.value,
      [50, 100],
      [0, additionalheight],
      Animated.Extrapolate.CLAMP
    )
  })

  const inputWrapperStyle = useAnimatedStyle(() => ({
    height: inputHeight.value,
  }))

  return (
    <SafeAreaView style={{ flex: 1 }}>
      <Animated.View style={{ backgroundColor: "tomato" }}>
        <Text>Песни</Text>

        <Animated.View style={[inputWrapperStyle]}>
          <TextInput
            style={{ backgroundColor: "grey", flex: 1 }}
            placeholder={"Text"}
          />
        </Animated.View>
      </Animated.View>
      <Animated.ScrollView
        style={[styles.scroll_wrapper]}
        contentContainerStyle={[styles.wrappers]}
        onScroll={scrollHandler}
        scrollEventThrottle={16}
      >
        {[...Array(20).fill("2222")].map((item, index) => (
          <View
            key={index}
            style={{
              height: 90,
              width: 20,
              marginTop: 20,
            }}
          >
            <Text>{item}</Text>
          </View>
        ))}
      </Animated.ScrollView>
    </SafeAreaView>
  )
}

const styles = StyleSheet.create({
  scroll_wrapper: {
    flex: 1,
  },

  wrappers: {
    marginHorizontal: 20,
  },
})

// # PLUGINS IMPORTS //
import React, { ReactElement } from "react"
import Animated, {
  useAnimatedRef,
  useAnimatedScrollHandler,
  useSharedValue,
} from "react-native-reanimated"

// # COMPONENTS IMPORTS //
import Item from "./Item"
import { COL, Positions, SIZE } from "./config"

// # EXTRA IMPORTS //

/////////////////////////////////////////////////////////////////////////////

interface ListProps {
  children: ReactElement<{ id: string }>[]
  onDragEnd: (diff: Positions) => void
}

export default function List({ children, onDragEnd }: ListProps) {
  const scrollY = useSharedValue(0)
  const scrollView = useAnimatedRef<Animated.ScrollView>()
  const positions = useSharedValue<Positions>(
    Object.assign(
      {},
      ...children.map((child, index) => ({ [child.props.id]: index }))
    )
  )
  const onScroll = useAnimatedScrollHandler({
    onScroll: ({ contentOffset: { y } }) => {
      scrollY.value = y
    },
  })

  return (
    <Animated.ScrollView
      onScroll={onScroll}
      ref={scrollView}
      contentContainerStyle={{
        height: Math.ceil(children.length / COL) * SIZE,
      }}
      showsVerticalScrollIndicator={false}
      scrollEventThrottle={16}
    >
      {children.map((child) => {
        return (
          <Item
            key={child.props.id}
            positions={positions}
            id={child.props.id}
            onDragEnd={onDragEnd}
            scrollView={scrollView}
            scrollY={scrollY}
          >
            {child}
          </Item>
        )
      })}
    </Animated.ScrollView>
  )
}

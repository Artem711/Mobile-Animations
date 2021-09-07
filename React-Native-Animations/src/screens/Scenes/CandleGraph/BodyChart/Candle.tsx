// # PLUGINS IMPORTS //
import React from "react"
import { View, Text } from "react-native"
import { Line, Rect } from "react-native-svg"
import { scaleY, STEP } from "../constants"

// # COMPONENTS IMPORTS //

// # EXTRA IMPORTS //
import { IDataItem } from "../typings"

/////////////////////////////////////////////////////////////////////////////

interface IProps {
  item: IDataItem
  index: number
}

export default function Candle(props: IProps) {
  const { open, close, high, low } = props.item
  const fill = close > open ? "#4AFA9A" : "#E33F64"
  const x = props.index * STEP
  const max = Math.max(open, close)
  const min = Math.min(open, close)

  //   scaleY()
  return (
    <>
      <Line x1={1} x2={22} y1={1} y2={200} stroke={fill} strokeWidth={22} />
    </>
  )
}

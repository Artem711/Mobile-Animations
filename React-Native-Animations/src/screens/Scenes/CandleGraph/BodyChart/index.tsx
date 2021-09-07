// # PLUGINS IMPORTS //
import React from "react"
import { View, Text } from "react-native"
import { IDataItem } from "../typings"
import Svg from "react-native-svg"

// # COMPONENTS IMPORTS //
import Candle from "./Candle"

// # EXTRA IMPORTS //
import { screenWidth } from "../constants"

/////////////////////////////////////////////////////////////////////////////

interface IProps {
  data: Array<IDataItem>
}

export default function BodyChart(props: IProps) {
  return (
    <Svg width={screenWidth} height={screenWidth}>
      {props.data.map((item, index) => (
        <Candle item={item} index={index} />
      ))}
    </Svg>
  )
}

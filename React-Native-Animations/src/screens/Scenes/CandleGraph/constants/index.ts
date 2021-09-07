import { Dimensions } from "react-native"
import data from "../data/index.json"
import { IDataItem } from "../typings"

export const candles: Array<IDataItem> = data.slice(0, 20)
export const { width: screenWidth } = Dimensions.get("screen")

export const STEP = screenWidth / candles.length

const getDomain = (rows: Array<IDataItem>): [number, number] => {
  //   "worklet"
  const values = rows.map(({ high, low }) => [high, low]).flat()
  return [Math.min(...values), Math.max(...values)]
}
export const DOMAIN = getDomain(candles)
export const scaleY = () => {}
export const scaleBody = () => {}

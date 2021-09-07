import { ComponentClass, FunctionComponent } from "react"
import { IRootStackParams } from "~/navigators/typings"
import MenuScreen from "~/screens/MenuScreen"
import SwipeableRows from "~/screens/Scenes/SwipeableRows"
import CandleGraph from "~/screens/Scenes/CandleGraph"
import ChromeDrag from "~/screens/Scenes/ChromeDrag"
import Sliders from "~/screens/Scenes/Slider"
import AppleHeader from "~/screens/Scenes/AppleHeader"

export const screens: Array<{
  name: keyof IRootStackParams
  component: ComponentClass | FunctionComponent
}> = [
  {
    name: "MenuScreen",
    component: MenuScreen,
  },
  {
    name: "SwipeableRows",
    component: SwipeableRows,
  },
  {
    name: "ChromeDrag",
    component: ChromeDrag,
  },
  {
    name: "Sliders",
    component: Sliders,
  },
  {
    name: "CandleGraph",
    component: CandleGraph,
  },
  {
    name: "AppleHeader",
    component: AppleHeader,
  },
]

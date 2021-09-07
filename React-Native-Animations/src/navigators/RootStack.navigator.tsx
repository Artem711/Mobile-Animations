// # PLUGINS IMPORTS //
import React from "react"
import { createStackNavigator } from "@react-navigation/stack"

// # COMPONENTS IMPORTS //
import { screens } from "~/shared/constants"

// # EXTRA IMPORTS //
import { IRootStackParams } from "./typings"

/////////////////////////////////////////////////////////////////////////////

const Stack = createStackNavigator<IRootStackParams>()
export default function RootStackNavigator() {
  return (
    <Stack.Navigator>
      {screens.map((item) => (
        <Stack.Screen name={item.name} component={item.component} />
      ))}
    </Stack.Navigator>
  )
}

// PLUGINS IMPORTS //
import { useNavigation } from "@react-navigation/native"
import { StackNavigationProp } from "@react-navigation/stack"
import React from "react"
import { View } from "react-native"
import { ScrollView } from "react-native-gesture-handler"

// COMPONENTS IMPORTS //
import Row from "../Scenes/SwipeableRows/Row"

// EXTRA IMPORTS //
import { IRootStackParams } from "~/navigators/typings"
import { screens } from "~/shared/constants"

/////////////////////////////////////////////////////////////////////////////

export default function MenuScreen() {
  const navigation = useNavigation<StackNavigationProp<IRootStackParams>>()

  return (
    <ScrollView>
      {screens
        .filter((item) => item.name !== "MenuScreen")
        .map((item) => (
          <Row
            key={item.name}
            item={{ from: item.name, when: "Open screen" }}
            onPress={() => navigation.navigate(item.name)}
          />
        ))}
    </ScrollView>
  )
}

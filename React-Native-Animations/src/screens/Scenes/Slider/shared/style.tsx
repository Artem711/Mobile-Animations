import { StyleSheet } from "react-native"

export const shadowStyle = StyleSheet.create({
  shadow: {
    shadowColor: "#000",
    shadowOffset: {
      height: 20,
      width: 0,
    },

    shadowOpacity: 0.25,
    shadowRadius: 10,
    elevation: 5,
  },
})

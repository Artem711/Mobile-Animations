// # PLUGINS IMPORTS //
import React, { useState } from 'react'
import { View, Text, Button, StyleSheet } from 'react-native'

// # COMPONENTS IMPORTS //
import BottomSheet from './index'

// # EXTRA IMPORTS //

/////////////////////////////////////////////////////////////////////////////

export default function BottomSheetPreview() {
  const [opened, setOpened] = useState<boolean>(false)

  return (
    <View style={styles.wrapper}>
      <Button title={'Open bottom sheet'} onPress={() => setOpened(true)} />
      <BottomSheet isOpened={opened} setIsOpened={setOpened} />
    </View>
  )
}

const styles = StyleSheet.create({
  wrapper: {
    flex: 1,
    justifyContent: 'center',
  },
})

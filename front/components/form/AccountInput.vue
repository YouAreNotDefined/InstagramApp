<template>
  <v-row justify="center" align="center">
    <v-col cols="4" class="text-right">
      <div class="font-weight-bold">{{ label }}</div>
    </v-col>
    <v-col cols="8">
      <v-text-field
        v-model="changeValue"
        outlined
        clearable
        dense
        hide-details="auto"
      ></v-text-field>
    </v-col>
  </v-row>
</template>

<script>
export default {
  props: {
    label: {
      type: String,
      default: '',
    },
    value: {
      type: String,
      default: '',
    },
  },
  computed: {
    changeValue: {
      get () {
        return this.value
      },
      set (value) {
        this.$emit('input', value)
      }
    }
  },
}
</script>

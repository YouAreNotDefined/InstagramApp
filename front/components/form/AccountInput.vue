<template>
  <v-row justify="center">
    <v-col v-if="placeHolder === null" cols="4" class="text-right">
      <div class="font-weight-bold">{{ label }}</div>
    </v-col>
    <v-col :cols="inputCols">
      <v-text-field
        v-model="changeValue"
        outlined
        clearable
        dense
        hide-details="auto"
        :placeholder="placeHolder"
        :counter="counter"
        :rules="rules"
        :hint="hint"
        persistent-hint
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
    counter: {
      type: Number,
      default: null,
    },
    rules: {
      type: Array,
      default: () => [],
    },
    hint: {
      type: String,
      default: null,
    },
    placeHolder: {
      type: String,
      default: null,
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
    },
    inputCols() {
      return this.placeHolder === null ? 8 : 12
    },
  },
}
</script>

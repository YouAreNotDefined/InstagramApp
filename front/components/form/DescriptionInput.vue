<template>
  <v-row justify="center" align="center">
    <v-col cols="4" class="text-right">
      <div class="font-weight-bold">{{ label }}</div>
    </v-col>
    <v-col cols="8">
      <v-textarea
        v-model="changeValue"
        outlined
        clearable
        dense
        auto-grow
        counter="150"
        rows="4"
        :rules="rules"
        hide-details="auto"
      ></v-textarea>
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
    rules: {
      type: Array,
      default: () => [],
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

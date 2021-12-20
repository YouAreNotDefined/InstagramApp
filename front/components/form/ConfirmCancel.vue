<template>
  <v-dialog
    v-model="inputedValue"
    width="400"
  >
    <template v-slot:activator="{ attrs }">
      <v-btn
        depressed
        v-bind="attrs"
        @click="controll"
        color="red"
        class="white--text"
      >
        キャンセル
      </v-btn>
    </template>
    <v-card class="text-center">
      <v-card-title>
        保存されていない変更
      </v-card-title>
      <v-card-subtitle>変更が保存されていません。このままキャンセルしますか？</v-card-subtitle>
      <v-divider></v-divider>
      <v-card-actions>
        <v-btn
          color="primary"
          text
          @click="cancel"
          width="100%"
        >
          はい
        </v-btn>
      </v-card-actions>
      <v-divider></v-divider>
      <v-card-actions>
        <v-btn
          color="red"
          text
          @click="inputedValue = false"
          width="100%"
        >
          いいえ
        </v-btn>
      </v-card-actions>
    </v-card>
  </v-dialog>
</template>

<script>
export default {
  props: {
    value: {
      type: Boolean,
      default: false,
    },
    disable: {
      type: Boolean,
      default: true,
    },
  },
  computed: {
    inputedValue: {
      get() {
        return this.value;
      },
      set(newValue) {
        this.$emit('input', newValue);
      },
    },
  },
  methods: {
    cancel() {
      this.$emit('cancel')
      this.$emit('input', false);
    },
    controll() {
      if (this.disable) {
        this.cancel()
      } else {
        this.$emit('input', true);
      }
    },
  },
}
</script>

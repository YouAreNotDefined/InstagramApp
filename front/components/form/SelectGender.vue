<template>
  <v-row justify="center" align="center">
    <v-col cols="4" class="text-right">
      <div class="font-weight-bold">{{ label }}</div>
    </v-col>
    <v-col cols="8">
      <v-dialog
        v-model="dialog"
        width="300"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            depressed
            v-bind="attrs"
            v-on="on"
          >
            性別を変更
          </v-btn>
        </template>
        <v-card class="text-center">
          <v-card-title>
            性別を変更
          </v-card-title>
          <v-divider></v-divider>
          <v-radio-group class="pl-5" v-model="tmp">
            <v-radio
              v-for="option in options"
              :key="option.id"
              :label="option.type_i18n"
              :value="option.id"
            ></v-radio>
          </v-radio-group>
          <v-divider></v-divider>
          <v-card-actions>
            <v-row justify="center" class="py-4">
              <v-col cols="5">
                <ConfirmCancel v-model="cancelDialog" :disable="disable" @cancel="cancel" />
              </v-col>
              <v-col cols="5">
                <v-btn
                  :disabled="disable"
                  color="primary"
                  @click="decide"
                >
                  完了
                </v-btn>
              </v-col>
            </v-row>
          </v-card-actions>
        </v-card>
      </v-dialog>
    </v-col>
  </v-row>
</template>

<script>
import ConfirmCancel from "./ConfirmCancel.vue";

export default {
  components: {
    ConfirmCancel
  },
  props: {
    value: {
      type: Number,
      default: null,
    },
    label: {
      type: String,
      default: '',
    },
  },
  data() {
    return {
      dialog: false,
      cancelDialog: false,
      options: [],
      tmp: null,
    }
  },
  computed: {
    disable() {
      return (this.tmp === this.value) || this.tmp === null
    },
  },
  watch: {
    value(newVal) {
      this.tmp = newVal
    },
  },
  async mounted() {
    const { data } = await this.$axios.get('/api/v1/genders')
    this.options = data.genders
    this.tmp = this.value
  },
  methods: {
    cancel() {
      this.dialog = false
      this.tmp = this.value
    },
    decide() {
      this.$emit("input", this.tmp);
      this.dialog = false
    },
  },
}
</script>

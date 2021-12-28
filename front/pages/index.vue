<template>
  <div width="500" class="mx-auto mt-10">
    <v-card width="500">
      <v-card-title>
        <h2 class="display-1 text-center">ログイン</h2>
      </v-card-title>
      <v-card-text>
        <v-form>
          <v-text-field prepend-icon="mdi-email" label="メールアドレス" v-model="email" :rules="[emailRules.required, emailRules.regex]"/>
          <v-text-field :type="showPassword ? 'text' : 'password'" @click:append="showPassword = !showPassword"
          prepend-icon="mdi-lock" :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'" label="パスワード" v-model="password" :rules="[passwordRules.required, passwordRules.regex]"/>
          <v-card-actions>
            <v-btn color="primary" @click="submit" :loading="loading">ログイン</v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
      <v-card-text>
        <nuxt-link to="/reset">パスワードを忘れた場合</nuxt-link>
      </v-card-text>
    </v-card>
    <v-divider></v-divider>
    <div class="pt-8 pb-4">
      <span>アカウントをお持ちではないですか？</span>
      <nuxt-link to="/signup">登録する</nuxt-link>
    </div>
  </div>
</template>

<script>
import MixinForm from "../plugins/mixinSignValidator.js";

export default {
  mixins: [MixinForm],
  data() {
    return {
      showPassword: false,
      email: null,
      password: null,
      loading: false
    }
  },
  methods: {
    submit() {
      this.loading = true

      this.$auth.loginWith('local', {data: { email: this.email, password: this.password }})
        .then(res => res)
        .catch(err => err)
        .finally(() => this.loading = false)
    }
  }
}
</script>

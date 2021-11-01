<template>
  <div width="500" class="mx-auto mt-10">
    <v-card width="500">
      <v-card-title>
        <h2 class="display-1 text-center">新規登録</h2>
      </v-card-title>
      <v-card-text>
        <v-form>
          <v-text-field prepend-icon="mdi-email" label="メールアドレス" v-model="email" :rules="[emailRules.required, emailRules.regex]"/>
          <v-text-field :type="showPassword ? 'text' : 'password'" @click:append="showPassword = !showPassword"
          prepend-icon="mdi-lock" :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'" label="パスワード" v-model="password" :rules="[passwordRules.required, passwordRules.regex]"/>
          <v-text-field :type="showPassword ? 'text' : 'password'" @click:append="showPassword = !showPassword"
          prepend-icon="mdi-lock" :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'" label="パスワード確認" v-model="password_confirmation" :rules="[passwordConfirmationRules.required, passwordConfirmationRules.regex]"/>
          <v-card-actions>
            <v-btn color="primary" @click="submit" :loading="loading">登録</v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
      <v-card-text>
        <nuxt-link to="/reset">パスワードを忘れた場合</nuxt-link>
      </v-card-text>
    </v-card>
    <v-divider></v-divider>
    <div class="pt-8 pb-4">
      <span>既にアカウントをお持ちですか？</span>
      <nuxt-link to="/">ログイン</nuxt-link>
    </div>
  </div>
</template>

<script>
import MixinForm from "../plugins/mixinForm.js";

export default {
  auth: false,
  mixins: [MixinForm],
  data() {
    return {
      showPassword: false,
      email: null,
      password: null,
      password_confirmation: null,
      loading: false,
      passwordConfirmationRules: {
        required: (value) => !!value || 'パスワードを再度入力してください',
        regex: (value) => value === this.password || 'パスワードが違います'
      },
    }
  },
  methods: {
    submit() {
      this.loading = true

      this.$axios.post('/api/v1/auth', { email: this.email, password: this.password, password_confirmation: this.password_confirmation })
        .then(res => {
          this.$auth.loginWith('local', {data: { email: this.email, password: this.password }})
          this.$router.push('/posts')
        })
        .catch(err => {

        })
        .finally(() => this.loading = false)
    },
  }
}
</script>

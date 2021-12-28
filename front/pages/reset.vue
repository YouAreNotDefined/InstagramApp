<template>
  <div width="500" class="mx-auto mt-10">
    <v-card width="500">
      <v-card-title>
        <h2 class="display-1 text-center">パスワードリセット</h2>
      </v-card-title>
      <v-card-text>
        <v-form>
          <v-text-field prepend-icon="mdi-email" label="メールアドレス" v-model="email" :rules="[emailRules.required, emailRules.regex]"/>
          <div v-if="hasEmailed">
            <v-text-field :type="showPassword ? 'text' : 'password'" @click:append="showPassword = !showPassword"
            prepend-icon="mdi-lock" :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'" label="パスワード" v-model="password" :rules="[passwordRules.required, passwordRules.regex]"/>
            <v-text-field :type="showPassword ? 'text' : 'password'" @click:append="showPassword = !showPassword"
            prepend-icon="mdi-lock" :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'" label="パスワード確認" v-model="password_confirmation" :rules="[passwordConfirmationRules.required, passwordConfirmationRules.regex]"/>
          </div>
          <v-card-actions>
            <v-btn v-if="hasEmailed" color="primary" @click="reset" :loading="loading">変更</v-btn>
            <v-btn v-else color="primary" @click="submit" :loading="loading">送信</v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
    <v-divider></v-divider>
    <div class="pt-8 pb-4">
      <span>新しく登録する</span>
      <nuxt-link to="/signup">登録</nuxt-link>
    </div>
  </div>
</template>

<script>
import MixinForm from "../plugins/mixinSignValidator.js";

export default {
  auth: false,
  mixins: [MixinForm],
  async asyncData({ query }) {
    let hasEmailed = false
    if(Object.keys(query).length) {
      hasEmailed = true
      localStorage.client = query.client
      localStorage['access-token'] = query['access-token']
      localStorage.uid = query.uid
    }

    return {
      hasEmailed,
      query,
    }
  },
  data() {
    return {
      email: null,
      password: null,
      password_confirmation: null,
      loading: false,
      showPassword: false,
      passwordConfirmationRules: {
        required: (value) => !!value || 'パスワードを再度入力してください',
        regex: (value) => value === this.password || 'パスワードが違います'
      },
    }
  },
  methods: {
    submit() {
      this.loading = true

      this.$axios.post('/api/v1/auth/password', { email: this.email, 'redirect_url': 'http://localhost:8080/reset/' })
        .catch(err => {})
        .finally(() => this.loading = false)
    },
    reset() {
      this.loading = true

      this.$axios.put('/api/v1/auth/password', { password: this.password, password_confirmation: this.password_confirmation })
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

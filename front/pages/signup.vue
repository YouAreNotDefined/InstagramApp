<template>
  <div width="500" class="mx-auto mt-10">
    <v-card width="500">
      <v-card-title>
        <h2 class="display-1 text-center">新規登録</h2>
      </v-card-title>
      <v-card-text>
        <v-form>
          <AccountInput v-model="registration.name" placeholder="名前" :counter="20" :rules="[nameRules.required, nameRules.regex]" />
          <AccountInput v-model="registration.nickname" placeholder="ユーザーネーム" :counter="20" :rules="[nameRules.required, nameRules.regex]" />
          <v-text-field prepend-icon="mdi-email" label="メールアドレス" v-model="registration.email" :rules="[emailRules.required, emailRules.regex]"/>
          <v-text-field :type="showPassword ? 'text' : 'password'" @click:append="showPassword = !showPassword"
          prepend-icon="mdi-lock" :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'" label="パスワード" v-model="registration.password" :rules="[passwordRules.required, passwordRules.regex]"/>
          <v-text-field :type="showPassword ? 'text' : 'password'" @click:append="showPassword = !showPassword"
          prepend-icon="mdi-lock" :append-icon="showPassword ? 'mdi-eye' : 'mdi-eye-off'" label="パスワード確認" v-model="registration.password_confirmation" :rules="[passwordConfirmationRules.required, passwordConfirmationRules.regex]"/>
          <v-card-actions>
            <v-btn color="primary" @click="submit" :loading="loading">登録</v-btn>
          </v-card-actions>
        </v-form>
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
import MixinForm from "../plugins/mixinSignValidator.js";
import AccountInput from "../components/form/AccountInput.vue"

export default {
  auth: false,
  mixins: [MixinForm],
  components: {
    AccountInput,
  },
  data() {
    return {
      showPassword: false,
      loading: false,
      passwordConfirmationRules: {
        required: (value) => !!value || 'パスワードを再度入力してください',
        regex: (value) => value === this.registration.password || 'パスワードが違います'
      },
      registration: {
        email: null,
        password: null,
        password_confirmation: null,
        name: null,
        nickname: null,
      },
    }
  },
  methods: {
    submit() {
      this.loading = true

      this.$axios.post('/api/v1/auth', this.registration)
        .then(res => {
          this.$auth.loginWith('local', { data: { email: this.email, password: this.password }})
          this.$router.push('/posts')
        })
        .catch(err => {

        })
        .finally(() => this.loading = false)
    },
  }
}
</script>

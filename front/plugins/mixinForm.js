export default {
  data() {
    return {
      emailRules: {
        required: (value) => !!value || 'メールアドレスは必須です',
        regex: (value) => /^(([^<>()[\]\\.,;:\s@]+(\.[^<>()[\]\\.,;:\s@]+)*)|(.+))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(value) || 'メールアドレスの形式が違います'
      },
      passwordRules: {
        required: (value) => !!value || 'パスワードは必須です',
        regex: (value) => /^(?=.*?[a-z])(?=.*?[A-Z])(?=.*?\d)[a-zA-Z\d]{8,15}$/.test(value) || '半角英小文字大文字数字を含む7文字以上15文字以下で入力してください'
      },
    }
  }
}

export default {
  data() {
    return {
      emailRules: {
        required: (value) => !!value || 'メールアドレスは必須です',
        regex: (value) => /^(([^<>()[\]\\.,;:\s@]+(\.[^<>()[\]\\.,;:\s@]+)*)|(.+))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$/.test(value) || 'メールアドレスの形式が違います'
      },
      nameRules: {
        required: (value) => !!value || '必須です',
        regex: (value) => /^([!-~]{1,20})$/.test(value) || '20文字以下で入力してください'
      },
      websiteRules: {
        regex: (value) => /^((https?|ftp)(:\/\/[\w\/:%#\$&\?\(\)~\.=\+\-]+))$/.test(value) || '形式が違います'
      },
      descriptionRules: {
        regex: (value) => /^([!-~]{0,150})$/.test(value) || '150文字以下で入力してください'
      },
      phoneRules: {
        regex: (value) => /^0\d{9,10}$/.test(value) || value === '' || '形式が違います'
      },
    }
  }
}

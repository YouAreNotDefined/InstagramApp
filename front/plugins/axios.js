export default ({ $axios }) => {
  $axios.onRequest(config => {
    config.headers.client = localStorage.getItem("client")
    config.headers["access-token"] = localStorage.getItem("access-token")
    config.headers.uid = localStorage.getItem("uid")
    config.headers["token-type"] = localStorage.getItem("token-type")
  })

  $axios.onResponse(response => {
    if (response.headers.client) {
      localStorage.setItem("access-token", response.headers["access-token"])
      localStorage.setItem("client", response.headers.client)
      localStorage.setItem("uid", response.headers.uid)
      localStorage.setItem("token-type", response.headers["token-type"])
    }
  })

  $axios.onError(err => {
    if (err.response.status === 401) {
      alert('パスワードまたは、メールアドレスが違います。')
    } else if (err.response.status === 500) {
      alert('サーバーで問題が発生しました。しばらく時間を置いてからやり直してください。')
    }
  })
}

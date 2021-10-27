module.exports = {
  /*
  ** Headers of the page
  */
  head: {
    title: 'app',
    meta: [
      { charset: 'utf-8' },
      { name: 'viewport', content: 'width=device-width, initial-scale=1' },
      { hid: 'description', name: 'description', content: 'Nuxt.js project' }
    ],
  },
  buildModules: [
    '@nuxtjs/vuetify',
  ],
  modules: [
    "@nuxtjs/axios",
    '@nuxtjs/auth'
  ],
  plugins: [
    { src: '~/plugins/axios.js', ssr: false }
  ],
  axios: {
    baseURL: 'http://localhost:3000'
  },
  auth: {
    redirect: {
      login: '/',
      logout: '/',
      callback: false,
      home: '/posts'
    },
    strategies: {
      local: {
        endpoints: {
          login: { url: '/api/v1/auth/sign_in', method: 'post', propertyName: false },
          logout: { url: '/api/v1/auth/sign_out', method: 'delete' },
          user: false
        }
      }
    }
  },
  router: {
    middleware: ['auth']
  },
  /*
  ** Customize the progress bar color
  */
  loading: { color: '#3B8070' },
  /*
  ** Build configuration
  */
  build: {
    /*
    ** Run ESLint on save
    */
    extend (config, { isDev, isClient }) {
      if (isDev && isClient) {
        config.module.rules.push({
          enforce: 'pre',
          test: /\.(js|vue)$/,
          loader: 'eslint-loader',
          exclude: /(node_modules)/
        })
      }
    }
  },
  server: {
    port: 8080,
    host: '0.0.0.0'
  },
}

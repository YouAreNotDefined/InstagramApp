<template>
  <v-app-bar app>
    <v-container>
      <v-row>
        <v-col class="mt-3">
          <h1 class="display-0">Instagram Clone</h1>
        </v-col>
        <v-col v-if="signedIn" class="mt-4">
          <v-autocomplete
            v-model="tag"
            :items="tags"
            item-text="name"
            label="検索"
          ></v-autocomplete>
        </v-col>
        <v-col align="right" v-if="signedIn" class="mt-3">
          <v-btn icon nuxt :to="'/posts'">
            <v-icon>mdi-home</v-icon>
          </v-btn>
          <v-btn icon nuxt :to="'/posts/new'">
            <v-icon>mdi-shape-square-rounded-plus</v-icon>
          </v-btn>
          <v-btn icon nuxt :to="'/chat'">
            <v-icon>mdi-chat</v-icon>
          </v-btn>
          <v-btn icon nuxt :to="'/likes'">
            <v-icon>mdi-cards-heart-outline</v-icon>
          </v-btn>
          <v-btn icon nuxt :to="'/account'">
            <v-icon>mdi-account-circle-outline</v-icon>
          </v-btn>
          <v-btn icon @click="logout">
            <v-icon>mdi-logout</v-icon>
          </v-btn>
        </v-col>
      </v-row>
    </v-container>
  </v-app-bar>
</template>

<script>
export default {
  data() {
    return {
      tag: null,
      tags: []
    }
  },
  computed: {
    signedIn() {
      return this.$auth.loggedIn
    }
  },
  methods: {
    logout() {
      if (window.confirm('ログアウトしますか？')) {
        this.$auth.logout({data: { uid: localStorage.uid, client: localStorage.client, 'access-token': localStorage['access-token'] }})
          .then(res => {
            localStorage.clear()
            return res
          })
          .catch(err => err)
      }
    }
  }
}
</script>

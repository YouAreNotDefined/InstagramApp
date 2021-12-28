<template>
  <v-container class="mx-auto mt-10">
    <v-row justify="end">
      <v-col cols="1">
        <v-avatar
          color="teal"
          size="100"
        >
          <v-img
            v-if="user.image"
            :src="user.image.url"
          ></v-img>
        </v-avatar>
      </v-col>
      <v-col cols="6" class="ml-10">
        <v-row align="center">
          <v-col cols="1">
            <strong v-html="user.name"></strong>
          </v-col>
          <v-col cols="10">
            <v-btn depressed nuxt to="/account/edit" class="ml-4">
              プロフィールを編集
              <v-icon
                right
                dark
              >
                mdi-cog-outline
              </v-icon>
            </v-btn>
          </v-col>
        </v-row>
        <v-row>
          <v-col cols="3" md="1">

          </v-col>
          <v-col cols="3" md="1">
          </v-col>
          <v-col cols="3" md="1">
          </v-col>
        </v-row>
        <v-row>

        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      user: {},
      posts: [],
    }
  },
  async mounted() {
    const { data } = await this.$axios.get('/api/v1/users/profile')
    this.user = data.user
    this.posts = data.posts
  },
}
</script>

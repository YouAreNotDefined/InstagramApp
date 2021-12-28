<template>
  <div class="mt-5">
    <v-card
      v-for="post in posts" :key="post.content.id"
      elevation="2"
      tile
      max-width="700"
      class="mx-auto"
    >
      <nuxt-link :to="`/account/${post.user.id}`" class="text-decoration-none">
        <v-row
          align="center"
          no-gutters
        >
          <v-col
            cols="4"
            md="1"
          >
            <v-avatar
              color="teal"
              size="50"
            >
              <v-img
                v-if="post.user.image"
                :src="post.user.image.url"
              ></v-img>
            </v-avatar>
          </v-col>
          <v-col
            md="3"
          >
            <strong v-html="post.user.name"></strong>
          </v-col>
        </v-row>
      </nuxt-link>
      <v-img
        height=""
        :src="post.content.image.url"
      ></v-img>
      <v-card-text>
        <v-btn icon>
          <v-icon>mdi-cards-heart-outline</v-icon>
        </v-btn>
        <v-btn icon class="ml-1">
          <v-icon>mdi-comment-outline</v-icon>
        </v-btn>
        <v-btn icon class="ml-1">
          <v-icon>mdi-send-outline</v-icon>
        </v-btn>
        <div class="mt-1">{{ post.content.description }}</div>
      </v-card-text>
      <v-divider class="mx-4"></v-divider>

    </v-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      posts: [],
      suggestions: [],
    }
  },
  async mounted() {
    const { data } = await this.$axios.get('/api/v1/users')
    this.posts = data.posts
    this.suggestions = data.suggestions
  },
}
</script>

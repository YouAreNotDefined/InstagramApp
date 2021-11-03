<template>
  <div>
    <v-card
      v-for="post in posts" :key="post.id"
      elevation="2"
      tile
    >
    </v-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      posts: [],
    }
  },
  async mounted() {
    const { data } = await this.$axios.get('/api/v1/users/profile')
    this.posts = data.posts
  },
}
</script>

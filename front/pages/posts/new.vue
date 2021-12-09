<template>
  <div width="1000" class="mx-auto mt-10">
    <v-card width="1000">
      <v-card-title>
        <h2 class="display-1 text-center">新規投稿</h2>
      </v-card-title>
      <v-card-text>
        <v-form>
          <v-file-input
            v-model="data.image"
            show-size
            accept="image/*"
            label="写真を選択"
            @change="getImage"
            @click:clear="clearImg"
          ></v-file-input>
          <v-img
            v-show="image"
            :src="image"
          ></v-img>
          <v-textarea
            v-model="data.description"
            counter
            clearable
            clear-icon="mdi-close-circle"
            label="キャプションを入力"
            :rules="[rules.description]"
          ></v-textarea>
          <v-overflow-btn
            :items="[]"
            v-model="data.place_id"
            label="位置情報を追加する"
            prepend-icon="mdi-map-marker"
            editable
            @input="searchPlace"
          ></v-overflow-btn>
          <v-switch
            v-model="data.commentable"
            label="コメントをオフにする"
            false-value="true"
            true-value="false"
          ></v-switch>
          <v-card-actions>
            <v-btn color="primary" @click="post" :loading="loading">シェア</v-btn>
          </v-card-actions>
        </v-form>
      </v-card-text>
    </v-card>
  </div>
</template>

<script>
export default {
  data() {
    return {
      loading: false,
      data: {
        image: null,
        place_id: null,
        description: null,
        commentable: true,
      },
      image: null,
      rules: {
        description: value => value && value.length <= 2200 || '2200文字以下で入力してください',
      }
    }
  },
  methods: {
    post() {
      this.loading = true
      const formData = new FormData();

      Object.entries(this.data).forEach(([key, value]) => {
        if(value) formData.append(`post[${key}]`, value)
      })

      this.$axios.post('/api/v1/posts', formData)
        .then(res => {
          this.$router.push('/posts')
        })
        .catch(err => {})
        .finally(() => this.loading = false)
    },
    async getImage(file) {
      try {
        this.image = await this.readFileAsync(file)
      } catch (e) {
        console.log(e)
      }
    },
    readFileAsync(file) {
      return new Promise((resolve, reject) => {
        const reader = new FileReader()
        reader.onload = () => {
          resolve(reader.result)
        }
        reader.onerror = reject
        reader.readAsDataURL(file)
      })
    },
    clearImg() {
      this.image = null
    },
    searchPlace() {},
  },
}
</script>

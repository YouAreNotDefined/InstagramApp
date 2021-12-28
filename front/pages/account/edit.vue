<template>
  <v-container class="mx-auto mt-10">
    <v-row>
      <AccountSidebar />
      <v-col cols="9">
        <v-card class="pa-10 pt-5">
          <v-row justify="center">
            <v-col cols="4" class="text-right">
              <v-avatar
                color="teal"
                size="50"
              >
                <v-img
                  v-if="image || user.image"
                  :src="image || user.image.url"
                ></v-img>
              </v-avatar>
            </v-col>
            <v-col cols="8">
              <div>
                <strong v-html="user.name"></strong>
              </div>
              <v-dialog
                v-model="dialog"
                width="500"
              >
                <template v-slot:activator="{ on, attrs }">
                  <v-btn
                    depressed
                    v-bind="attrs"
                    v-on="on"
                  >
                    プロフィール写真を変更
                  </v-btn>
                </template>
                <v-card class="text-center">
                  <v-card-title>
                    プロフィール写真を変更
                  </v-card-title>
                  <v-divider></v-divider>
                  <v-card-actions>
                    <v-file-input
                      v-model="user.image"
                      accept="image/*"
                      label="写真をアップロード"
                      @change="getImage"
                      @click:clear="image = null"
                    ></v-file-input>
                  </v-card-actions>
                  <v-divider></v-divider>
                  <v-card-actions>
                    <v-btn
                      color="red"
                      text
                      @click="deleteImage"
                      width="100%"
                    >
                      現在の写真を削除
                    </v-btn>
                  </v-card-actions>
                  <v-divider></v-divider>
                  <v-card-actions>
                    <v-btn
                      text
                      @click="dialog = false"
                      width="100%"
                    >
                      キャンセル
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </v-col>
          </v-row>
          <AccountInput v-model="user.name" label="名前" :counter="20" :rules="[nameRules.required, nameRules.regex]" />
          <AccountInput v-model="user.nickname" label="ユーザーネーム" :counter="20" :rules="[nameRules.required, nameRules.regex]" />
          <AccountInput v-model="user.website" label="ウェブサイト" :rules="[websiteRules.regex]" />
          <DescriptionInput v-model="user.description" label="自己紹介" :rules="[descriptionRules.regex]" />
          <AccountInput v-model="user.email" label="メールアドレス" :rules="[emailRules.required, emailRules.regex]" />
          <AccountInput v-model="user.phoneNumber" label="電話番号" :rules="[phoneRules.regex]" hint="ハイフン無しで入力して下さい" />
          <SelectGender v-model="user.gender_id" label="性別" :gender_detail="user.gender_detail" @inputCustomizeValue="user.gender_detail = $event" />
          <v-row justify="center" class="py-2">
            <v-btn color="primary" :loading="loading" @click="save">保存</v-btn>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import AccountSidebar from "../../components/ui/AccountSidebar.vue"
import AccountInput from "../../components/form/AccountInput.vue"
import SelectGender from "../../components/form/SelectGender.vue"
import DescriptionInput from "../../components/form/DescriptionInput.vue"
import validator from "../../plugins/mixinAccountValidator";

export default {
  beforeRouteLeave(to, from, next) {
    if (this.formChanged) {
      const msg = this.blockUnloadMessage
      const answer = window.confirm(msg)
      next(answer)
    } else {
      next()
    }
  },
  components: {
    AccountSidebar,
    AccountInput,
    SelectGender,
    DescriptionInput
  },
  mixins: [validator],
  data() {
    return {
      dialog: false,
      user: {
        image: null,
        name: null,
        ncickname: null,
        website: null,
        description: null,
        email: null,
        phoneNumber: null,
        gender: null,
        gender_details: null,
      },
      comparisonData: {},
      loading: false,
      genders: {},
      image: null,
      blockUnloadMessage: '移動しますか？\n行った変更が保存されません。',
    }
  },
  created() {
    if (process.client) {
      window.addEventListener("beforeunload", this.checkWindow)
    }
  },
  beforeDestroy() {
    window.removeEventListener("beforeunload", this.checkWindow)
  },
  async mounted() {
    const { data } = await this.$axios.get('/api/v1/users/profile')
    this.user = data.user
    this.comparisonData = Object.assign({}, data.user)
  },
  computed: {
    formChanged() {
      const formData = JSON.stringify(this.objectSort(this.user))
      const comparisonData = JSON.stringify(this.objectSort(this.comparisonData))
      return formData !== comparisonData
    },
  },
  methods: {
    save() {
      this.loading = true
      const formData = new FormData();

      Object.entries(this.user).forEach(([key, value]) => {
        if(value) formData.append(`registration[${key}]`, value)
      })

      this.$axios.put('/api/v1/auth', formData)
        .then(res => {
          this.user = res.data
        })
        .catch(error => {

        })
        .finally(() => {
          this.loading = false
        })
    },
    deleteImage() {
      this.user.image = null
      this.image = null
      this.dialog = false
    },
    async getImage(file) {
      try {
        this.image = await this.readFileAsync(file)
        this.dialog = false
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
    objectSort(obj) {
      return Object.entries(obj).sort()
    },
    checkWindow(event) {
      if (this.formChanged) {
        event.preventDefault()
        event.returnValue = this.blockUnloadMessage
      }
    },
  },
}
</script>

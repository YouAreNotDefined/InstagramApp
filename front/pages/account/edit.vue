<template>
  <v-container class="mx-auto mt-10">
    <v-row>
      <AccountSidebar />
      <v-col cols="9">
        <v-card class="pa-5">
          <v-row justify="center">
            <v-col cols="4" class="text-right">
              <v-avatar
                color="teal"
                size="50"
              >
                <img
                  v-if="user.image"
                  :src="user.image"
                  alt="John"
                >
              </v-avatar>
            </v-col>
            <v-col cols="8">
              <div>
                <strong v-html="'kazuki'"></strong>
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
                    <v-btn
                      color="primary"
                      text
                      @click="dialog = false"
                    >
                      写真をアップロード
                    </v-btn>
                  </v-card-actions>
                  <v-divider></v-divider>
                  <v-card-actions>
                    <v-btn
                      color="red"
                      text
                      @click="dialog = false"
                    >
                      現在の写真を削除
                    </v-btn>
                  </v-card-actions>
                  <v-divider></v-divider>
                  <v-card-actions>
                    <v-btn
                      text
                      @click="dialog = false"
                    >
                      キャンセル
                    </v-btn>
                  </v-card-actions>
                </v-card>
              </v-dialog>
            </v-col>
          </v-row>
          <AccountInput v-model="user.name" label="名前" />
          <AccountInput v-model="user.nickname" label="ユーザーネーム" />
          <AccountInput v-model="user.website" label="ウェブサイト" />
          <AccountInput v-model="user.description" label="自己紹介" />
          <AccountInput v-model="user.email" label="メールアドレス" />
          <AccountInput v-model="user.phoneNumber" label="電話番号" />
          <SelectGender v-model="user.gender_id" label="性別" />
          <v-row justify="center" class="py-2">
            <v-btn color="primary" :loading="loading" @click="save">保存</v-btn>
          </v-row>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import AccountSidebar from "../../components/ui/AccountSidebar.vue";
import AccountInput from "../../components/form/AccountInput.vue";
import SelectGender from "../../components/form/SelectGender.vue";

export default {
  components: {
    AccountSidebar,
    AccountInput,
    SelectGender
  },
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
      loading: false,
      genders: {},
    }
  },
  async mounted() {
    const { data } = await this.$axios.get('/api/v1/users/profile')
    this.user = data.user
  },
  methods: {
    save() {
      this.loading = true

      this.$axios.put('/api/v1/auth', { user: this.user })
        .then(res => {

        })
        .catch(error => {

        })
        .finally(() => {
          this.loading = false
        })
    },
  },
}
</script>

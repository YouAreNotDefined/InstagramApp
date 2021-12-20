<template>
  <v-col cols="3">
    <v-card
      height="400"
      width="250"
      class="mx-auto"
    >
      <v-navigation-drawer permanent>
        <v-list
          dense
          nav
        >
          <v-list-item
            v-for="item in sides"
            :key="item.title"
          >
            <v-btn text nuxt :to='item.link'>
              <v-list-item-title>{{ item.title }}</v-list-item-title>
            </v-btn>
          </v-list-item>
        </v-list>
      </v-navigation-drawer>
    </v-card>
  </v-col>
</template>

<script>
export default {
  data() {
    return {
      sides: [
        { title: 'プロフィールを編集', link: '/account/edit' },
        { title: 'パスワードを変更', link: '/account/password' },
        { title: 'メールまたはSMS', link: '/account/email' },
        { title: 'プッシュ通知', link: '/account/notify' },
        { title: '連絡先の管理', link: '/account/contact' },
        { title: 'プライバシーとセキュリティ', link: '/account/privacy' },
        { title: 'ログインアクティビティ', link: '/account/activity' },
        { title: 'Instagramからのメール', link: '/account/emails_sent' },
      ]
    }
  },
}
</script>

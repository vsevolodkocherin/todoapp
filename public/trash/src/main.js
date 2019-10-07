import Vue from 'vue'
import App from './App.vue'
import router from './router'
import BootstrapVue from 'bootstrap-vue'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import feather from 'vue-icon'
// import 'node_modules/@livelybone/vue-datepicker/lib/css/index.css'

import axios from 'axios'
import VueAxios from 'vue-axios'

Vue.use(VueAxios, axios)
Vue.use(feather, 'v-icon')
Vue.axios.defaults.baseURL = "https://immense-basin-09197.herokuapp.com/"
// Vue.axios.defaults.baseURL = "http://localhost:3000/"


Vue.use(BootstrapVue)
Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')

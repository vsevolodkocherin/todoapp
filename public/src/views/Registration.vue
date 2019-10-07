<template>
  <div class="home">
  <div>
    <h1>Registration</h1>
    <b-form v-on:submit.prevent="onSubmit">
      <b-form-group id="input-group-2" label="Your Username:" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="form.username"

          required
          placeholder="Enter username"
        ></b-form-input>
      </b-form-group>

      <label for="text-password">Password</label>
      <b-input v-model="form.password" type="password" id="text-password" aria-describedby="password-help-block"></b-input>




      <b-button type="submit" variant="primary" @click="signUp()">Sign Up</b-button>
      <b-button type="reset" variant="danger">Reset</b-button>
    </b-form>
  </div>
  </div>
</template>

<script>
// @ is an alias to /src
//import HelloWorld from '@/components/HelloWorld.vue'

export default {
  name: 'registration',
  data () {
    return {
      form: {
        username: '',
        password: ''
      }
    }
  },
  methods: {
    onSubmit () {
      return false
    },
    signUp () {
      this.axios.post('/sign-up', this.form).then(response => {
        if(response.data.error) {
          alert('Registration error')
        } else {
          this.$router.push('login')
        }
      })
    }
  }
}
</script>

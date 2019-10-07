<template>
  <div class="home">
  <div>
    <h1>Login</h1>
    <b-form v-on:submit.prevent="onSubmit">
      <b-form-group id="input-group-2" label="Your Username:" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="form.username"

          required
          placeholder="Enter username"
        ></b-form-input>
        <b-form-invalid-feedback :state="usernameValidation">
          Username must be present
        </b-form-invalid-feedback>

      </b-form-group>

      <label for="text-password">Password</label>
      <b-input v-model="form.password" type="password" id="text-password" aria-describedby="password-help-block"></b-input>
      <b-form-invalid-feedback :state="passwordValidation">
        Password must be present
      </b-form-invalid-feedback>



      <b-button type="submit" variant="primary" @click="login()">Submit</b-button>
      <b-button type="reset" variant="danger">Reset</b-button>
    </b-form>
  </div>
  </div>
</template>

<script>
// @ is an alias to /src
import _ from 'lodash'

export default {
  name: 'login',
  computed: {
    usernameValidation() {
      return !_.isEmpty(this.form.username)
    },
    passwordValidation() {
      return !_.isEmpty(this.form.password)
    },
  },
  data () {
    return {
      form: {
        username: '',
        password: ''
      }
    }
  },
  mounted () {
    localStorage.token = ''
  },
  methods: {
    onSubmit () {
      return false
    },
    login () {
      if (!this.usernameValidation || !this.passwordValidation) {
        return
      }
      this.axios.post('/login', this.form).then(response => {
        if(response.data.error) {
          alert('Wrong credentials')
        } else {
          const token = response.data.token
          localStorage.token = token

          this.$router.push('projects')
        }
      })
    }
  }
}
</script>

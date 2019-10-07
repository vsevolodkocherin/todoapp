<template>
  <div class="home">
  <div>
    <h1>New project</h1>
    <b-form v-on:submit.prevent="onSubmit">
      <b-form-group id="input-group-2" label="Your Project name:" label-for="input-2">
        <b-form-input
          id="input-2"
          v-model="form.name"

          required
          placeholder="Enter project name"
        ></b-form-input>
        <b-form-invalid-feedback :state="validation">
          Project name must be present
        </b-form-invalid-feedback>

      </b-form-group>


      <b-button type="submit" variant="primary" @click="createProject()">Create</b-button>
      <b-button type="reset" variant="danger">Reset</b-button>
    </b-form>
  </div>
  </div>
</template>

<script>
// @ is an alias to /src
import _ from 'lodash'

export default {
  name: 'new-project',
  computed: {
    validation() {
      return !_.isEmpty(this.form.name)
    }
  },
  data () {
    return {
      form: {
        name: ''
      }
    }
  },
  methods: {
    onSubmit () {
      return false
    },
    createProject () {
      if (!this.validation) {
        return
      }
      const params = {
        name: this.form.name,
        token: localStorage.token
      }
      this.axios.post('/projects', params).then(response => {
        if(response.data.error) {
          alert('error')
        } else {
          this.$router.push('projects')
        }
      })
    }
  }
}
</script>

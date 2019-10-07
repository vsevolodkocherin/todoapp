<template>
  <div>
    <h1>Projects</h1>
    <b-card
      :title="project.name"
      v-for="project in projects"
      v-bind:key="project.id"
      class="project"
    >
    
      <b-card-text>
        <label-edit v-bind:text="project.name" placeholder="Enter text value" v-on:text-updated-blur="meth2" v-on:text-updated-enter="meth1(project)"></label-edit>
        <p v-if="project.tasks.length == 0">no tasks</p>
        <b-table-simple v-else hover small caption-top responsive>
          <b-thead head-variant="dark">
            <b-tr>
              <b-th>Move</b-th>
              <b-th>Status</b-th>
              <b-th>Name</b-th>
              <b-th>Deadline</b-th>
              <b-th>Actions</b-th>
            </b-tr>
          </b-thead>
          <b-tbody>
            <b-tr v-for="task in project.tasks" v-bind:key="task.id">
              <b-td>
                <a v-if="canMoveHigher(project, task)" @click="moveHigher(project, task)"><v-icon name="arrow-up" ></v-icon></a>
                <a v-if="canMoveLower(project, task)" @click="moveLower(project, task)"><v-icon name="arrow-down" ></v-icon></a>
              </b-td>
              <b-td>
                <b-form-checkbox
                  v-model="task.done"
                  @change="updateTask(project, task)"
                >
                  Done
                </b-form-checkbox>
                </b-td>
              <b-td>
                
                <b-form-input
                  v-if="task.edit"
                  v-model="task.name"
                  size="sm"
                  type="text"
                  placeholder="task name"
                ></b-form-input>
                <span v-else>{{task.name}}</span>
              </b-td>
              <b-td>
                <date-pick v-if="task.edit" v-model="task.deadline"></date-pick>
                <span v-else>{{task.deadline}}</span>
              </b-td>
              <b-td>
                <b-button v-if="task.edit" variant="link" size="sm" @click="updateTask(project, task)"><v-icon name="save" ></v-icon></b-button>
                <b-button v-else variant="link" size="sm" @click="task.edit = true"><v-icon name="edit-2" ></v-icon></b-button>
                <b-button variant="link" size="sm" @click="removeTask(project, task)"><v-icon name="trash-2" ></v-icon></b-button>
                
              </b-td>
            </b-tr>
          </b-tbody>
        </b-table-simple>

        <div class="row">
          <div class="col-md-5">
            <b-form-input
              v-model="project.new_task_name"
              size="sm"
              type="text"
              placeholder="Enter task"
            ></b-form-input>
          </div>
          <div class="col-md-3">
            <date-pick v-model="project.new_task_deadline"></date-pick>
          </div>
          <div class="col-md-4">
            <b-button size="sm" @click="addTask(project)">add a new task</b-button>
          </div>
        </div>
      </b-card-text>

      <b-button size="sm" @click="removeProject(project)">remove project</b-button>
    </b-card>

    <router-link to="/new-project">Add new project</router-link>
  </div>
</template>


<script>
// @ is an alias to /src
import _ from 'lodash'
import DatePick from 'vue-date-pick';
import 'vue-date-pick/dist/vueDatePick.css';
import LabelEdit from 'label-edit';

export default {
  components: {DatePick, LabelEdit},
  name: 'projects',
  data () {
    return {
      openProject: {},
      projects: [],
      date: '2019-01-01'
    }
  },
  mounted () {
    this.refresh()
  },
  methods: {
    canMoveHigher(project, task) {
      return project.tasks[0].id != task.id
    },
    canMoveLower(project, task) {
      return _.last(project.tasks).id != task.id
    },
    moveHigher(project, task) {
      const path = `/projects/${project.id}/tasks/${task.id}/move_higher`
      const params = {
        token: localStorage.token
      }
      this.axios.put(path, params).then(response => {
        if (response.data.id) {
          this.refresh();
        } else {
          console.error('cannot move task: ' + response)
        }
      })
    },
    moveLower(project, task) {
      const path = `/projects/${project.id}/tasks/${task.id}/move_lower`
      const params = {
        token: localStorage.token
      }
      this.axios.put(path, params).then(response => {
        if (response.data.id) {
          this.refresh();
        } else {
          console.error('cannot move task: ' + response)
        }
      })
    },
    meth1 (project) {
      this.openProject = project
    },

    meth2(text) {
      if (!this.openProject.id) {
        return
      }
      this.openProject.name = text
      // debugger

      const project = this.openProject
      const params = {
        token: localStorage.token,
        project: project
      }
      this.axios.put('/projects/' + project.id, params).then(response => {
        console.log(response)
      })

    },
    fetchTasks(project) {
      if (_.isEmpty(project)) {
        return
      }
      const params = {
        token: localStorage.token
      }

      this.axios.get('/projects/' + project.id + '/tasks', { params: params }).then(response => {
        project.tasks = _.map(response.data, (task) => {
          return {...task, edit: false}
        })
      })
    },
    refresh () {
      const params = {
        token: localStorage.token
      }
      this.axios.get('/projects', { params: params }).then(response => {
        const projects = response.data
        this.projects = _.map(projects, (project) => {
          project.tasks = []
          return project
        })
        
        _.each(this.projects, (project) => this.fetchTasks(project))
      })
    },
    removeProject(project) {
      const params = {
        token: localStorage.token
      }
      this.axios.delete('/projects/' + project.id, { params: params }).then(response => {
        this.refresh()
      })
    },
    addTask(project) {
      if (_.isEmpty(project.new_task_name)) {
        return
      }
      const params = {
        token: localStorage.token,
        name: project.new_task_name,
        deadline: project.new_task_deadline
      }
      this.axios.post('/projects/' + project.id + '/tasks', params).then(response => {
        if (response.data) {
          project.new_task_name = ''
          project.new_task_deadline = ''
          this.fetchTasks(project)
        }
      })

    },
    removeTask(project, task) {
      const params = {
        token: localStorage.token
      }
      this.axios.delete('/projects/' + project.id + '/tasks/' + task.id, { params: params}).then(response => {
        if (response.data) {
          this.fetchTasks(project)
        }
      })
    },
    updateTask(project, task) {
      task.edit = false
      const params = {
        task: task,
        token: localStorage.token
      }
      this.axios.put('/projects/' + project.id + '/tasks/' + task.id, params).then(response => {
        if (response.data) {
          this.fetchTasks(project)
        }
      })
    }

  }
}
</script>

<style lang="css">
.project {
  margin-top: 20px;
}
.icon {
  width: 16px;
  cursor: pointer;
}
</style>

<template>
  <div id="app">
    <div id="nav">
      <router-link to="/login">Login</router-link> |
      <router-link to="/registration">Sign Up</router-link> |
      <router-link to="/projects">Projects</router-link> |
      <router-link to="/login">Logout</router-link>
    </div>

    <div class="row">
      <div class="col-md-3"></div>
      <div class="col-md-6">
        <router-view/>
      </div>
      <div class="col-md-3"></div>
    </div>
  </div>
</template>

<style>
#app {
  font-family: 'Avenir', Helvetica, Arial, sans-serif;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  text-align: center;
  color: #2c3e50;
}
#nav {
  padding: 30px;
}

#nav a {
  font-weight: bold;
  color: #2c3e50;
}

#nav a.router-link-exact-active {
  color: #42b983;
}
</style>

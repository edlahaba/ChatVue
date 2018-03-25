<template>
  <div class="wrapper">
    <div class="form-signin"> 
      <div class="row">
        <div class="col-md-12 text-center">
          <img class="logo" src="/chat.png"/>
        </div>
      </div>
      <validation-errors :message="errors"/>
      <input @keyup.enter="enviar" type="text" v-model="username" class="form-control" placeholder="Username" />
      <br>  
      <button v-on:click="enviar" id="boton-login" class="btn btn-primary">Login</button> 
    </div>
  </div>
</template>

<script>
  import validationErrors from './validationErrors';
  export default{
    data: function() {
      return {
        username: '',
        errors: []
      }
    },
    methods:{
      enviar(){
         this.errors = [];
         this.$http.post('/users', {
            username: this.username
         }).then(function(response){
              sessionStorage.setItem('token', response.body['token']);
              this.$router.push("rooms")         
         }, function(response){
              this.errors = response.body['errors'];
         });
      }
    },
    components: {
      'validation-errors': validationErrors
    }
  }
</script>

<style>
</style>
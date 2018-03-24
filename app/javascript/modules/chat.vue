<template>
  <div class="container-fluid">
    <div class="row back">
      <div class="col-md-2 col-md-offset-10 text-right">
        <router-link style="margin-bottom:10px;" class="btn btn-primary" to="/rooms">Back</router-link>
      </div>
    </div>
    <chat-box/>
    <chat-bar/>
  </div>
</template>

<script>
  import chatBox from './chatBox';
  import chatBar from './chatBar';
  export default{
    components: {
      'chat-box' : chatBox,
      'chat-bar' : chatBar
    }
  }
</script>

<style>

.container-fluid{
  margin-top: 1%;
}

</style>
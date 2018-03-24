<template>
  <div>
    <div class="container rooms">
      <div class="row">
        <div class="col-md-4">
          <img class="logo" src="/chat.png"/>
        </div>
        <div class="col-md-4 col-md-offset-4 text-right">
          <button class="btn btn-primary btn-add-room" data-toggle="modal" data-target="#addRoomModal">Add room</button>
        </div>
      </div>
      <div class="row" v-for="room in rooms">
        <div class="card w-75">
          <div class="card-body">
            <button :data-room="room._id.$oid" class="room-name" @click="goChat">{{room.name}}</button> 
          </div>
        </div>
      </div>
      <div class="row" v-if="rooms.length == 0">
        <div class="col-md-4 col-md-offset-4 text-center">
          <h3>There are no rooms available.</h3>
        </div>
      </div>
    </div>
    <add-room-modal/>
  </div>
</template>

<script>
  import addRoomModal from './addRoomModal';
  export default{
    data: function(){
      return {
        rooms: []
      }
    },
    methods:{
      goChat(event){
        var roomId = event.currentTarget.getAttribute("data-room")
        this.$router.push({ name: 'chat', query: {roomId: roomId }})
      },
      getRooms(){
         this.$http.get('/rooms').then(function(response){ 
            this.rooms = response.body
         });
      }
    },
    created: function(){
      this.getRooms();
    },
    components: {
      'add-room-modal' : addRoomModal
    }
  }
</script>

<style scoped>

.room-name{
  border: none;
  background: none;
  color: #4286f4;
  font-size: 24px;
}

body{
  background: white !important;
}

.logo{
  height: 80px;
}

.btn-add-room{
  padding:15px;
  font-size: 18px;
}

.rooms{
  background: white;
  padding:2%;
  margin-bottom:5%;
}

.card{
  padding: 1%;
  margin-top: 12px;
}

</style>
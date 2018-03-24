<template>
   <div class="row chat-box">
      <div class="col-md-12">
        <div id="chat">
          <ul>
            <li class="message" v-for="value in messages">
              <b>{{ value.username }}</b>  > {{ value.message }}
            </li>
          </ul>
        </div>
      </div>
    </div>
</template>

<script>
  export default{
    data: function(){
      return {
        messages: [],
        actionCable: null
      }
    },
    created: function(){
       const action = ActionCable.createConsumer()
       const printMessages = this.printMessages;
       const functions = {received(data){printMessages(data)}}
       this.printSavedMessages()
       this.actionCable = action.subscriptions.create(
        { channel: "ChatChannel", room: this.$route.query.roomId },
        functions
       )
    },
    methods: {
      printMessages(message){
        this.messages.push(message);
        $('.chat-box').animate({scrollTop: $('.chat-box').get(0).scrollHeight + 100},2);
      },
      printSavedMessages(){
        this.$http.get('/rooms/'+this.$route.query.roomId).then(function(response){
          this.messages = response.body
        });
      }
    }
  }
</script>

<style>
  
.message-box{padding-right: 0px;}

ul, ol{
  list-style-type: none;
  margin-top: 0px;
}

.chat-box{
  height: 85vh;
  background: white;

  overflow-y: scroll;
}

</style>
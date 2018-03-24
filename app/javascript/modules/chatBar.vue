<template>
  <div class="row chat-bar">
    <div class="message-box col-md-11">
      <input @keyup.enter="send" id="message-box" type="text" v-model="content" placeholder="Write a message.."/>
    </div>
    <div class="send-message-button col-md-1">
       <button v-on:click="send" id="message-button" class="btn btn-primary">
         <i class="fa fa-paper-plane" aria-hidden="true"></i>
       </button>
    </div>
  </div>
</template>

<script>
  export default{
    data: function(){
      return {
        content: '',
        actionCable: null
      }
    },
    created: function(){
       const action = ActionCable.createConsumer()
       const saveMessage = this.saveMessage;
       const functions = {
           send_message(text, userId) {
               if (text.replace(/\s/g, '').length > 0) {
                   saveMessage()
                   this.perform('speak', {
                       message: text,
                       token: userId
                   });
               }
           }
       }
      this.actionCable = action.subscriptions.create(
        { channel: "ChatChannel", room: this.$route.query.roomId },
        functions
      )
    },
    methods: {
      send(){
        let userId = sessionStorage.getItem('token');
        this.actionCable.send_message(this.content,userId)
        this.content = ''
      },
      saveMessage(){
        this.$http.post('/messages', {
            token: sessionStorage.getItem('token'),
            room_id: this.$route.query.roomId,
            content: this.content
        });
      }
    }
  }
</script>

<style>
.chat-bar{
  background: #f7f7f7;
  padding: 10px;
}

.send-message-button button{
  height: 50px;
  font-size: 16px;
  width: 100%;
}

input {
  resize: none;
  width: 100%;
  height: 50px;
  -webkit-box-sizing: border-box;
  -moz-box-sizing: border-box;
  box-sizing: border-box;
  padding: 12px;
  border: 1px solid lightgrey;
}
</style>
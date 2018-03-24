<template>
    <div class="modal fade" ref="vuemodal" id="addRoomModal" tabindex="-1" role="dialog" aria-labelledby="addRoomModalLabel" aria-hidden="true">
      <div class="modal-dialog" role="document">
        <div class="modal-content">
          <div class="modal-header">
            <button type="button" class="close" data-dismiss="modal" aria-label="Close">
              <span aria-hidden="true">&times;</span>
            </button>
            <h4 class="modal-title" id="addRoomModalLabel">Add room</h4>
          </div>
          <validation-errors :message="errors"/>
          <div class="modal-body">
            <input type="text" v-model="roomname" class="form-control" placeholder="My room" />
          </div>
          <div class="modal-footer">
             <button v-on:click="save" class="btn btn-primary">Save</button> 
          </div>
        </div>
      </div>
    </div>
</template>

<script>
  import validationErrors from './validationErrors';
  export default {
    data: function(){
      return {
        roomname: '',
        errors:[],
      }
    },
    methods:{
      save(){
        this.$http.post('/rooms', {
            name: this.roomname
         }).then(function(response){
             this.$parent.getRooms();
             $('#addRoomModal').modal('hide')
         }, function(response){
             this.errors = response.body['errors'];
         });
      },
      clearFields(){
         this.roomname = ''
         this.errors = []
      }
    },
    mounted: function(){
         $(this.$refs.vuemodal).on("hidden.bs.modal", this.clearFields)
    },
    components:{
      'validation-errors': validationErrors
    }
  }
</script>
<template>
   <div v-if="message.length > 0" class="alert alert-secondary" role="alert">
     <p>Please, Check following errors</p>
     <ul>
      <li v-for="errorMessage in message">
       {{ errorMessage }}
      </li>
     </ul>
  </div>
</template>

<style>
.alert{
    position: relative;
    padding: .75rem 1.25rem;
    margin-bottom: 1rem;
    border: 1px solid transparent;
    border-radius: .25rem;
}

.alert-secondary{
    color: #721c24;
    background-color: #f8d7da;
    border-color: #f5c6cb;
}
</style>

<script>
  export default {
    props: ['message']
  }
</script>
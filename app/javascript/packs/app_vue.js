/* eslint no-console: 0 */
// Run this example by adding <%= javascript_pack_tag 'hello_vue' %> (and
// <%= stylesheet_pack_tag 'hello_vue' %> if you have styles in your component)
// to the head of your layout file,
// like app/views/layouts/application.html.erb.
// All it does is render <div>Hello Vue</div> at the bottom of the page.

//import Vue from 'vue'
import Vue from 'vue/dist/vue.esm'
import VueRouter from 'vue-router'
import VueResource from 'vue-resource'
import Login from '../modules/login'
import Chat from '../modules/chat'
import Rooms from '../modules/rooms'

Vue.use(VueRouter)
Vue.use(VueResource)

const routes = [
  {path: "/", component: Login },
  {path: "/chat", name:"chat", component: Chat },
  {path: "/rooms", component: Rooms },
]

const router = new VueRouter({routes})

router.beforeEach((to, from, next) => {

   if(to.path == "/chat" || to.path == "/rooms"){
      Vue.http.get('/users/' + sessionStorage.getItem('token')).then(
        function(response){
          next();
        },function(response){
          next("/");
        }
      );
   }

   next();
});

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    router
  }).$mount('#app')
})


// The above code uses Vue without the compiler, which means you cannot
// use Vue to target elements in your existing html templates. You would
// need to always use single file components.
// To be able to target elements in your existing html/erb templates,
// comment out the above code and uncomment the below
// Add <%= javascript_pack_tag 'hello_vue' %> to your layout
// Then add this markup to your html template:
//
// <div id='hello'>
//   {{message}}
//   <app></app>
// </div>


// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// document.addEventListener('DOMContentLoaded', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })
//
//
//
// If the using turbolinks, install 'vue-turbolinks':
//
// yarn add 'vue-turbolinks'
//
// Then uncomment the code block below:
//
// import TurbolinksAdapter from 'vue-turbolinks';
// import Vue from 'vue/dist/vue.esm'
// import App from '../app.vue'
//
// Vue.use(TurbolinksAdapter)
//
// document.addEventListener('turbolinks:load', () => {
//   const app = new Vue({
//     el: '#hello',
//     data: {
//       message: "Can you say hello?"
//     },
//     components: { App }
//   })
// })

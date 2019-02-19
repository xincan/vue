
import Vue from 'vue';
import ElementUI from 'element-ui';
import router from './router/routers';

import 'font-awesome/css/font-awesome.css';
import 'element-ui/lib/theme-chalk/index.css';
import '../static/css/xincan.scss';

import App from './App';

Vue.use(ElementUI);

new Vue({
  el: '#app'
  ,router
  ,render: h => h(App)
});

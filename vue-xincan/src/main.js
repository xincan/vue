
import Vue from 'vue';
import ElementUI from 'element-ui';
import router from './router/routers';
import {get,post,patch,put} from './config/http'


import 'font-awesome/css/font-awesome.css';
import 'element-ui/lib/theme-chalk/index.css';
import './assets/css/hatech.scss';

import App from './App';

//定义全局变量
Vue.prototype.$get = get;
Vue.prototype.$post = post;
Vue.prototype.$patch = patch;
Vue.prototype.$put = put;

Vue.use(ElementUI);

new Vue({
  el: '#app'
  ,router
  ,render: h => h(App)
});

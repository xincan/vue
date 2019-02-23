import Vue from 'vue';
import VueRouter from 'vue-router';

import Controller from "../components/main/Controller";
import Dashboard from "@/dashbord/Dashboard";
import Comment from "@/xincan/Comment";
import Button from "@/xincan/comments/Button";
import Table from "@/xincan/comments/Table";
import TopBottomPanel from "@/xincan/comments/TopBottomPanel";
import LeftRightPanel1 from "@/xincan/comments/LeftRightPanel1";
import LeftRightPanel2 from "@/xincan/comments/LeftRightPanel2";



Vue.use(VueRouter);

const routes = [{
    path: '/dashboard'
    ,component: Dashboard
},{
    path: '/controller'
    ,component: Controller
},{
    path: '/comment'
    ,component: Comment
    ,children: [{
        path: '/button'
        ,component: Button
    }, {
        path: '/table'
        ,component: Table
    }, {
        path: '/topBottomPanel'
        ,component: TopBottomPanel
    }, {
        path: '/leftRightPanel1'
        ,component: LeftRightPanel1
    }, {
        path: '/leftRightPanel2'
        ,component: LeftRightPanel2
    }]
}, {
    path: '*',
    redirect: '/dashboard'
}];

export default new VueRouter({ routes });

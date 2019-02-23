import Vue from 'vue';
import VueRouter from 'vue-router';

import Dashboard from "@/dashbord/Dashboard";
import Controller from "../components/controller/CenterController";
import Comment from "@/components/controller/PluginController";
import Button from "@/xincan/comments/Button";
import Table from "@/xincan/comments/Table";
import TopBottomPanel from "@/xincan/comments/TopBottomPanel";
import LeftRightPanel1 from "@/xincan/comments/LeftRightPanel1";
import LeftRightPanel2 from "@/xincan/comments/LeftRightPanel2";
import AreaManage from "@/warn/manager/AreaManage";
import MenuManage from "@/warn/manager/MenuManage";
import UserManage from "@/warn/manager/UserManage";
import RoleManage from "@/warn/manager/RoleManage";
import PermissionManage from "@/warn/manager/PermissionManage";



Vue.use(VueRouter);

const routes = [{
    path: '/dashboard'
    ,component: Dashboard
},{
    path: '/controller'
    ,component: Controller
    ,children: [{
        path: '/areaManage'
        ,component: AreaManage
    }, {
        path: '/menuManage'
        ,component: MenuManage
    }, {
        path: '/userManage'
        ,component: UserManage
    }, {
        path: '/roleManage'
        ,component: RoleManage
    }, {
        path: '/permissionManage'
        ,component: PermissionManage
    }]
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

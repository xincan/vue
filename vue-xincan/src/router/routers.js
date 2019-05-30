import Vue from 'vue';
import VueRouter from 'vue-router';

import Dashboard from "@/dashbord/Dashboard";
import Controller from "../components/controller/CenterController";
import AreaManage from "@/warn/manager/AreaManage";
import MenuManage from "@/warn/manager/MenuManage";
import UserManage from "@/warn/manager/UserManage";
import RoleManage from "@/warn/manager/RoleManage";
import PermissionManage from "@/warn/manager/PermissionManage";

import Plugin from "@/components/controller/PluginController";
import Button from "@/xincan/comments/Button";
import Table from "@/xincan/comments/Table";
import Panel from "@/xincan/comments/Panel";
import AlwaysPanel from "@/xincan/comments/AlwaysPanel";
import TablePlugin from "@/xincan/comments/TablePlugin";
import Select from "@/xincan/comments/Select";
import Icon from "@/xincan/comments/Icon";
import Area from "@/xincan/comments/Area";
import Flow from "@/xincan/comments/Flow";
import Editor from "@/xincan/comments/Editor";




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
    path: '/plugin'
    ,component: Plugin
    ,children: [{
        path: '/table'
        ,component: Table
    }, {
        path: '/table/plugin'
        ,component: TablePlugin
    },{
        path: '/panel'
        ,component: Panel
    },{
      path: '/always/panel'
      ,component: AlwaysPanel
    },{
        path: '/button'
        ,component: Button
    },{
        path: '/select'
        ,component: Select
    },{
      path: '/icon'
      ,component: Icon
    },{
      path: '/area'
      ,component: Area
    },{
      path: '/flow'
      ,component: Flow
    },{
      path: '/editor'
      ,component: Editor
    }]
}, {
    path: '/',
    redirect: '/dashboard'
}];

export default new VueRouter({ routes });

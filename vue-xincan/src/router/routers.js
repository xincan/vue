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
import Manager from "@/xincan/edit/Manager";
import Editor from "@/xincan/edit/Editor";

import Message from "@/xincan/comments/Message";


Vue.use(VueRouter);

const routes = [{
    path: '/dashboard'
    ,component: Dashboard
},{
    path: '/controller'
    ,component: Controller
    ,children: [{
        path: '/warn/manager/areaManage'
        ,component: AreaManage
    }, {
        path: '/warn/manager/menuManage'
        ,component: MenuManage
    }, {
        path: '/warn/manager/userManage'
        ,component: UserManage
    }, {
        path: '/warn/manager/roleManage'
        ,component: RoleManage
    }, {
        path: '/warn/manager/permissionManage'
        ,component: PermissionManage
    }]
},{
    path: '/plugin'
    ,component: Plugin
    ,children: [{
        path: '/xincan/comments/table'
        ,component: Table
    }, {
        path: '/xincan/comments/table/plugin'
        ,component: TablePlugin
    },{
        path: '/xincan/comments/panel'
        ,component: Panel
    },{
        path: '/xincan/comments/always/panel'
        ,component: AlwaysPanel
    },{
        path: '/xincan/comments/button'
        ,component: Button
    },{
        path: '/xincan/comments/select'
        ,component: Select
    },{
      path: '/xincan/comments/icon'
      ,component: Icon
    },{
      path: '/xincan/comments/area'
      ,component: Area
    },{
      path: '/xincan/comments/flow'
      ,component: Flow
    },{
      path: '/xincan/edit/manager'
      ,component: Manager
    },{
      path: '/xincan/edit/editor'
      ,component: Editor
    },{
      path: '/xincan/message/manager'
      ,component: Message
    }]
}, {
    path: '/',
    redirect: '/dashboard'
}];

export default new VueRouter({ routes });

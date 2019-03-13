
<!--
  头部导航栏
-->

<template>
    <div id="header">
        <div class="header-left"><span>{{title}}</span></div>
        <div class="header-center">
            <ul>
                <!--遍历选择后系统的一级菜单-->
                <li v-for="(menu, key) in menus" :class="active === key ? 'active' : ''" @click="haderMenuClick(key, menu)" v-text="menu.name" ></li>
            </ul>
        </div>
        <div class="header-right">
            <ul>
                <li>
                    <!--遍历系统-->
                    <el-select v-model="defaultSelectSystem" placeholder="请选择" @change="controllChange">
                        <el-option v-for="option in controll" :key="option.id" :label="option.label" :value="option.id" ></el-option>
                    </el-select>
                </li>
                <li>百里长风</li>
                <li>退出</li>
            </ul>
        </div>
    </div>
</template>

<script>

  export default {
      name: "Header"
      ,props:{
          app: Object // 存放父级菜单对象
      }
      ,data() {
          return {
            title: "IStorM DRaaS"
            ,controll: [{
                id: 1
                ,label: 'DEMO展示'
                ,path: '/dashboard'
                ,child:[{
                    id: 11
                    ,name: '首页'
                    ,path: '/dashboard'
                },{
                    id: 12
                    ,name: '中控中心'
                    ,path: '/controller'
                    ,child: [{
                        id: 121
                        ,name: '系统管理'
                        ,icon: 'fa-home'
                        ,path: ''
                        ,child: [
                             {id: 1211 ,name: '地区管理', icon: 'fa-globe',    path: '/areaManage'}
                            ,{id: 1212 ,name: '菜单管理', icon: 'fa-bars',     path: '/menuManage'}
                            ,{id: 1213 ,name: '用户管理', icon: 'fa-user-o',   path: '/userManage'}
                            ,{id: 1214 ,name: '角色管理', icon: 'fa-user-md',  path: '/roleManage'}
                            ,{id: 1215 ,name: '权限管理', icon: 'fa-home',     path: '/permissionManage'}
                        ]
                    },{
                        id: 122
                        ,name: '辅助决策'
                        ,icon: 'fa-cube'
                        ,path: '/policy'
                        ,child: []
                    },{
                        id: 123
                        ,name: '预警发布'
                        ,icon: 'fa-exclamation-triangle'
                        ,path: '/publish'
                        ,child: [
                           {id: 1231 ,name: '预警编辑', icon: 'fa-user-md',   path: '/warnEdit'}
                          ,{id: 1232 ,name: '预警配置', icon: 'fa-user-md',  path: '/warnConfig'}
                        ]
                    }]
                },{
                    id: 13
                    ,name: '组件中心'
                    ,path: '/comment'
                    ,child: [{
                        id: 131
                        ,name: '组件管理'
                        ,icon: 'fa-home'
                        ,path: ''
                        ,child: [
                           {id: 1311 ,name: '表格', icon: 'fa-globe',    path: '/table'}
                          ,{id: 1312 ,name: '表格封装', icon: 'fa-globe',    path: '/table/plugin'}
                          ,{id: 1312 ,name: '下拉列表', icon: 'fa-globe',    path: '/select'}
                          ,{id: 1313 ,name: '按钮', icon: 'fa-globe',    path: '/button'}
                        ]
                    },{
                        id: 132
                        ,name: '面板管理'
                        ,icon: 'fa-home'
                        ,path: ''
                        ,child: [
                           {id: 1321 ,name: '上下布局', icon: 'fa-home',    path: '/topBottomPanel'}
                          ,{id: 1322 ,name: '左右布局', icon: 'fa-home',    path: '/leftRightPanel'}
                        ]
                    }]
                }]
            },{
                id: 2
                ,label: '控制中心'
                ,path: '/dashboard'
                ,child:[
                     {id: 21 ,name: '首页' , path: '/dashboard'}
                    ,{id: 22 ,name: '预警中心' , path: '/dashboard'}
                    ,{id: 23 ,name: '场景切换' , path: '/dashboard'}
                    ,{id: 24 ,name: '系统管理' , path: '/dashboard'}
                    ,{id: 25 ,name: '数据管理' , path: '/dashboard'}
                    ,{id: 26 ,name: '资源管理' , path: '/dashboard'}
                    ,{id: 27 ,name: '灾备管理' , path: '/dashboard'}
                ]
             },{
                id: 3
                ,label: '灾备中心'
                ,path: '/dashboard'
             },{
                id: 4
                ,label: '切换中心'
                ,path: '/dashboard'
             }]
            ,menus: []              // 存放选中系统所有菜单
            ,defaultSelectSystem:1  // 右侧中控中心下拉列表中，默认选中第一个数据
            ,active:0               // 添加路由菜单选中，取消选中样式
          }
      }
      ,mounted(){
          // 默认加载第一个系统
          this.controllChange(this.defaultSelectSystem);
      }
      ,methods: {
          /**
           * 右侧下拉控制台，选择系统
           * @Method controlBtn
           */
          controllChange(option) {
              this.menus = this.controll.slice(option-1, option)[0].child;  // 获取选中系统下标对应的所有菜单
          }

          /**
           * 头部一级菜单点击显示
           * @Method controlBtn
           */
          ,haderMenuClick(key, menu) {
              if(this.active === key) return;         // 判断重复点击一级菜单，拦截
              this.active = key;
              this.app.setParentMenus(menu.child);    // 将当前一级菜单下的所有其他菜单传递到父级容器
              this.$router.push({path: menu.path});   // 进行路由跳转
          }
      }
  }
</script>

<style scoped lang="scss">
    @import "../../assets/css/header";
</style>

<template>
    <div id="header">
        <div class="header-left"><span>{{title}}</span></div>
        <div class="header-center">
            <ul>
                <li v-for="(menu, key) in menus" :class="active === key ? 'active' : ''" @click="haderMenuClick(key, menu)" v-text="menu.name" ></li>
            </ul>
        </div>
        <div class="header-right">
            <ul>
                <li>
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
          app: Object
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
                          ,{id: 1312 ,name: '按钮', icon: 'fa-globe',    path: '/button'}
                        ]
                    },{
                        id: 132
                        ,name: '面板管理'
                        ,icon: 'fa-home'
                        ,path: ''
                        ,child: [
                           {id: 1321 ,name: '上下布局', icon: 'fa-home',    path: '/topBottomPanel'}
                          ,{id: 1322 ,name: '左右布局1', icon: 'fa-home',    path: '/leftRightPanel1'}
                          ,{id: 1323 ,name: '左右布局2', icon: 'fa-home',    path: '/leftRightPanel2'}
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
            ,menus: []
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
              this.menus = this.controll.slice(option-1, option)[0].child;
          }

          /**
           * 头部一级菜单点击显示
           * @Method controlBtn
           */
          ,haderMenuClick(key, menu) {
              this.active = key;
              this.app.getMenus(menu.child); // 将当前一级菜单下的所有其他菜单传递到父级容器
              this.$router.push({path: menu.path});
          }
      }
  }
</script>

<style scoped lang="scss">

    #header{

        & .active {
            background: #1dc7bf;
        }

        position: fixed;
        z-index: 9999999;
        font-size: 14px;
        color: white;
        width:100%;
        height: 40px;
        line-height: 40px;
        display: inline-flex;
        background: black;
        flex-direction: row;

        & .header-right ul,
        & .header-center ul{
            padding: 0;
            margin: 0;
            & li{
                padding: 0;
                list-style: none;
                float: left;
                cursor: pointer;
            }
        }
        // 头部左侧样式
        & .header-left {
            width: 20%;
            & > span{
              background: -webkit-gradient(linear, left top, right top, from(#23efc9), to(#ff00b1));
              background: linear-gradient(to right, #23efc9, #ff00b1);
              -webkit-background-clip: text;
              color: transparent;
              margin-left: 10px;
              font-size: 22px;
              font-weight: bold;
            }
        }
        // 头部中间样式
        & .header-center {
            width: 55%;
            line-height: 40px;
            text-align: center;
            & ul li {
                padding: 0 10px;
                margin-left: 1px;
                & > a {
                  color: white;
                  text-decoration: none;
                }
                &:hover {
                    background: #1dc7bf;
                }
            }
        }
        // 头部右侧样式
        & .header-right {
            width: 25%;
            & ul{
                float: right;
                clear: left;
                & li:nth-child(2),
                & li:nth-child(3) {
                  padding: 0 10px;
                  &:hover {
                      background: #1dc7bf;
                  }
                }
            }
            // 修改elementui select 样式
            & /deep/ {
                .el-select {
                    & input {
                        font-size: 14px;
                        width: 110px;
                        background: black;
                        border: none;
                        border-radius: 0;
                        color: white;
                        padding-left: 10px!important;
                        &:hover{
                            background: #1dc7bf;
                        }
                    }
                    & .el-input {
                        & .el-select__caret {
                            color: white;
                            padding: 0 5px;
                        }
                    }
                    & .el-select-dropdown__item.selected {
                        color: #1dc7bf;
                        font-weight: bold;
                    }
                }
            }
        }
    }

</style>


<!--
  左侧导航
  <router-link :to="nav.path">{{nav.name}}</router-link>
-->

<template>
    <div id="navigation">
        <ul>
            <!--
            <li class="active" @click="isHidden(1)">
                <span><i class="fa fa-home" />&nbsp;&nbsp;系统管理</span>
                <span><i class="fa fa-angle-up"></i></span>
                <div class="child is-hide">
                    <ul>
                        <li class="active"  @click.stop="isHidden(2)">
                            <span><i class="fa fa-home" />&nbsp;&nbsp;基础管理</span><span></span>
                        </li>
                        <li  @click.stop="isHidden(2)">
                            <span><i class="fa fa-home" />&nbsp;&nbsp;用户管理</span><span></span>
                        </li>
                        <li  @click.stop="isHidden(2)">
                            <span><i class="fa fa-home" />&nbsp;&nbsp;角色管理</span><span></span>
                        </li>
                        <li  @click.stop="isHidden(2)">
                            <span><i class="fa fa-home" />&nbsp;&nbsp;权限管理</span><span></span>
                        </li>
                    </ul>
                </div>
            </li>
            <li  @click="isHidden(1)">
                <span class="nav-title"><i class="fa fa-home" />&nbsp;&nbsp;辅助决策</span>
                <span class="nav-option"><i class="fa fa-angle-down"></i></span>
            </li>
            <li  @click="isHidden(1)">
                <span class="nav-title"><i class="fa fa-home" />&nbsp;&nbsp;预警编辑</span>
                <span class="nav-option"><i class="fa fa-angle-down"></i></span>
            </li>
            -->

            <li
              v-for="(nav,key) in navigation"
              :class=" key === pKey ? 'active' : ''"
              @click="clickParentBtn(nav, key)"
            >
                <span><i :class="'fa ' + nav.icon" />&nbsp;&nbsp;{{ nav.name }}</span>
                <span v-if="nav.child.length > 0">
                    <i :class="'fa ' + (key === pKey ? 'fa-angle-up' : 'fa-angle-down')" />
                </span>
                <span v-if="key === pKey && nav.child.length == 0">
                    <i :class="'fa fa-caret-left caret'" />
                </span>

                <div :class="'child ' + (key === pKey ? ' is-show' : 'is-hide')" v-if="nav.child.length > 0" >
                    <ul>
                        <li
                            :class="index === cKey ? 'active' : ''"
                            v-for="(child, index) in nav.child"
                            @click.stop="clickChildBtn(child, index)"
                        >
                            <span><i :class="'fa ' + child.icon" />&nbsp;&nbsp;{{ child.name }}</span>
                            <span><i :class="'fa ' + (index === cKey ? 'fa-caret-left caret' : '')" /></span>
                        </li>
                    </ul>
                </div>

            </li>

        </ul>
    </div>
</template>

<script>

  export default {

      name: "Navigation"

      ,data() {
          return {
            // navigation: [
            //    { id: 1 ,name: '按钮', path: '/button'}
            //   ,{ id: 2 ,name: '表格', path: '/table'}
            // ]
              navigation: [{
                  id: 1
                  ,name: '系统管理'
                  ,icon: 'fa-home'
                  ,path: ''
                  ,child: [
                       { id: 11 ,name: '地区管理', icon: 'fa-globe',    path: '/areaManage'}
                      ,{ id: 12 ,name: '菜单管理', icon: 'fa-bars',     path: '/menuManage'}
                      ,{ id: 13 ,name: '用户管理', icon: 'fa-user-o',   path: '/userManage'}
                      ,{ id: 14 ,name: '角色管理', icon: 'fa-user-md',  path: '/roleManage'}
                      ,{ id: 15 ,name: '权限管理', icon: 'fa-home',     path: '/permissionManage'}

                  ]},{
                      id: 2
                      ,name: '辅助决策'
                      ,icon: 'fa-cube'
                      ,path: '/policy'
                      ,child: []
                  },{
                      id: 3
                      ,name: '预警发布'
                      ,icon: 'fa-exclamation-triangle'
                      ,path: '/publish'
                      ,child: [
                          { id: 31 ,name: '预警编辑', icon: 'fa-user-md',   path: '/warnEdit'}
                          ,{ id: 32 ,name: '预警配置', icon: 'fa-user-md',  path: '/warnConfig'}
                      ]
              }]
              ,pKey: 0  // 系统默认自动展开选中第一个一级菜单
              ,cKey: 0  // 系统默认自动选中第一个一级菜单下的第一个二级菜单
          }
      }

      ,methods: {

          // 左侧一级菜单点击事件
          clickParentBtn(menu, key){
              this.pKey = key;    // 点击一级菜单：改变当前点击菜单的下标
              this.cKey = 0;      // 默认展示第一个二级菜单
          }

          // 左侧二级菜单点击事件
          ,clickChildBtn(menu, index){
              this.cKey = index;  // 点击二级菜单：改变当前点击二级菜单的下标
          }
      }
  }
</script>

<style scoped lang="scss">



    #navigation{

        & .is-hide {
            overflow: hidden;
            max-height: 0;
            -webkit-transition: max-height .3s;
            transition: max-height .3s;
        }

        & .is-show {
            max-height: 400px;
            overflow: hidden;
            -webkit-transition: max-height 1s;
            transition: max-height 1s;
        }

        font-size: 12px;

        & li {
            list-style: none;
            & i {
                font-size: 16px;
            }
        }

        & ul {
            padding: 0;
            margin: 0;
            & li {
                clear: both;
                cursor: pointer;
                margin-top: 1px;
                &.active {
                    background: #113131;
                    &:hover {
                      background: #113131;
                    }
                }
                &:hover {
                  background: #113131;
                }
                & > span {
                    position: relative;
                    display: inline-block;
                    line-height: 30px;
                    padding-left: 10px;
                    color: white;
                    &:nth-child(2) {
                        float: right;
                        margin-right: 10px;
                    }

                    & .caret {
                      position: absolute;
                      right: -10px;
                      top: 7px;
                      color: #EAEAEA;
                    }

                }
                & div.child ul li {
                    padding-left: 20px;
                    cursor: pointer;
                    &:hover {
                        background: #2e9e98;
                    }
                    &.active {
                        background: #2e9e98;
                    }
                }
            }
        }
    }

</style>

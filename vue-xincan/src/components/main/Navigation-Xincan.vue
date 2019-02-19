
<!--
  左侧导航
  <router-link :to="nav.path">{{nav.name}}</router-link>
-->

<template>
    <div id="navigation-xincan">
        <ul>

            <li
              v-for="(nav,key) in navigation"
              :class=" key === pKey ? 'active' : ''"
              @click="clickParentBtn(nav, key)"
            >
                <span><i :class="'fa ' + nav.icon" />&nbsp;&nbsp;{{ nav.name }}</span>
                <span v-if="nav.child.length > 0">
                    <i :class="'fa ' + (key === pKey ? 'fa-angle-up' : 'fa-angle-down')" />
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

      name: "Navigation-Xincan"

      ,data() {
          return {
              navigation: [{
                  id: 1
                  ,name: '组件管理'
                  ,icon: 'fa-home'
                  ,path: ''
                  ,child: [
                       { id: 11 ,name: '表格', icon: 'fa-globe',    path: '/table'}
                      ,{ id: 12 ,name: '按钮', icon: 'fa-globe',    path: '/button'}
                  ]
              },{
                id: 1
                ,name: '面板管理'
                ,icon: 'fa-home'
                ,path: ''
                ,child: [
                  { id: 11 ,name: '上下布局', icon: 'fa-home',    path: '/topBottomPanel'}
                  ,{ id: 12 ,name: '左右布局1', icon: 'fa-home',    path: '/leftRightPanel1'}
                  ,{ id: 13 ,name: '左右布局2', icon: 'fa-home',    path: '/leftRightPanel2'}
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
              this.$router.push({path: menu.path});
          }
      }
  }
</script>

<style scoped lang="scss">

    #navigation-xincan{

        & .is-hide {
            display: none;
        }

        & .is-show {
          display: block;
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
                    background: #081919;
                    &:hover {
                      background: #081919;
                    }
                }
                &:hover {
                  background: #081919;
                }
                & > span {
                    position: relative;
                    display: inline-block;
                    line-height: 35px;
                    padding-left: 10px;
                    color: white;
                    &:nth-child(2) {
                        float: right;
                        margin-right: 10px;
                    }

                    & .caret {
                      position: absolute;
                      right: -10px;
                      top: 10px;
                      color: #EAEAEA;
                    }

                }
                & div.child ul li {
                    padding-left: 20px;
                    cursor: pointer;
                    &:hover {
                        background: #1c6763;
                    }
                    &.active {
                        background: #1c6763;
                    }
                }
            }
        }
    }

</style>

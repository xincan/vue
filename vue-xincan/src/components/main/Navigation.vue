
<!--
  左侧导航
-->

<template>
    <div id="navigation">
        <ul>
            <li
              v-for="(nav,key) in menus"
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

      /**
       *  组件名称
       */
      name: "Navigation"

      /**
       * 用于父子组件传值、或接收值
       */
      ,props:{
          controller: Object
          ,menus: Array
      }

      ,data() {
          return {
              pKey: 0  // 系统默认自动展开选中第一个一级菜单
              ,cKey: 0  // 系统默认自动选中第一个一级菜单下的第一个二级菜单
          }
      }

      ,mounted() {

      }
      ,methods: {

          /**
           * 左侧一级菜单点击事件
           * @Method controlBtn
           */
          clickParentBtn(menu, key){
              // 点击一级菜单：改变当前点击菜单的下标
              this.pKey = key;
              // 默认展示第一个二级菜单
              this.cKey = 0;
          }

          //
          /**
           * 左侧二级菜单点击事件
           * @Method controlBtn
           */
          ,clickChildBtn(menu, index){
              // 点击二级菜单：改变当前点击二级菜单的下标
              this.cKey = index;
              // 触发路由跳转
              this.$router.push({path: menu.path});
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

        padding: 0;
        margin: 0;
        overflow: hidden;
        height: 100%;
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
            width: 182px;
            overflow-y: scroll;
            overflow-x: hidden;
            height: 100%;

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

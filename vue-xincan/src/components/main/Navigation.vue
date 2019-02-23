
<!--
  左侧导航栏
-->

<template>
    <div id="navigation">
        <ul>
            <li v-for="(nav,key) in menus" :class=" key === pKey ? 'active' : ''" @click="clickParentBtn(nav, key)" >

                <span><i :class="'fa ' + nav.icon" />&nbsp;&nbsp;{{ nav.name }}</span>

                <span v-if="nav.child.length > 0"><i :class="'fa ' + (key === pKey ? 'fa-angle-up' : 'fa-angle-down')" /></span>

                <span v-if="key === pKey && nav.child.length == 0"><i :class="'fa fa-caret-left caret'" /></span>

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
              pKey: 0   // 系统默认自动展开选中第一个一级菜单
              ,cKey: 0  // 系统默认自动选中第一个一级菜单下的第一个二级菜单
          }
      }
      ,created(){

      }
      ,mounted() {
          // 如果菜单为空，自动跳转到首页，
          if(this.menus.langth==0 ){
            this.$router.push({path: "/"}); // 触发路由跳转
          }else{
              if(this.menus[0]){
                this.$router.push({path: this.menus[0].child[0].path}); // 触发路由跳转
              }else{
                this.$router.push({path: "/"}); // 触发路由跳转
              }
          }
      }
      ,methods: {

          /**
           * 左侧一级菜单点击事件
           * @Method controlBtn
           */
          clickParentBtn(menu, key){

              this.pKey = key;        // 点击一级菜单：改变当前点击菜单的下标

              this.cKey = 0;          // 默认展示第一个二级菜单

          }

          /**
           * 左侧二级菜单点击事件
           * @Method controlBtn
           */
          ,clickChildBtn(menu, index){

              this.cKey = index;                    // 点击二级菜单：改变当前点击二级菜单的下标

              this.$router.push({path: menu.path}); // 触发路由跳转
          }
      }
  }
</script>

<style scoped lang="scss">
    @import "../../../static/css/navigation";
</style>

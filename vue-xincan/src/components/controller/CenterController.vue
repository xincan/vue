
<!--
    中控中心一级菜单跳转controller
-->

<template>

    <div id="CenterController" class="content">

        <div class="content-left">
            <!--
              引用导航组件
              :menus="menus"        将当前组件作为父组件menus变量传入Navigation子组件，使之子组件能够获取父组件menus数据
              :controller="this"    将当前组件作为父组件this对象传入Navigation子组件，使之子组件能够调用父组件所有变量、方法、函数
            -->
            <Navigation :menus="menus" :controller="this" />
        </div>

        <div class="content-right">
            <!--
              引用Vue路由
            -->
            <router-view />
        </div>

    </div>

</template>

<script>

    // 引入导航组件
    import Navigation from "../main/Navigation";

    export default {

        /**
         * 当前组件名称
         * @Author Xincan
         */
        name: "CenterController"

        /**
         * 组件注册中心
         * 注册导航组件
         * @Author Xincan
         */
        ,components: {Navigation}

        /**
         * 组件之间数据传输
         * @Author Xincan
         */
        ,props:{
            app: Object     // 父类组件中，将自己设置父类组件中的一个标签，app其实是该标签的一个属性，用于子组件能够调用父类所有数据、属性、函数、对象，实际上是父类的this对象
            ,menus: Array   // 父类组件中，将自己设置父类组件中的一个标签，menus其实是该标签的一个属性，实际上是一个数组
        }

        ,data(){
            return {

            }
        }

        ,mounted() {

        }
    }
</script>

<style scoped lang="scss">
  @import "../../assets/css/controller";
</style>

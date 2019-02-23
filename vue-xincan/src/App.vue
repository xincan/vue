<template>
  <div id="app">
    <Header :app="this" />
    <router-view :menus="menus" :app="this" />
  </div>
</template>

<script>
import Header from "@/components/main/Header";
export default {
    name: 'App'
    ,components: {Header}
    ,data(){
        return {
           menus:[]
        }
    }
    ,methods: {
        getMenus(menus){
            this.menus = menus;
        }
    }
}
</script>

<style scoped lang="scss">
</style>

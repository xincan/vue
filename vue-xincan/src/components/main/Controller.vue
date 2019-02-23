
<template>

    <div id="Controller" class="content">

        <div class="content-left">
            <Navigation :menus="menus" :controller="this" />
        </div>

        <div class="content-right">
            <router-view />
        </div>

    </div>

</template>

<script>
    import Navigation from "@/components/main/Navigation";
    export default {
        components: {Navigation}
        ,name: "Controller"
        ,props:{
            app: Object
            ,menus:Array
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
  @import "../../../static/css/navigation";
</style>

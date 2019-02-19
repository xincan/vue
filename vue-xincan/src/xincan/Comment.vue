<template>
    <div class="comment">
        <div class="comment-left">
            <NavigationXincan />
        </div>

        <div class="comment-right">
            <router-view />
        </div>
    </div>
</template>

<script>
    import NavigationXincan from "@/components/main/Navigation-Xincan";
    export default {
        name: "Comment"
        , components: {NavigationXincan}
        ,menus: [

        ]
    }
</script>

<style scoped lang="scss">
    .comment {
        min-height: calc(100% - 40px);
        display: flex;
        display: -webkit-flex;
        flex-direction: row;
        & .comment-left {
            width: 165px;
            background: black;
        }
        & .comment-right {
          width: calc(100% - 165px);
          background: #f7f5f5;
        }
    }
</style>

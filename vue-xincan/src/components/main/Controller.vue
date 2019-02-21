<template>
    <div class="comment">
        <div class="comment-left">
            <Navigation />
        </div>

        <div class="comment-right">
            <router-view />
        </div>
    </div>
</template>

<script>
    import Navigation from "@/components/main/Navigation";
    export default {
        name: "Comment"
        ,components: {Navigation},
        menus: [

        ]
    }
</script>

<style scoped lang="scss">
    .comment {
        height: 100%;
        display: flex;
        display: -webkit-flex;
        flex-direction: row;
        overflow: auto;
        overflow-x: hidden;
        & .comment-left {
            position: fixed;
            z-index: 9999999;
            top: 40px;
            width: 165px;
            height: calc(100% - 40px);
            background: black;
        }
        & .comment-right {
            margin-left: 165px;
            margin-top: 40px;
            width: calc(100% - 165px);
            background: #f7f5f5;
        }
    }
</style>

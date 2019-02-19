
<!--左右布局1-->

<template>
    <div class="hatech">
        <div class="hatech-panel"></div>
        <div class="hatech-panel"></div>
    </div>
</template>

<script>
    export default {
        name: "LeftRightPanel"
    }
</script>

<style scoped lang="scss">
    .hatech {
        display:flex;
        display: -webkit-flex;
        flex-direction: row;
        flex-wrap: wrap;
        height: 100%;
        justify-content: space-between;
        & .hatech-panel{
            flex: 3;
            -webkit-flex: 3;
            margin: 5px;
            padding: 10px;
            background: #5BBBBB;
            &:last-child {
                flex: 9;
                -webkit-flex: 9;
                margin-left: 0px;
            }
        }
    }
</style>

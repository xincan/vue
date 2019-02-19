
<!--上下布局-->

<template>
    <div class="hatech">
        <div class="hatech-panel"></div>
        <div class="hatech-panel"></div>
    </div>
</template>

<script>
    export default {
        name: "TopBottomPanel"
    }
</script>

<style scoped lang="scss">
    .hatech {
        display:flex;
        display: -webkit-flex;
        flex-direction: column;
        flex-wrap: wrap;
        height: 100%;
        & .hatech-panel{
            flex: 1;
            -webkit-flex: 1;
            margin: 5px;
            padding: 10px;
            background: white;
            background: #5BBBBB;
            &:last-child {
                flex: 11;
                -webkit-flex: 11;
                margin-top: 0px;
            }
        }
    }
</style>

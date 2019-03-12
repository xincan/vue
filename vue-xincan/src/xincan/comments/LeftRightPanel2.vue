
<!--左右布局2-->

<template>
    <!--<div class="hatech">-->

        <!--<div class="hatech-panel">-->
          <!--<div class="hatech-panel-item">adsf</div>-->
          <!--<div class="hatech-panel-item">dasf</div>-->
          <!--<div class="hatech-panel-item">sadf</div>-->
        <!--</div>-->

        <!--<div class="hatech-panel">-->
          <!--<div class="hatech-panel-item">sdaf</div>-->
          <!--<div class="hatech-panel-item">dsaf</div>-->
        <!--</div>-->
      <!--<div class="hatech-panel">-->
        <!--<div class="hatech-panel-item">sdaf</div>-->
        <!--<div class="hatech-panel-item">dsaf</div>-->
        <!--<div class="hatech-panel-item">sdaf</div>-->
        <!--<div class="hatech-panel-item">dsaf</div>-->
        <!--<div class="hatech-panel-item">sdaf</div>-->
      <!--</div>-->
    <!--</div>-->

    <div class="scss">
        <div class="scss-item scss-cell-2">

            <div></div>

        </div>
        <div class="scss-item scss-cell-10">
          <div></div>

        </div>
    </div>
</template>

<script>
    export default {
        name: "LeftRightPanel"
    }
</script>

<style scoped lang="scss">

    @import "../../../static/css/mixin/function";

    .hatech {

        height: 100%;
        & .hatech-panel{
            display:flex;
            display: -webkit-flex;
            flex-direction: row;
            flex-wrap: wrap;
            padding: 5px 5px 0px 5px;
            justify-content:space-between;
            flex: 12;
            &:first-child{
                margin-top: 5px;
            }
            & .hatech-panel-item {
                flex: 3;
                -webkit-flex: 3;
                margin: 0 5px;
                background: #5BBBBB;
            }
        }
    }



    // 系统十二栅格布局
    @for $i from 1 through 12 {
        .scss-cell-#{$i} {
            width: calc((100% / 12 * #{$i}));
        }
    }

    .scss{
        display: inline-block;
        width: 100%;
        height: 100%;
        & .scss-item {
            display: inline-block;
            float: left;
            box-sizing: border-box;
            height: 100%;
            text-align: center;
            @include box-boder-radius(0%);
            &:last-child {
                margin-right: 0px;
            }
            & div{
                display: inline-block;
                width: calc(100% - 5px);
                height: 100%;
                background: $scss-background-color;
            }
        }
    }
</style>

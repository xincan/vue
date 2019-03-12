
<!--左右布局-->

<template>
  <div class="scss">
    <div class="scss-item scss-cell-10">
      <div></div>
    </div>
    <div class="scss-item scss-cell-2">
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


<!--左右布局-->

<template>
  <div class="hatech">
    <div class="hatech-item hatech-cell-3">
      <div></div>
    </div>
    <div class="hatech-item hatech-cell-3">
      <div></div>
    </div>
    <div class="hatech-item hatech-cell-3">
      <div></div>
    </div>
    <div class="hatech-item hatech-cell-3">
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
  .hatech{
    display: inline-block;
    width: 100%;
    height: 100%;
    & .hatech-item {
      display: inline-block;
      height: 100%;
      margin-right: 10px;
      float: left;
      box-sizing: border-box;
      -webkit-box-sizing: border-box;
      -o-box-sizing: border-box;
      -ws--box-sizing: border-box;
      -moz-box-sizing: border-box;
      &:first-child{
          margin-left: 5px;
      }
      &:last-child{
          margin-right: 0px;
      }
      & div{
        display: inline-block;
        width: 100%;
        height: 100%;
        border-radius: 4px;
        background: hotpink;
      }
    }
  }
</style>

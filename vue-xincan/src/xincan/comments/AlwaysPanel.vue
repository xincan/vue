
<!--左右布局-->

<template>
  <div class="hatech">

      <div class="hatech-row">

        <div class="hatech-item hatech-cell-3 left"></div>

        <div class="hatech-item hatech-cell-9 right">

          <div class="hatech-row" style="height: 100%">

            <div class="hatech-item hatech-cell-12 hatech-pmw" style="height:calc(20% - 5px);background: #62b4ff"></div>
            <div class="hatech-item hatech-cell-12 hatech-pmw" style="height:calc(80% - 5px); margin-top:10px;background: #ffc05d"></div>

          </div>

        </div>

      </div>
  </div>
</template>

<script>
  export default {
    name: "LeftRightPanel"
  }
</script>

<style scoped lang="scss">
  .left{
    background: #1d21ff;

  }

  .right{
    /*background: burlywood;*/
  }
</style>

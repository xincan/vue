
<!--左右布局-->

<template>
  <div class="hatech">


    <el-row :gutter="10">
        <el-col :xs="8" :sm="6" :md="4" :lg="3" :xl="1">
            <div class="grid-content bg-purple"></div>
        </el-col>
        <el-col :xs="4" :sm="6" :md="8" :lg="9" :xl="11">
            <div class="grid-content bg-purple-light"></div>
        </el-col>
        <el-col :xs="4" :sm="6" :md="8" :lg="9" :xl="11">
            <div class="grid-content bg-purple"></div>
        </el-col>
        <el-col :xs="8" :sm="6" :md="4" :lg="3" :xl="1">
            <div class="grid-content bg-purple-light"></div>
        </el-col>
    </el-row>

      <div class="hatech-row">

          <div class="hatech-item hatech-cell-3" style="background: #1d21ff"></div>

          <div class="hatech-item hatech-cell-9" >

              <div class="hatech-row">

                  <div class="hatech-item hatech-cell-12 hatech-pmw" style="height:calc(20%);background: #62b4ff"></div>
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
  .el-row{
      margin: 5px 0px!important;
  }
  .bg-purple-dark {
    background: #99a9bf;
  }
  .bg-purple {
    background: #d3dce6;
  }
  .bg-purple-light {
    background: #e5e9f2;
  }
  .grid-content {
    min-height: calc(100px - 5px * 2);
  }
</style>

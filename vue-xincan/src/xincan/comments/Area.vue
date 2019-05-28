
<!--上下布局-->

<template>
    <div id="Area" class="hatech">
      <div class="hatech-row">
          <div class="hatech-item hatech-cell-9 chart-area-left">
            <div class="hatech-item-header">
              <div class="hatech-item-header-title">
                <span><i class="hatech-icon hatech-yanzheng-1"></i>地图展示</span>
              </div>
              <div class="hatech-item-header-option">
                <span><i class="el-icon-bell"></i></span>
                <span><i class="el-icon-picture"></i></span>
                <span><i class="el-icon-close"></i></span>
              </div>
            </div>
            <div class="hatech-item-body" id="area-chart" ></div>
          </div>
          <div class="hatech-item hatech-cell-3 chart-cycle-right">
            <div class="hatech-item-header">
              <div class="hatech-item-header-title">
                <span><i class="hatech-icon hatech-yanzheng-1"></i>恢复情况统计</span>
              </div>
              <div class="hatech-item-header-option">
                <span><i class="el-icon-bell"></i></span>
                <span><i class="el-icon-picture"></i></span>
                <span><i class="el-icon-close"></i></span>
              </div>
            </div>
            <div class="hatech-item-body">
              <span>开始时间：2019年12月12日 12时23分45秒</span>
              <span>执行时间：2019年12月12日 12时23分45秒</span>
              <span>当前时间：2019年12月12日 12时23分45秒</span>
              <div class="area-cycle" id="area-cycle"></div>
              <span>场景名称：2018年中国XX单位灾难恢复切换演练</span>
              <span>恢复描述：2018年中国XX单位灾难恢复切换演练2018年中国XX单位灾难恢复切换演练2018年中国XX单位灾难恢复切换演练2018年中国XX单位灾难恢复切换演练</span>
            </div>

          </div>
          <div class="hatech-item hatech-cell-12 hatech-margin chart-table">

            <div class="hatech-item-header">
              <div class="hatech-item-header-title">
                <span><i class="hatech-icon hatech-yanzheng-1"></i>报表展示</span>
              </div>
              <div class="hatech-item-header-option">
                <span><i class="el-icon-bell"></i></span>
                <span><i class="el-icon-picture"></i></span>
                <span><i class="el-icon-close"></i></span>
              </div>
            </div>
            <div class="hatech-item-body" id="area-table" >
              <template>
                <el-table :data="tableData" border style="width: 100%">
                  <el-table-column prop="name"    label="分支机构名称"></el-table-column>
                  <el-table-column prop="time"    label="恢复时间"></el-table-column>
                  <el-table-column prop="user"    label="负责人"></el-table-column>
                </el-table>
              </template>

            </div>
          </div>
      </div>
    </div>
</template>

<script>

    export default {
        name: "Area"
        ,components:{ }

        ,data(){
            return {
                area: [
                  {
                    bank:'长沙市分行',
                    area:'长沙市',
                    status: 0,
                    createTime: '2019-08-08 12:12:12',
                    endTime: '2019-08-08 12:12:12'
                  },
                  {
                    bank:'昆明市分行',
                    area:'昆明市',
                    status: 0,
                    createTime: '2019-08-08 12:12:12',
                    endTime: '2019-08-08 12:12:12',
                  },
                  {
                    bank:'湖南省分行',
                    area:'湖南省',
                    status: 1,
                    createTime: '2019-08-08 12:12:12',
                    endTime: '2019-08-08 12:12:12',
                  },
                  {
                    bank:'北京市分行',
                    area:'北京市',
                    status: 0,
                    createTime: '2019-08-08 12:12:12',
                    endTime: '2019-08-08 12:12:12',
                  }

                ]
              ,tableData:[
                {
                  name: 'XXX分支机构已恢复',
                  time: '2019年12月12日23时34分34秒',
                  user: '张三'
                },{
                  name: 'XXX分支机构已恢复',
                  time: '2019年12月12日23时34分34秒',
                  user: '张三'
                },{
                  name: 'XXX分支机构已恢复',
                  time: '2019年12月12日23时34分34秒',
                  user: '张三'
                },{
                  name: 'XXX分支机构已恢复',
                  time: '2019年12月12日23时34分34秒',
                  user: '张三'
                },{
                  name: 'XXX分支机构已恢复',
                  time: '2019年12月12日23时34分34秒',
                  user: '张三'
                }
              ]
              ,cycle: [
                  {value:335, name:'未恢复'},
                  {value:1548, name:'已恢复'}
              ]
            }

        }
        ,method(){
        }
        ,mounted(){

            this.$chart.area("area-chart", this.area);

            this.$chart.cycle("area-cycle", this.cycle);
        }
    }
</script>

<style scoped lang="scss">
  .hatech-bg{
      background: #62b4ff;
  }
  .chart-area-left {
    height: 80%!important;
  }
  .chart-cycle-right {
    height: 80%!important;
    & .hatech-item-body {
      & > span {
        display: -webkit-box;
        height: 30px;
        line-height: 30px;
        padding: 0px 10px;
        &:first-child {
          margin-top: 10px;
        }
      }
      & .area-cycle{
        width: 100%;
        height: 50%;
      }
    }
  }
  .chart-table {
    height:auto!important;
  }
</style>

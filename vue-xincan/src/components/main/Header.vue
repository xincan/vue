<template>
    <div id="header">
        <div class="header-left"><span>{{title}}</span></div>
        <div class="header-center">
            <ul>
                <li v-for="(menu, key) in menus" :class="active === key ? 'active' : ''" @click="menuBarBtn(key)">
                  <router-link :to="menu.path">{{menu.name}}</router-link>
                </li>
            </ul>
        </div>
        <div class="header-right">
            <ul>
                <li>
                  <el-select v-model="value" placeholder="请选择" @change="controlBtn">
                    <el-option
                        v-for="option in control"
                        :key="option.value"
                        :label="option.label"
                        :value="option.value" >
                    </el-option>
                  </el-select>
                </li>
                <li>百里长风</li>
                <li>退出</li>
            </ul>
        </div>
    </div>
</template>

<script>

  export default {
      name: "Header"
      ,data() {
          return {
            title: "IStorM DRaaS"
            ,menus: [
               { id: 1 ,name: '首页', path: '/dashboard'}
              ,{ id: 2 ,name: '中控中心', path: '/controller'}
              ,{ id: 2 ,name: '组件中心', path: '/comment'}
            ]
            ,control: [
                 {value: 1, label: 'DEMO展示', path: '/dashboard'}
                ,{value: 2, label: '控制中心', path: '/dashboard'}
                ,{value: 3, label: '灾备中心', path: '/dashboard'}
                ,{value: 4, label: '切换中心', path: '/dashboard'}
            ]
            ,value:1
            ,active:0
          }
      }
      ,methods: {
          controlBtn(option) {
              let checked = this.control.slice(option-1, option)[0].value;
              if(checked === 1){
                  this.menus = [
                     { id: 1 ,name: '首页' , path: '/dashboard'}
                    ,{ id: 2 ,name: '中控中心', path: '/controller'}
                    ,{ id: 2 ,name: '组件中心' , path: '/comment'}
                  ]
              }else if(checked === 2){
                  this.menus = [
                    { id: 1 ,name: '首页' , path: '/dashboard'}
                    ,{ id: 2 ,name: '预警中心' , path: '/dashboard'}
                    ,{ id: 3 ,name: '场景切换' , path: '/dashboard'}
                    ,{ id: 4 ,name: '系统管理' , path: '/dashboard'}
                    ,{ id: 5 ,name: '数据管理' , path: '/dashboard'}
                    ,{ id: 6 ,name: '资源管理' , path: '/dashboard'}
                    ,{ id: 7 ,name: '灾备管理' , path: '/dashboard'}
                  ]
              }
          }
          ,menuBarBtn(key) {
              this.active = key;
          }
      }
  }
</script>

<style scoped lang="scss">

    #header{

        & .active {
            background: #1dc7bf;
        }

        position: fixed;
        z-index: 9999999;
        font-size: 14px;
        color: white;
        width:100%;
        height: 40px;
        line-height: 40px;
        display: inline-flex;
        background: black;
        flex-direction: row;

        & .header-right ul,
        & .header-center ul{
            padding: 0;
            margin: 0;
            & li{
                padding: 0;
                list-style: none;
                float: left;
                cursor: pointer;
            }
        }
        // 头部左侧样式
        & .header-left {
            width: 20%;
            & > span{
              background: -webkit-gradient(linear, left top, right top, from(#23efc9), to(#ff00b1));
              background: linear-gradient(to right, #23efc9, #ff00b1);
              -webkit-background-clip: text;
              color: transparent;
              margin-left: 10px;
              font-size: 22px;
              font-weight: bold;
            }
        }
        // 头部中间样式
        & .header-center {
            width: 55%;
            line-height: 40px;
            text-align: center;
            & ul li {
                padding: 0 10px;
                margin-left: 1px;
                & > a {
                  color: white;
                  text-decoration: none;
                }
                &:hover {
                    background: #1dc7bf;
                }
            }
        }
        // 头部右侧样式
        & .header-right {
            width: 25%;
            & ul{
                float: right;
                clear: left;
                & li:nth-child(2),
                & li:nth-child(3) {
                  padding: 0 10px;
                  &:hover {
                      background: #1dc7bf;
                  }
                }
            }
            // 修改elementui select 样式
            & /deep/ {
                .el-select {
                    & input {
                        font-size: 14px;
                        width: 110px;
                        background: black;
                        border: none;
                        border-radius: 0;
                        color: white;
                        padding-left: 10px!important;
                        &:hover{
                            background: #1dc7bf;
                        }
                    }
                    & .el-input {
                        & .el-select__caret {
                            color: white;
                            padding: 0 5px;
                        }
                    }
                    & .el-select-dropdown__item.selected {
                        color: #1dc7bf;
                        font-weight: bold;
                    }
                }
            }
        }
    }

</style>

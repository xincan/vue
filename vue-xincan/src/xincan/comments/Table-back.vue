<template>

    <div class="hatech">

        <div class="hatech-search">
            <el-form :inline="true" :model="searchData" class="demo-form-inline">

                <el-form-item>
                    <el-input v-model="searchData.user" placeholder="审批人"></el-input>
                </el-form-item>

                <el-form-item>
                  <el-input v-model="searchData.user" placeholder="审批人"></el-input>
                </el-form-item>

                <el-form-item>
                  <el-input v-model="searchData.user" placeholder="审批人"></el-input>
                </el-form-item>

                <el-form-item>
                  <el-input v-model="searchData.user" placeholder="审批人"></el-input>
                </el-form-item>

                <el-form-item>

                    <el-select v-model="searchData.area" placeholder="活动区域">
                      <el-option label="区域一" value="shanghai"></el-option>
                      <el-option label="区域二" value="beijing"></el-option>
                    </el-select>

                </el-form-item>

                <el-form-item>
                    <el-button type="primary" size="mini" @click="onSearch">查询</el-button>
                </el-form-item>

            </el-form>
        </div>

        <div class="hatech-table">
            <div class="hatech-table-header">
                <div class="hatech-table-header-left"><ul><li>{{table.title}}</li></ul></div>
                <div class="hatech-table-header-right" v-if="table.showHeaderOption">
                    <ul>
                        <li title="编辑"><i class="el-icon-edit-outline"></i></li>
                        <li title="上传"><i class="el-icon-upload2"></i></li>
                        <li title="下载"><i class="el-icon-download"></i></li>
                        <li title="删除"><i class="el-icon-delete"></i></li>
                        <li title="显隐列">
                            <el-popover
                              placement="bottom"
                              width="200"
                              trigger="click">
                                <el-checkbox v-for="(column,key) in table.column" :key="key" :checked="column.isHide" :name="column.prop" @change="isShow(column)">{{column.label}}</el-checkbox>
                                <i class="el-icon-menu" slot="reference"></i>
                            </el-popover>
                        </li>
                    </ul>
                </div>
            </div>
            <div class="hatech-table-body">
                <el-table
                  :data="table.data"
                  stripe
                  border
                  size="small"
                  resizable
                  @selection-change="handleSelectionChange"
                >
                    <el-table-column type="selection" header-align="center" align="center" width="40" fixed="left"></el-table-column>

                    <el-table-column
                      v-for = "(column, key) in table.column"
                      v-if="column.isHide"
                      :prop = "column.prop"
                      :label = "column.label"
                      :key="key"
                      :formatter = 'column.formatter'
                      header-align = "center"
                      align = "left"
                      sortable
                      show-overflow-tooltip
                    ></el-table-column>

                    <el-table-column prop="option" v-if="table.showTableOption" header-align="center" align="center" label="操作" fixed="right">
                        <template slot-scope="scope">
                            <i  title="编辑" class="el-icon-edit-outline" @click="editUserOption(scope.$index, scope.row)"></i>
                            <i  title="删除" class="el-icon-delete" @click="deleteUserOption(scope.$index, scope.row)"></i>
                        </template>
                    </el-table-column>
                </el-table>
            </div>
            <div class="hatech-table-footer">
                <el-pagination
                  background=""
                  layout="total, sizes, prev, pager, next, jumper"
                  :current-page="1"
                  :page-sizes="[10, 20, 30, 50]"
                  :page-size="10"
                  :total="table.count"
                  @size-change="handleSizeChange"
                  @current-change="handleCurrentChange"
                >
                </el-pagination>
            </div>
        </div>

        <!-- 编辑用户信息 -->
        <el-dialog custom-class="hatech-dialog" :title="editForm.title" :visible.sync="editForm.dialogFormVisible" :width="editForm.formWidth">
            <div class="hatech-top-line"></div>
            <el-form :model="editForm">

                <el-form-item label="用户名称" :label-width="editForm.formLabelWidth">
                    <el-input v-model="editForm.data.name" autocomplete="off" placeholder="请输入用户名称" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="用户性别" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.sex" autocomplete="off" placeholder="请输入用户性别" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="用户生日" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.date" autocomplete="off" placeholder="请输入用户生日" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="所在省份" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.province" autocomplete="off" placeholder="请输入用户所在省份" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="所在城市" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.city" autocomplete="off" placeholder="请输入用户所在城市" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="详细地址" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.address" autocomplete="off" placeholder="请输入用户详细地址" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>
                <el-form-item label="邮件" :label-width="editForm.formLabelWidth">
                  <el-input v-model="editForm.data.zip" autocomplete="off" placeholder="请输入用户邮件" :style="'width: ' + editForm.formBqWidth"></el-input>
                </el-form-item>

            </el-form>
            <div class="hatech-bottom-line"></div>
            <div slot="footer" class="dialog-footer">
                <el-button type="primary" size="mini" @click="editFormSubmit">确 定</el-button>
                <el-button size="mini" @click="editForm.dialogFormVisible = false">取 消</el-button>
            </div>
        </el-dialog>
    </div>
</template>

<script>
  import LocalStorage from '../../db/storage/LocalStorage';
  import Axios from 'axios';
  import qs from 'qs';

  export default {
      data() {
          return {
              // 表单数据
              searchData:{
                  user: ''
                  ,area: ''
              }
              // 表格数据
              ,table:{
                  title:'用户列表'
                  ,id:''
                  ,column:[]
                  ,data: []                 // 表格数据渲染
                  ,select: []               // 数据多选
                  ,count: 0                 // 当前表格数据总数
                  ,showHeaderOption: true   // 是否显示头部右侧操作按钮
                  ,showTableOption: true    // 是否显示列表右侧操作按钮
              }
              // 表单编辑信息
              ,editForm: {
                  title: '编辑用户信息'
                  ,formWidth: '40%'
                  ,dialogFormVisible: false
                  ,formLabelWidth: '100px'
                  ,formBqWidth: 'calc(100% - 30px)'
                  ,data: {
                      date: ''
                      ,name: ''
                      ,sex:1
                      ,province: ''
                      ,city: ''
                      ,address: ''
                      ,zip: ''
                  }
              }
          }
      }
      ,mounted() {
          this.table.id = 'admin' + '-' + 'user-table'; // 当前登录用户名称（唯一）+ - + 当前表格名称（唯一）可以自定义
          this.table.column = [
              {label:'邮箱',  prop: 'zip',      isHide: true}
              ,{label:'姓名', prop: 'name',     isHide: true}
              ,{label:'性别', prop: 'sex',      isHide: true,  formatter: this.sexFormatter}
              ,{label:'所在省份', prop: 'province', isHide: true}
              ,{label:'所在市区', prop: 'city',     isHide: true}
              ,{label:'地址', prop: 'address',  isHide: true}
              ,{label:'日期', prop: 'date',     isHide: true}
          ];

          this.getCellHide(cell => {
            let newColumn = [], column = this.table.column;
            this.table.column=[];
            for(let clm of column){
              for(let cel of cell){
                if(clm.prop === cel.prop){
                  clm.isHide = cel.isHide;
                  newColumn.push(clm);
                }
              }
            }

            this.$nextTick(()=>{
              this.table.column = newColumn;
            });

            // that.table.column.forEach(item => {
            //       let c = {};
            //       cell.forEach(it => {
            //           if(item.prop == it.prop){
            //               item.isHide = it.isHide;
            //               c = item;
            //           }
            //       });
            //
            //   });

          });


          // localStorage存储方式读取
          // let cell = LocalStorage.selectJSONArray(this.table.id);
          //
          // if(cell != undefined && cell.length > 0){
          //     this.table.column.forEach(item => {
          //         cell.forEach(it => {
          //             if(item.prop === it.prop){
          //                 item.isHide = it.isHide;
          //             }
          //         });
          //     });
          // }

          this.table.data = [
              {date: '2016-05-01', name: '王小虎1', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
              ,{date: '2016-05-02',name: '王小虎2', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
              ,{date: '2016-05-03',name: '王小虎3', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
              ,{date: '2016-05-04',name: '王小虎4', sex:0, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
              ,{date: '2016-05-05',name: '王小虎5', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
              ,{date: '2016-05-06',name: '王小虎6', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
              ,{date: '2016-05-07',name: '王小虎7', sex:0, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
              ,{date: '2016-05-08',name: '王小虎8', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
              ,{date: '2016-05-09',name: '王小虎9', sex:0, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
              ,{date: '2016-05-10',name: '王小虎10',sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
          ];

          this.table.count= 13;
      }

      ,methods: {

          // 促使化读取数据库隐藏列
          getCellHide(callback){
              Axios.get("http://127.0.0.1:3000/select/cell", {
                  params: {
                      name:this.table.id
                  }
              }).then( response => {
                  let cell = JSON.parse(response.data[0].content);
                  callback(cell);
              }).catch( error => {
                  console.log(error);
              });
          }

          /**
           * @Method 每页条数
           */
          ,handleSizeChange(val) {

          }


          /**
           * @Method 当前页
           */
          ,handleCurrentChange(val) {
              if(val === 1){
                  this.table.data = [
                      {date: '2016-05-01', name: '王小虎1', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-02',name: '王小虎2', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-03',name: '王小虎3', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-04',name: '王小虎4', sex:0, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-05',name: '王小虎5', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-06',name: '王小虎6', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-07',name: '王小虎7', sex:0, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-08',name: '王小虎8', sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-09',name: '王小虎9', sex:0, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-10',name: '王小虎10',sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                  ];
              }else if(val === 2){
                  this.table.data = [
                      {date: '2016-05-11',name: '王小虎12',sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-12',name: '王小虎13',sex:0, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                      ,{date: '2016-05-13',name: '王小虎14',sex:1, province: '上海',city: '普陀区',address: '上海市普陀区金沙江路 1518 弄',zip: 200333}
                  ];
              }
          }

          /**
           * @Method 列表格式化
           */
          ,sexFormatter(row, column, cellValue, index){
              return row.sex === 1 ? "男" : "女";
          }

          /**
           * @Method checkbox多选
           */
          ,handleSelectionChange(val){
              this.table.select = val;
          }

          ,onSearch(){
              alert("头部查询");
          }

          /**
           * @Method 修改
           */
          ,editUserOption(index, row) {
              this.editForm.data = row;
              this.editForm.dialogFormVisible = true;

          }
          ,editFormSubmit(){

              this.editForm.dialogFormVisible = false;
          }

          /**
           * @Method 删除
           */
          ,deleteUserOption(index, row) {
              console.log(index, row);
          }

          /**
           * @Method 显隐列操作
           */
          ,isShow(column) {
              let cellHide = [], cellString='';
              this.table.column.forEach( cell => {
                  if( cell.prop === column.prop){
                      cell.isHide = !column.isHide;
                  }
                  // localStorage存储方式，写入：数据准备
                  // cellHide.push({prop:cell.prop, isHide: cell.isHide});
                  cellString += ',' + '{"prop":\"' + cell.prop + '\", "isHide\": ' + cell.isHide + '}';
              });

              // localStorage存储方式，写入
              // if(window.localStorage){
              //   LocalStorage.saveJSONArray(this.table.id,cellHide);
              // }


              Axios.get("http://127.0.0.1:3000/update/status", {
                params: {
                  name:this.table.id
                  ,content: "["+cellString.substr(1)+"]"
                }
              }).then(function (response) {
                  console.log(response.data);
              }).catch(function (error) {
                  console.log(error);
              });

          }
      }
  }
</script>


<style scoped lang="scss">
    @import "../../../static/css/table";
    @import "../../../static/css/dialog";
</style>

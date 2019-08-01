
<!--上下布局-->

<template>

    <div id="Edit" class="hatech">

        <div class="hatech-row hatech-edit">

            <div class="hatech-item hatech-cell-2" >

                <div class="hatech-item-header">
                    <div class="hatech-item-header-title">
                        <span><i class="hatech-icon hatech-yanzheng-1"></i>预案分类</span>
                    </div>
                    <div class="hatech-item-header-option">
                        <span><i class="el-icon-plus"></i></span>
                        <span><i class="el-icon-edit"></i></span>
                        <span><i class="el-icon-delete"></i></span>
                    </div>
                </div>

                <div class="hatech-item-body">
                    <el-input placeholder="输入关键字进行过滤" v-model="filterText"></el-input>
                    <el-tree class="filter-tree" :data="treeData" :props="defaultProps" default-expand-all :filter-node-method="findNode" ref="planTree"></el-tree>
                </div>

            </div>

            <div class="hatech-item hatech-cell-10" >

              <div class="hatech-item-header">
                  <div class="hatech-item-header-title">
                      <span><i class="hatech-icon hatech-yanzheng-1"></i>数据筛选</span>
                  </div>
              </div>

              <div class="hatech-item-body">

                  <HatechTable
                    ref="hatechTable"
                    :hatechTable="this"
                    :table="table"
                  >
                      <!--
                          按条件查询模块
                          slot="hatech-search"   slot:表示table组件中的插槽 hatech-search：表示插槽名称，又称为具名插槽：必写项
                      -->
                      <div slot="hatech-search" class="hatech-search">
                          <el-form :inline="true" :model="table.search" class="demo-form-inline">
                              <el-form-item><el-input v-model="table.search.loginName" placeholder="请输入登录名称"></el-input></el-form-item>
                              <el-form-item><el-input v-model="table.search.name" placeholder="请输入用户名称"></el-input></el-form-item>
                              <el-form-item>
                                  <el-select v-model="table.search.sex" placeholder="请选择性别">
                                      <el-option label="请选择性别" value=""></el-option>
                                      <el-option label="男" value="1"></el-option>
                                      <el-option label="女" value="0"></el-option>
                                  </el-select>
                              </el-form-item>
                              <el-form-item><el-input v-model="table.search.areaId" placeholder="请出入用户所在地区"></el-input></el-form-item>
                              <el-form-item><el-input v-model="table.search.organizationId" placeholder="请输入用户所属机构"></el-input></el-form-item>
                              <el-form-item>
                                  <el-button type="primary" size="small" @click="onTableSearch" icon="el-icon-search">查询</el-button>
                                  <el-button type="warning" size="small" @click="onTableReset" icon="el-icon-delete">清空</el-button>
                              </el-form-item>
                          </el-form>
                      </div>

                  </HatechTable>

              </div>

            </div>

        </div>

    </div>

</template>

<script>

  // 引用同创表格插件
  import HatechTable from '@/components/table/Hatech-Table';

    export default {

        name: "Edit"
        ,components:{ HatechTable }

        ,data(){
            return {
              filterText: '',
              treeData: [],
              defaultProps: {
                children: 'children',
                label: 'label'
              }
              ,// 表格信息设置
              table:{
                title:'用户列表'                         // 表格名称
                ,id:'admin' + '-' + 'plan-table'         // 表格ID，系统中表格唯一
                ,autoInit: true                         // 自动加载：true,手动加载false
                ,url:'/api/plan'                         // 数据访问路径
                ,tableWidth:'100%'                       // 表格宽度设定
                ,showCellUrl:'/api/table/find'         // 显隐列读取用户习惯
                ,dropCellUrl:'/api/table/save'         // 拖拽列保存入库路径，记录用户习惯
                ,page:1                                  // 分页，当前页
                ,size:10                                 // 分页，每页默认显示10条数据
                ,sort:{
                  custom: true                          // 开启远程分页
                  ,sortName:"createTime"                       // 分页排序字段名称
                  ,sortType:"DESC"                        // 分页排序方式DESC,ASC
                }
                ,pageSize: [10, 20, 50, 100]             // 分页，设置默认页数
                ,isIndexShow: true                       // 表格编号列显示隐藏设置
                ,data: []                                // 表格数据渲染
                ,select: []                              // 数据多选
                ,count: 0                                // 当前表格数据总数
                ,search:{                                // 查询条件
                }
                ,column: [                               // 表格头部信息、列的显隐设置
                   {label:'预案名称',   prop: 'planName',       width:'auto', isHide: true}
                  ,{label:'版本号',     prop: 'version',        width:'auto', isHide: true}
                  ,{label:'预案分类',   prop: 'typeName',       width:'auto', isHide: true}
                  ,{label:'预案状态',   prop: 'status',         width:'auto', isHide: true}
                  ,{label:'预案描述',   prop: 'description',    width:'auto', isHide: true}
                  ,{label:'更新时间',   prop: 'createTime',       width:'auto', isHide: true}
                ]
                ,showHeaderOption: true                 // 是否显示头部右侧操作按钮
                ,headerOption:[                         // 表格头部操作按钮集合
                  {name:'增加',        icon:'el-icon-plus',       fun:'add',        isShow: true}
                ]
                ,showTableOption: true                  // 是否显示列表右侧操作按钮
                ,cellOptionWidth: 'auto'               // 表格右侧列操作按钮集合宽度
                ,cellOption:[                           // 表格右侧列操作按钮集合
                   {name:'停用',        icon:'el-icon-circle-close',      fun:'stop',  prop:'isAdmin', value:'0',    isShow: true}
                  ,{name:'启用',        icon:'el-icon-circle-check',      fun:'start',  prop:'isAdmin', value:'1',    isShow: true}
                  ,{name:'变更',        icon:'el-icon-printer',           fun:'change',  isShow: true}
                  ,{name:'编辑',        icon:'el-icon-edit',              fun:'edit',    isShow: true}
                  ,{name:'查看',        icon:'el-icon-document',          fun:'detail',  isShow: true}
                  ,{name:'删除',        icon:'el-icon-delete',            fun:'delete',  isShow: true}

                ]
              }
            }
        }

        ,mounted(){

            // 初始化加载预案树
            this.initPlanTree();

        }

        ,methods: {

            /**
             * 加载预案类型树
             * @Method initCellIsHide
             */
            initPlanTree(){
                let that = this;
                this.$get("/api/plan/type", {}).then(response => {
                    that.treeData = response.data;
                });
            },

            /**
             * 模糊搜索节点树数据
             * @Method onTableSearch
             */
            findNode(value, data) {
              if (!value) return true;
              return data.label.indexOf(value) !== -1;
            }

            /**
             * 头部表单：根据自定义条件查询表格数据操作
             * 触发表单查询按钮，通过表单数据查询表格
             * @Method onTableSearch
             */
            ,onTableSearch(){
                this.$refs.hatechTable._initTable();
            }

            /**
             * 头部表单操作
             * 触发表单清空按钮，还原表单数据
             * @Method onTableReset
             */
            ,onTableReset(){
                this.table.search={};
            }

            ,add(){
                this.$router.push({path: "/xincan/edit/editor", params:{}});
            }

        }

        ,watch: {
            filterText(val) {
                this.$refs.planTree.filter(val);
            }
        }
    }
</script>

<style scoped lang="scss">

</style>

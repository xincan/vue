
<!--
    表格插件调用实例
-->

<template>

    <div>
        <HatechTable :table="table" :tableBtn="tableOptionBtn"></HatechTable>
    </div>

</template>

<script>
    import HatechTable from '@/components/table/Hatech-Table'
    export default {
        components:{ HatechTable }
        ,data() {
            return {
                // 表格信息设置
                table:{
                     title:'用户列表'                                  // 表格名称
                    ,id:'admin' + '-' + 'user-table'                  // 表格ID，系统中表格唯一
                    ,url:'http://localhost:3000/user'                 // 数据访问路径
                    ,showCellUrl:'http://localhost:3000/table/select' // 显隐列读取用户习惯
                    ,dropCellUrl:'http://localhost:3000/table/status' // 拖拽列保存入库路径，记录用户习惯
                    ,page:1                                           // 分页，当前页
                    ,size:10                                          // 分页，每页默认显示10条数据
                    ,pageSize: [30, 50, 100, 200]                     // 分页，设置默认页数
                    ,isIndexShow: true                                // 表格编号列显示隐藏设置
                    ,data: []                                         // 表格数据渲染
                    ,select: []                                       // 数据多选
                    ,count: 0                                         // 当前表格数据总数
                    ,param:{                                          // 查询条件
                    }
                    ,column: [                                        // 表格头部信息、列的显隐设置
                         {label:'登录名称',  prop: 'loginName',      width:'auto', isHide: true}
                        ,{label:'登录密码', prop: 'loginPassword',  width:'auto', isHide: true}
                        ,{label:'用户名称', prop: 'name',           width:'auto', isHide: true}
                        ,{label:'用户性别', prop: 'sex',            width:'auto', isHide: true, formatter: this.sexFormatter}
                        ,{label:'用户电话', prop: 'phone',          width:'auto', isHide: true}
                        ,{label:'用户邮箱', prop: 'email',          width:'auto', isHide: true}
                        ,{label:'所属地区', prop: 'areaId',         width:'auto', isHide: true}
                        ,{label:'所属机构', prop: 'organizationId', width:'auto', isHide: true}
                        ,{label:'创建时间', prop: 'createTime',     width:'auto', isHide: true}
                    ]
                    ,showHeaderOption: true             // 是否显示头部右侧操作按钮
                    ,headerOption:[                     // 表格头部操作按钮集合
                         {name:'增加',      icon:'el-icon-edit',       type:'add',            isShow: true}
                        ,{name:'上传',      icon:'el-icon-upload2',    type:'upload',         isShow: false}
                        ,{name:'下载',      icon:'el-icon-download',   type:'download',       isShow: false}
                        ,{name:'批量删除',   icon:'el-icon-delete',     type:'deleteBatch',   isShow: true}
                    ]
                    ,showTableOption: true              // 是否显示列表右侧操作按钮
                    ,cellOption:[                       // 表格右侧列操作按钮集合
                         {name:'修改',      icon:'el-icon-edit',      type:'edit',    isShow: true}
                        ,{name:'查看',      icon:'el-icon-upload2',   type:'upload',  isShow: true}
                        ,{name:'删除',      icon:'el-icon-delete',    type:'delete',  isShow: true}
                    ]
                }

            }
        }
        ,mounted() {


        }

        ,methods: {

            /**
             * 表格列数据格式化
             * 性别格式化
             * @Method sexFormatter
             */
            sexFormatter(row){
                return row.sex === 1 ? "男" : "女";
            }


            ,tableOptionBtn(param){

                let active = {
                    add: result =>{
                      console.log(result);
                    }
                    ,edit: result => {
                      console.log(result);
                    }
                  };
                active[param.type] ? active[param.type].call(this, param) : '';
            }

        }
    }
</script>


<style scoped lang="scss">

</style>

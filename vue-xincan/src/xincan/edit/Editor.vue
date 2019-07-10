
<!--上下布局-->

<template>
    <div id="Edit" class="hatech">
        <div class="hatech-row hatech-edit">

            <div class="hatech-item hatech-cell-3" >

              <div class="hatech-item-header">
                <div class="hatech-item-header-title">
                  <span class="title-menu" @click="baseBtnClick"><i class="hatech-icon hatech-yanzheng-1"></i>基本信息</span>
                </div>

                <div class="hatech-item-header-title">
                  <span class="title-menu" @click="treeBtnClick"><i class="hatech-icon hatech-yanzheng-1"></i>目录大纲</span>
                </div>

                <div v-if="baseData.isTreeShow" class="hatech-item-header-option">
                    <span><i class="el-icon-plus"></i></span>
                    <span><i class="el-icon-edit"></i></span>
                    <span><i class="el-icon-delete"></i></span>
                </div>
              </div>

              <div class="hatech-item-body" v-if="baseData.isBaseShow">
                    基本数据
              </div>

              <div class="hatech-item-body" v-if="baseData.isTreeShow">
                  <el-input placeholder="输入关键字进行过滤" v-model="filterText"></el-input>
                  <el-tree class="filter-tree" :data="treeData" :props="defaultProps" default-expand-all :filter-node-method="findNode" ref="planTree"></el-tree>
              </div>

            </div>

            <div class="hatech-item hatech-cell-9" >

              <div class="hatech-item-header">
                <div class="hatech-item-header-title">
                  <span><i class="hatech-icon hatech-yanzheng-1"></i>策略文档</span>
                </div>
                <div class="hatech-item-header-option">
                  <span><i class="el-icon-plus"></i></span>
                  <span><i class="el-icon-picture"></i></span>
                  <span><i class="el-icon-close"></i></span>
                </div>
              </div>
              <div class="hatech-item-body">

                <div class="hatech-edit-item">
                      <div class="hatech-edit-item-header"></div>
                      <div class="hatech-edit-item-body">

                          <div class="hatech-edit-content" v-for="(item, key) in editor.data" :key="key">
                            <span class="edit-btn">
                              <i class="el-icon-delete"></i>
                              <i class="el-icon-top"></i>
                              <i class="el-icon-bottom"></i>
                            </span>
                            <ul class="content" @click="editorOption('editor' + item.id)">
                              {{item.content}}
                            </ul>
                            <ul :id="'editor' + item.id"></ul>
                          </div>


                      </div>
                      <div class="hatech-edit-item-footer">
                        <button>保存</button>
                        <button>提交</button>
                      </div>

                </div>

              </div>

            </div>

        </div>
    </div>
</template>

<script>


    import HatechEditor from '@/assets/js/editor/hatech-editor.js';

    export default {
        name: "Area"
        ,components:{ }

        ,data(){
            return {
                filterText: '',
                treeData: [],
                defaultProps: {
                  children: 'children',
                  label: 'label'
                }
                ,baseData:{
                  isBaseShow: false,
                  isTreeShow: true
                }

                ,editor: {
                  display: "block",
                  data:[
                    {
                      id:1,
                      content: '锦瑟无端五十弦，一弦一柱思华年'
                    }, {
                      id:2,
                      content: '庄生晓梦迷蝴蝶，望帝春心托杜鹃'
                    }, {
                      id:3,
                      content: '沧海月明珠有泪，蓝田日暖玉生烟'
                    }, {
                      id:4,
                      content: '此情可待成追忆，只是当时已惘然'
                    }
                  ]
                }

            }
        }

        ,mounted(){
            this.initPlanTree();
        }
        ,methods:{

            /**
             * 加载预案类型树
             * @Method initCellIsHide
             */
            initPlanTree(){
              let that = this;
              this.$get("/api/app/word/outline", {}).then(response => {
                that.treeData = response.data;
              });
            }
            ,baseBtnClick(){
              this.baseData.isBaseShow = true;
              this.baseData.isTreeShow = false;
            }

            ,treeBtnClick(){
              this.baseData.isTreeShow = true;
              this.baseData.isBaseShow = false;
            }
            /**
             * 模糊搜索节点树数据
             * @Method onTableSearch
             */
            ,findNode(value, data) {
              if (!value) return true;
              return data.label.indexOf(value) !== -1;
            }

            ,editorOption(editorId){

                let than = this;
                if(this.editor.display === "block"){
                    new HatechEditor({
                        id:'#' + editorId,
                        display: this.editor.display,
                        menus:['screen','save'],
                        save: function (id, dom, content) {
                          than.editor.display = "block";
                        }
                    });
                  than.editor.display = "none";
                }

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


<!--上下布局-->

<template>
    <div class="hatech">
      <el-row :gutter="10">
        <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
          <div class="">
            <el-input v-model="sendMessage" placeholder="请输入内容" size="medium" style="width: 300px"></el-input>
            <el-button size="medium" type="primary" @click="send">发送</el-button>
            <el-button size="medium" type="success" @click="openSocketBtn">重新连接</el-button>
            <el-button size="medium" type="danger" @click="closeSocketBtn">断开连接</el-button>
            <el-input v-model="id" placeholder="请输入内容" size="medium" style="width: 150px"></el-input>
            <el-button size="medium" type="warning" @click="oneSocketBtn">定点发送</el-button>
            <el-button size="medium" type="danger" @click="allSocketBtn">广播发送</el-button>
          </div>
        </el-col>
        <el-col :xs="24" :sm="24" :md="24" :lg="24" :xl="24">
          <div class="hatech-margin">
            <el-input type="textarea" :rows="10" placeholder="请输入内容" v-model="txtMessage" ></el-input>
          </div>
        </el-col>

      </el-row>


    </div>
</template>

<script>

    export default {
      name: 'Message',
      data() {
        return {
          sendMessage: '',                  // 将要发送的信息
          txtMessage: '',                   // 后台返回的数据信息
          path: 'ws://localhost:8040/ws/',  // socket连接地址
          socket: '',                       // 当前socket连接对象
          id: ''                            // 用户id
        }
      },
      mounted() {
        this.createId();      // 生成数据ID
        this.init();          // 初始化加载socket连接
      },

      created() {
      },

      methods: {

        createId: function() {
          let tmp = Date.parse( new Date() ).toString();
          this.id = tmp.substr(0,10);
        },

        init: function() {
          if (typeof (WebSocket) === 'undefined') {
            alert('您的浏览器不支持socket');
          } else {
            console.log("消息发送连接：" + this.id);
            this.socket = new WebSocket(this.path + this.id);   // 实例化socket
            this.socket.onopen = this.open;                     // 监听socket连接
            this.socket.onerror = this.error;                   // 监听socket错误信息
            this.socket.onmessage = this.getMessage;            // 监听socket消息
          }
        },

        // socket连接信息
        open: function() {
          console.log('连接成功');
        },

        // socket报错信息
        error: function() {
          console.log('连接错误');
        },

        // socket返回信息
        getMessage: function(msg) {
          this.txtMessage = this.txtMessage + "\r\n" + msg.data ;
        },

        // socket发送信息
        send: function() {
          let message = this.sendMessage;
          if(message.length === 0){
            alert("请输入内容");
            return false;
          }
          this.socket.send(message);
        },

        // socket关闭
        close: function() {
          this.socket.close();
          console.log('socket已经关闭');
        }

        // 重新连接操作
        , openSocketBtn(){
          this.init();
        }

        //断开连接操作
        , closeSocketBtn(){
          this.socket.close();
          console.log("断开连接");
        }

        // 定点发送
        ,oneSocketBtn(){

          let param = {id: this.id, message: this.sendMessage};

          this.$get("/socket/send/one", param).then(response => {
            console.log(response.msg);
          }).catch(function (error) {});

        }

        // 广播发送
        ,allSocketBtn(){
          let param = {id: this.id, message: this.sendMessage};

          this.$get("/socket/send/all", param).then(response => {
            console.log(response.msg);
          }).catch(function (error) {});
        }

      },
      // 组件销毁
      destroyed() {
        console.log("销毁监听");
        // 销毁监听
        this.socket.onclose = this.close;
      }
    }
</script>

<style scoped lang="scss">

</style>

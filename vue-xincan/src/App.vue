<template>
  <div id="app">
    <Header />
    <router-view/>
  </div>
</template>

<script>
import Header from "@/components/main/Header";
export default {
  name: 'App',
  components: {Header}
}
</script>

<style scoped lang="scss">
</style>

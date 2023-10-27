<template>
  <div class="container">
    <RouterView />
  </div>
</template>

<style>
body {
  display: flex;
  margin: 0;
  line-height: 1.3;
  background-color: #fff;
  font-family: "Noto Sans CJK SC", Avenir, Helvetica, Arial, sans-serif;
  font-size: 16px;
  text-rendering: optimizeLegibility;
  /* max-width: 54rem; */
  /* width: 100%; */
}

#app {
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  /* text-align: center; */
  color: #2c3e50;
  /* max-width: 1280px; */
  width: 800px;
  min-height: 480px;
}

.footer {
  font-weight: 400;
  font-size: 16px;
  margin-top: 30px;
}

.footer-text {
  float: right;
}

.container {
  display: flex;
  flex-flow: column;
  padding: 32px;
  row-gap: 32px;
}

ul {
  margin: 0;
  padding: 0;
}

button {
  cursor: pointer;
}
</style>

<script>
export default {}
</script>

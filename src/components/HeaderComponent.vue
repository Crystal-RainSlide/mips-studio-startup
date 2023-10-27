<template>
  <div class="header">
    <h1 v-if="cn" class="title title-cn">{{ title }}</h1>
    <h1 v-else class="title">{{ title }}</h1>
    <h2 class="subtitle">{{ subtitle }}</h2>
  </div>
</template>

<script>
export default {
  props: ['title', 'subtitle', 'cn']
}
</script>

<style>

.title {
  margin: 0;
  font-size: 48px;
  line-height: 40px;
  color: #705697;
}

.title-cn {
  font-size: 40px;
}

.subtitle {
  margin: 5px 0 0;
  font-size: 16px;
  font-style: normal;
  font-weight: 400;
}

</style>

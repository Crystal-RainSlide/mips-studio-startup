<template>
  <button class="button" :class="{ button_active: selected == index }" @click="select(index)" >
    <a class="button-title">{{ title }}</a>
    <a class="button-subtitle" v-if="selected == index">{{ subtitle }}</a>
  </button>
</template>

<style scoped>
.button {
  display: flex;
  flex-flow: column;
  width: 360px;
  height: 48px;
  padding: 10px 12px;
  background: #EDE8EF;
  border: none;
  font-size: 24px;
  line-height: 1.5;
  text-align: justify;
}

.button-title {
  font-weight: 600;
}

.button-subtitle {
  font-size: 18px;
}

.button_active {
  width: 360px;
  height: 80px;
  background: #D1B6DB;
}

.button:hover {
  background: #E0C5EA;
}
</style>

<script>
export default {
  props: {
    title: String,
    selected: Number,
    index: Number,
    subtitle: String,
  },
  methods: {
    select: function (index) {
      this.$emit("update:selected", index);
    },
  },
}
</script>

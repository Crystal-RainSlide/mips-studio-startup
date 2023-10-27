<template>
  <HeaderComponent title="自定义参数" subtitle="请根据您的需要调整下列参数。" cn=true />
  <div class="main">
    <div class="left">
      <div class="select-container">
        <a class="main-subtitle">工具链</a>
        <SelectLayout name="toolchain" v-model:opts="toolchains" />
      </div>
      <div class="textarea-container">
        <a class="main-subtitle">编译器及汇编选项</a>
        <TextArea v-model:msg="compile_asm_option"/>
        <a class="link">查阅所有可用选项</a>
      </div>
      <div class="textarea-container">
        <a class="main-subtitle">编译器及汇编选项</a>
        <TextArea v-model:msg="linker_options"/>
        <a class="link">查阅所有可用选项</a>
      </div>
    </div>
    <div class="right">
      <div class="select-container">
        <a class="main-subtitle">模板选项</a>
        <SelectLayout name="templates" v-model:opts="toolchains" />
      </div>
      <div class="select-container">
        <a class="main-subtitle">调试器</a>
        <SelectLayout name="debuggerr" v-model:opts="debuggerr" />
      </div>
      <div class="select-containe">
        <a class="main-subtitle">项目构建工具</a>
        <SelectLayout name="builder" v-model:opts="debuggerr" />
      </div>
    </div>
  </div>
  <div class="button-bar">
      <button class="bar-button-continue">完成</button>
      <button class="bar-button-cancel">取消</button>
  </div>
</template>

<script>
import HeaderComponent from '@/components/HeaderComponent.vue';
import SelectLayout from '@/components/SelectLayout.vue';
import TextArea from '@/components/TextArea.vue';

export default {
  components: { HeaderComponent, SelectLayout, TextArea },
  data() {
    return {
      toolchains: ["MTI GCC (11.2.0)"],
      compile_asm_option: ["-EL", "-mhard-float", "-mno-mips16", "-mno-micromips", "-mmcu", "-G 0"],
      linker_options: ["-nostdlib", "-Lldscripts", "-Lldscripts/debug"],
      templates: ["PIC32MZ (CMSIS)"],
      debuggerr: ["OpenOCD"],
      maker: ["unify_builder (EIDE)"]
    }
  }
}
</script>

<style scoped>
.main {
  display: flex;
  flex-flow: row;
  column-gap: 80px;
}

.left {
  display: flex;
  flex-flow: column;
  row-gap: 10px;
}

.right {
  display: flex;
  flex-flow: column;
  row-gap: 10px;
}

.select-container {
  display: flex;
  flex-flow: column;
}

.textarea-container {
  display: flex;
  flex-flow: column;
}

.link {
  color: #705697;
}

.button-bar {
  display: flex;
  flex-flow: row;
  column-gap: 12px;
  align-items: flex-end;
}

.bar-button-continue {
  width: 96px;
  height: 36px;
  background: #D1B6DB;
  border: none;
}

.bar-button-cancel {
  width: 96px;
  height: 36px;
  background: #D6CFE2;
  border: none;
}

button:hover {
  background: #E0C5EA;
}

select:hover {
  background: #E0C5EA;
}
</style>

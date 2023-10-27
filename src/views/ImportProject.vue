<!-- TODO：把 ImportProject 和 NewProject 合成一个？ -->

<template>
  <HeaderComponent title="导入项目向导" subtitle="MIPS Studio 探测到外部项目，需对项目的一些参数进行初始化方可导入项目。
请选择您的项目针对的设备，如果您的设备未在下述列表中，请选择“自定义...”。" cn=true />
  <div class="main">
    <div class="device">
      <a class="main-subtitle">设备类型</a>
      <ul>
        <li v-for="d in deviceList.entries()" :key="d[0]">
          <ListButton v-model:title="d[1].product_name" v-model:selected="selection" v-model:subtitle="d[1].product_chip"
            v-model:index="d[0]" />
        </li>
      </ul>
    </div>
    <div class="config">
      <a class="main-subtitle">配置概要</a>
      <div class="desc">
        <div class="desc-container">
          <a class="desctitle">处理器核心</a>
          <a>{{ deviceList[selection].product_info.core_desc }}</a>
        </div>
        <div class="desc-container">
          <a class="desctitle">指令集架构</a>
          <a>{{ deviceList[selection].product_info.isa_desc }}</a>
        </div>
        <div class="desc-container">
          <a class="desctitle">指令集位宽</a>
          <a>{{ deviceList[selection].product_info.bits }}</a>
        </div>
        <div class="desc-container">
          <a class="desctitle">内存容量</a>
          <a>{{ deviceList[selection].product_info.ram }}</a>
        </div>
        <div class="desc-container">
          <a class="desctitle">工具链类型</a>
          <a>{{ deviceList[selection].toolchain.type_desc }}</a>
        </div>
        <div class="desc-container">
          <a class="desctitle">项目模板</a>
          <a>{{ deviceList[selection].template.template_type[0].name }}</a>
        </div>
      </div>
      <a class="adjust-arg" title="敬请期待…">调整参数</a>
    </div>
  </div>
  <div class="project-path">
    <a class="main-subtitle">项目名称</a>
    <div class="bar">
      <div class="bar-folder">
        <input type="text" id="directory" class="directory" v-model="projectName">
      </div>
      <button class="bar-button-continue"
        @click="extract_template(deviceList[selection].product_chip, projectName, deviceList[selection].template.template_type[0].codespace_filename)">创建项目</button>
      <button class="bar-button-cancel" @click="$router.back()">取消</button>
    </div>
  </div>
</template>

<script>
import HeaderComponent from '@/components/HeaderComponent.vue';
import ListButton from '@/components/ListButton.vue';

import { readStartupJson, newFolderDialog, extractTemplate } from '@/utils';

export default {
  components: { HeaderComponent, ListButton },
  data() {
    return {
      selection: 0,
      deviceList: [readStartupJson()],
      new_folder_dialog: newFolderDialog,
      projectName: '',
    }
  },
  methods: {
    extract_template(name, projectName, workspaceName) {
      const folder = newFolderDialog();
      if (folder) {
        extractTemplate(name, folder, projectName, workspaceName);
      }
    }
  }
}
</script>

<style scoped>
.main {
  display: flex;
  column-gap: 80px;
}

.device, .device ul,
.config, .config .desc {
  display: flex;
  flex-flow: column;
  row-gap: 10px;
}

.config {
  min-width: 275px;
}

.desc .desctitle {
  min-width: 5em;
  font-weight: bold;
}

.desc-container {
  display: flex;
  column-gap: 15px;
}

li {
  list-style: none;
}

.adjust-arg {
  color: #705697;
}

.bar {
  display: flex;
  flex-flow: row;
  column-gap: 12px;
}

.bar-folder {
  flex-grow: 1;
}

.directory {
  display: block;
  width: 100%;
  height: 36px;
  border: none;
  background-color: #D6CFE2;
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

.open-folder {
  width: 21px;
  height: 21px;
}

button:hover {
  background: #E0C5EA;
}
</style>

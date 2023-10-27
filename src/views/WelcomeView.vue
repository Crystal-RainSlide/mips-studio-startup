<template>
  <HeaderComponent title="MIPS Studio" subtitle="一站式 MIPS 集成开发环境" />
  <div class="main">
    <div class="startup">
      <a class="main-subtitle">启动向导</a>
      <button class="button" @click="$router.push({ name: 'newproject' })">
        <img class="button-icon" alt="新建 MIPS Studio 项目" src="@/assets/AddToCollection_16x.svg">
        <a>新建项目</a>
      </button>
      <button class="button" @click="openProject()">
        <img class="button-icon" alt="打开现有项目" src="@/assets/OpenFileFromProject_16x.svg">
        <a>打开项目</a>
      </button>
      <button class="button" @click="openDoc()">
        <img class="button-icon" alt="打开用户文档网站" src="@/assets/CloudSearch_16x.svg">
        <a>查询用户文档</a>
      </button>
    </div>
    <div class="history">
      <a class="main-subtitle">最近项目</a>
      <ul v-if="history">
        <li v-for="[i, entry] in history.entries()" :key="i">
          <a class="link" @click="openDir(entry)">{{ entry }}</a>
        </li>
      </ul>
    </div>
  </div>
  <div class="footer">
    <a class="footer-text">© 2023 上海芯联芯智能科技有限公司</a>
  </div>
</template>

<script>
import path from 'node:path';
import os from 'node:os';
import fse from 'fs-extra';
import { app, shell } from '@electron/remote';

import HeaderComponent from '@/components/HeaderComponent.vue';

import { newFolderDialog, openWithVSC } from '@/utils';

const docUrl = 'https://www.cipunited.com';

// TODO: should be path.join(app.getPath('userData'), 'history')
const historyPath = path.join(os.homedir(), '.mips-studio', 'history');

function getHistory() {
  try {
    // ensureFileSync create file and its parent dir
    fse.ensureFileSync(historyPath);
    return fse.readFileSync(historyPath, { encoding: 'utf8' })
      .split('\n')
      .map(line => line.trim())
      .filter(line => line !== '');
  } catch (e) {
    throw new Error(`${historyPath} can't be created or is not a file`);
  }
}

export default {
  data() {
    return {
      history: getHistory()
    }
  },
  methods: {
    openDoc() {
      shell.openExternal(docUrl)
        // .then(() => console.log('opened!'))
        .catch((reason) => console.error(reason));
    },
    openDir(dir) {
      // TODO: 和 extractTemplate() 里一样，打开 .code-workspace 文件？
      openWithVSC(dir);
    },
    openProject() {

      const dir = newFolderDialog();
      if (dir === undefined) return;

      const eidePath = path.join(dir, '.eide');
      if (fse.existsSync(eidePath)) {

        // .eide dir exists, open it, add to history, exit
        // TODO: 和 extractTemplate() 里一样，打开 .code-workspace 文件？
        openWithVSC(dir);

        // Update history file
        const historyArr = getHistory();
        if (!historyArr.includes(dir)) {
          historyArr.push(dir);
          // outputFileSync = writeFileSync + create parent dir if it does not exist
          fse.outputFileSync(historyPath, historyArr.join('\n'));
        }

        // TODO: 给别的打开 VSC 之后的场景也加上 app.quit()？
        app.quit();

      } else {
        // .eide dir don't exist, goto importproject
        this.$router.push({ name: 'importproject' });
      }
    }
  },
  components: { HeaderComponent },
};

</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
.link {
  color: #705697;
  cursor: pointer;
}

.link:hover {
  text-decoration: underline;
}

.main-subtitle {
  margin-bottom: 16px;
  line-height: 23px;
}

.main {
  display: flex;
  column-gap: 80px;
}

.startup {
  display: flex;
  flex-flow: column;
}

.startup .button {
  display: flex;
  align-items: center;
  column-gap: 15px;
  width: 276px;
  height: 48px;
  margin: 0;
  margin-bottom: 16px;
  background: #EDE8EF;
  border: none;
  text-align: justify;
  font-size: 24px;
  line-height: 1;
}

.button:hover {
  background: #E0C5EA;
}

.history {
  display: flex;
  flex-flow: column;
  min-width: 310px;
}

.history > ul {
  display: flex;
  flex-flow: column;
  margin-left: 20px;
}

.history > ul > li {
  padding-left: 12px;
  list-style: "⯈";
  font-size: 14px;
  line-height: 20px;
}

.button-icon {
  width: 28px;
  margin-left: 9px;
}
</style>

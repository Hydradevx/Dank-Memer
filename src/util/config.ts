import fs from "fs";
import path from "path";
import chalk from "chalk";
import { fileURLToPath } from "url";

const __filename = fileURLToPath(import.meta.url);
const __dirname = path.dirname(__filename);

let rootDir = __dirname;
while (!fs.existsSync(path.join(rootDir, "package.json"))) {
  rootDir = path.dirname(rootDir);

  if (rootDir === "/") break;
}

const configPath = path.join(rootDir, "config.json");

type Config = {
  token: string;
  prefix: string;
};

if (!fs.existsSync(configPath)) {
  console.log(`Please type ${chalk.red("npm run config")} to set up the config!`);
  process.exit();
}

let config: Config = JSON.parse(fs.readFileSync(configPath, "utf-8"));

fs.watch(configPath, (eventType) => {
  if (eventType === "change") {
    try {
      const newConfig = JSON.parse(fs.readFileSync(configPath, "utf-8"));
      config = { ...config, ...newConfig };
      console.log("[CONFIG] 🔁 Reloaded config.json");
    } catch (err) {
      console.error("[CONFIG] ❌ Failed to reload config.json", err);
    }
  }
});

export const getConfig = (): Config => config;
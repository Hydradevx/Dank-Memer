import { getConfig } from "../util/config.js";
import { Client } from "discord.js-selfbot-v13";

let token = getConfig().token;
let prefix = getConfig().prefix;

let dankId = "270904126974590976";

export { dankId };

export const client: any = new Client();

export { token, prefix };
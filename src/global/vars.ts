import { getConfig } from "../util/config";
import { Client } from "discord.js-selfbot-v13";

let token = getConfig().token;
let prefix = getConfig().prefix;

export const client: any = new Client();

export { token, prefix };
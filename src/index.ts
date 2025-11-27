import { token, client, prefix, dankId } from "./global/vars.js";

client.once("ready", () => {
  console.log(`Logged in as ${client.user?.tag}!`);
});

client.on("messageCreate", (message) => {
  if (message.content === prefix + "beg") {
    message.channel.sendSlash(dankId ,"beg");
  }
});

client.login(token);
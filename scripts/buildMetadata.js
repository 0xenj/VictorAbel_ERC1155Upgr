const hre = require("hardhat");
const fs = require("fs");
const path = require("path");

async function main() {
  const currentFolder = path.resolve(__dirname, "../ipfs/");
  const metadata =
    "ipfs://bafybeiardgy2zsoerwqzcfquxdkqsavz2q3rrtlepjp6q6euppsojygyjm";

  console.log("currentFolder", currentFolder);
  if (fs.existsSync(currentFolder)) {
    for (let i = 0; i < 10; i++) {
      const data = {
        title: `ARTbres&Foret #${i}`,
        description: "Victor Abel GAGNE - Collection 1",
        image: `${metadata}/${i}.jpg`,
        type: 1,
        date: Date.now(),
      };

      console.log(
        "\x1b[32m",
        `Building MetaData's for tokenId ${i}`,
        "\x1b[0m"
      );

      fs.writeFileSync(
        currentFolder + `/metadata/${i}.json`,
        JSON.stringify(data, null, 2)
      );
    }
  } else
    throw new Error("Folder metaData/ and metaData/metadata does not exist");

  console.log("\x1b[32m", "Done building ABI's", "\x1b[0m");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

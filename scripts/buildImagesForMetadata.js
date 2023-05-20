const hre = require("hardhat");
const fs = require("fs");
const path = require("path");

async function main() {
  const currentFolder = path.resolve(__dirname, "../ipfs/");

  if (fs.existsSync(currentFolder)) {
    if (fs.existsSync(currentFolder + "/0.jpg")) {
      for (let i = 0; i < 10; i++) {
        console.log("\x1b[32m", `Building Image's for tokenId ${i}`, "\x1b[0m");

        fs.copyFileSync(
          currentFolder + "/0.jpg",
          `${currentFolder}/img/${i}.jpg`
        );
      }
    } else throw new Error("Folder metaData/sample/0.jpg does not exist");
  } else throw new Error("Folder metaData/ and metaData/sample does not exist");

  console.log("\x1b[32m", "Done building ABI's", "\x1b[0m");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

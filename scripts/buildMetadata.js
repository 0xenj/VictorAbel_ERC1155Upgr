const hre = require("hardhat");
const fs = require("fs");
const path = require("path");

async function main() {
  const currentFolder = path.resolve(__dirname, "../ipfs/");
  const metadata =
    "ipfs://bafybeifekbqmc5tipfoil6by5ybjr7ml6bblt5mdx6y5py6mrt4j7axzay";

  console.log("currentFolder", currentFolder);
  if (fs.existsSync(currentFolder)) {
    for (let i = 0; i < 100; i++) {
      const data = {
        name: `(Categories) #`,
        created_by: "Victor Abel",
        description: "(Nom de l'oeuvre) - Collection ARTbres&Forêts 1000/10000",
        image: `${metadata}/${i}.png`,
        print_file: "",
        external_url: "https://artbres-forets.com/",
        type: 1,
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
  } else throw new Error("Folder ipfs/ and ipfs/metadata does not exist");

  console.log("\x1b[32m", "Done building ABI's", "\x1b[0m");
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

const fs = require("fs");
const path = require("path");

const directory = path.resolve(__dirname, "../ipfs/img");
let index = 0;

fs.readdir(directory, (err, files) => {
  if (err) throw err;

  files.forEach((file) => {
    const oldPath = path.join(directory, file);
    const extension = path.extname(file);
    const newFileName = index.toString().padStart(2, "0");
    const newPath = path.join(directory, `${newFileName}${extension}`);
    fs.renameSync(oldPath, newPath);
    console.log(`Renamed ${oldPath} to ${newPath}`);
    index++;
  });
});

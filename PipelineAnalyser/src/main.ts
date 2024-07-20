import dotenv from "dotenv";
import dotenvSafe from "dotenv-safe";

/**
 * The entry point of the program
 * */
function main() {
  const region = process.env["AWS_REGION"];
  console.log(region);
}

dotenv.config();
dotenvSafe.config();

main();

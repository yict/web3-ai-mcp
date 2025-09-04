import hre from "hardhat";

async function main() {
  const [deployer] = await hre.viem.getWalletClients();
  console.log("Deploying with account:", deployer.account.address);

  const token = await hre.viem.deployContract("MyToken");
  console.log("MyToken deployed to:", token.address);

  const name = await token.read.name();
  console.log("Token name:", name);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });

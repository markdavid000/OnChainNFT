import { ethers } from "hardhat";

const main = async () => {
  const onChainNft = "0x6aBD9993f4f086061bB563614D4D51CeA3AF6647";

  const ONCHAINNFT = await ethers.getContractAt("OnchainNFT", onChainNft);

  const createToken = await ONCHAINNFT.mint();

  await createToken.wait();

  console.log(createToken);
};

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});

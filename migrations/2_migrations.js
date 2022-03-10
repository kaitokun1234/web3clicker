const KaiToken = artifacts.require("KaiToken");
const Clicker = artifacts.require("Clicker");

module.exports = async function (deployer) {
  await deployer.deploy(KaiToken);
  const kait = await KaiToken.deployed();
  await deployer.deploy(Clicker, kait.address);
};

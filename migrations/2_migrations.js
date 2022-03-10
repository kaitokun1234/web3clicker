const KaiToken = artifacts.require("KaiToken");

module.exports = function (deployer) {
  deployer.deploy(KaiToken);
};

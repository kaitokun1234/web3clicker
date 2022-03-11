let web3, user, clickerInst, tokenInst, money;

const clickerAddr = "0xf532Aa4d05950C0Eb412f08C7470907ff7967444";
const tokenAddr = "0x0491d0EA5B40AaC0041038ec313AB97a6F0D322b";

var workerPrice;

$(document).ready(async () => {
  if(window.ethereum){
    web3 = new Web3(Web3.givenProvider);
    money = 0;
    console.log("準備完了");
    //posts = await bbsInst.methods.getPosts().call();
  }else{
    alert("メタマスクをインストールしてください");
  }
});

$(".btn.login").click(async () => {
  try{
      const accounts = await window.ethereum.request({
        method: "eth_requestAccounts",
      });
      user = accounts[0];
      $(".btn.login").html(user.slice(0,3)+"…"+user.slice(-3));
      clickerInst = new web3.eth.Contract(abi.clicker, clickerAddr, {from: user});
      tokenInst = new web3.eth.Contract(abi.token, tokenAddr, {from: user});
      workerPrice = towei(10)
  } catch (error){
    alert(error.message);
  }
})

$(".btn.work").click(() => {
  money ++;
  $(".money").html("$"+money);
})

$(".btn.withdraw").click(async () =>{
  await withdraw();
})

async function withdraw(){
  amount = towei(money);
  try{
    await clickerInst.methods.receiveReward(amount).send({from:user});
  }catch(err){
    throw(err);
  }
}

$(".gacha").click(async() => {
  try{
    await tokenInst.methods.approve(clickerAddr, workerPrice).send();
  }catch(err){
    throw(err);
  }

  try{
    var gachaTx = await clickerInst.methods
    .buyEmployee(workerPrice)
    .send({from:user});
    console.log(gachaTx);
  }catch (err){
    throw(err);
  }
})

function towei(raw){
  var wei = web3.utils.toWei(String(raw));
  return wei;
}
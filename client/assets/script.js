let web3, user, clickerInst, tokenInst;
const clickerAddr = "0xf532Aa4d05950C0Eb412f08C7470907ff7967444";
const tokenAddr = "0x0491d0EA5B40AaC0041038ec313AB97a6F0D322b";

$(document).ready(async () => {
  if(window.ethereum){
    web3 = new Web3(Web3.givenProvider);
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
  } catch (error){
    alert(error.message);
  }
})
/*
$(".btn.postBtn").click(async () => {
  var textval = $('#text').val();
  if(textval == "" || !user){
    alert("投稿内容が空白か、ウォレットが接続されていません");
    return;
  }
  try{
    await bbsInst.methods.newPost(textval).send({from:user});
    alert("投稿成功");
  } catch (error){
    alert(error.message);
  }
  location.reload();
})

function listPosts(){
  var div = document.getElementById('posts');
  for (var i = 0; i < posts.length; i++) {
    let dateTime = new Date(posts[i][1] + 1000);
    var parts = 
      '<div class="card">'
          +'<div class="card-body">'
            +'<h6 class="card-subtitle mb-2 text-muted small">'
            + (i+1) +' 名無しさん '+dateTime+'</h6>'
            +'<p class="card-text">'+posts[i][0]+'</p></div></div>';
   div.insertAdjacentHTML('beforeend', parts);
  }
}*/
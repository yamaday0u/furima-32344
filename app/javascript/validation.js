const validation = () => {
  const pricePattern = /^[\A\d+\z]/;
  const priceErrorMessage = document.getElementById("price-error");
  const itemPrice = document.getElementById("item-price");

  addEventListener("keyup", e => {
    if (pricePattern.test(itemPrice.value) || itemPrice.value == "") {//item-priceが半角数字が空白なら
      priceErrorMessage.style.visibility="hidden";
    }else {
      priceErrorMessage.style.visibility="visible";//OKでないならエラーメッセージが表示
    }
  })
}

window.addEventListener("load", validation)
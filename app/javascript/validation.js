if (location.pathname.match("/items/new")) {

  const validation = () => {
  const priceErrorElement = document.getElementById("price-error");
  const itemPrice = document.getElementById("item-price");

  const pricePattern = /^[\A\d+\z]/;

  addEventListener("keyup", e => {
    const errorMessageCharacter = document.getElementById("price-character-error");
    if (pricePattern.test(itemPrice.value) || itemPrice.value == "") {
      if (errorMessageCharacter != null) {
        errorMessageCharacter.remove();
      }
    } else   {
      if (errorMessageCharacter === null) {
        priceErrorElement.insertAdjacentHTML('afterend', '<div id="price-character-error" class="price-error">価格は半角数字で入力してください</div>' );
      }
    }
  });

  const minimumPrice = 300;
  const maximumPrice = 9999999;

  addEventListener("keyup", e => {
    const rangeErrorMessage = document.getElementById("price-range-error");
  if (itemPrice.value < minimumPrice || itemPrice.value > maximumPrice && itemPrice.value != nil ) {
    if (rangeErrorMessage === null) {
      priceErrorElement.insertAdjacentHTML('afterend', '<div id="price-range-error" class="price-error">価格は300〜9,999,999の範囲で設定してください</div>' );
    }
  } else {
    if (rangeErrorMessage != null) {
      rangeErrorMessage.remove();
    }
  }
  });
}

window.addEventListener("load", validation)

}
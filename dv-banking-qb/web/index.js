var mode = "white";
var dark = "#A5C9CA";
var dark1 = "#395B64";
var darkbg = "#2C3333";
var white = "#FBE8DA";
var whitebg = "rgb(245, 242, 242)";

function display(bool) {
    if (bool) {
        $("#body").show();
        $("#container").show();
        $("#page-1").fadeIn();
        $("#logs").hide();
        $("#deposit-show").hide();
        $("#transfer-show").hide();
        $("#withdraw-show").hide();
        $("#sw").hide();
        $("#sd").hide();

        $("#page-2").hide();
    } else {
        $("#logs").hide();
        $("#container").hide();
        $("#withdraw-show").hide();
        $("#deposit-show").hide();
        $("#transfer-show").hide();
        $("#page-2").hide();
        $("#body").hide();
        $("#sw").hide();
        $("#sd").hide();
    }
}

display(false)

function HideAll() {
    display(false)
    $.post('https://dv-banking/exit', JSON.stringify({}));

}

window.addEventListener("message", (event) => {
    var item = event.data;
    console.log(item.type)
    if (item.type === "reload") {
        if (item.icon = ~null) {
            document.getElementById("balancecount").innerHTML = item.bank + "$";
            document.getElementById("name").innerHTML = "Hello, " + item.info;
            document.getElementById("offlinecount").innerHTML = item.logcount;
            document.getElementById("acnumber").innerHTML = item.account;
            document.getElementById("saving-account-balance-number").innerHTML = item.saving + "$";
        }
    }
    if (item.type === "ui") {
        if (item.status == true) {
            console.log("open")
            display(true)
            if (item.icon = ~null) {
                document.getElementById("balancecount").innerHTML = item.bank + "$";
                document.getElementById("name").innerHTML = "Hello, " + item.info;
                document.getElementById("offlinecount").innerHTML = item.logcount;
                document.getElementById("acnumber").innerHTML = item.account;
                document.getElementById("saving-account-balance-number").innerHTML = item.saving + "$";

                const content = $(
                    `        
            <div class="logging" id="logging">
        <div class="logging-icon" id="logging-icon">
            <i class="fa-solid fa-building-columns"></i>
        </div>
        <div class="logging-title" id="logging-title">
            ` + item.name + `
        </div>
        <div class="logging-amount" id="logging-amount">
            ` + item.amount + `$
        </div>
    </div>
        `
                )
                $("#log-list").prepend(content);
            }
        } else {
            display(false)
        }
    }
});

function changeMode() {
    if (mode === "white") {
        document.getElementById("mode-icon").innerHTML = `<i class="fa-solid fa-sun"></i>`;
        mode = "dark";
        document.getElementById("container").style.backgroundColor = darkbg;
        document.getElementById("navigation").style.backgroundColor = dark1;
        document.getElementById("navigation-icons").style.color = "white";
        document.getElementById("main").style.backgroundColor = dark1;
        document.getElementById("actions").style.backgroundColor = dark1;
        document.getElementById("actions").style.color = "white";
        document.getElementById("offline").style.backgroundColor = dark;
        document.getElementById("balance").style.backgroundColor = dark;
        document.getElementById("online").style.backgroundColor = dark;
        document.getElementById("offline").style.color = "white";
        document.getElementById("balance").style.color = "white";
        document.getElementById("online").style.color = "white";
        document.getElementById("button-w").style.backgroundColor = dark;
        document.getElementById("button-d").style.backgroundColor = dark;
        document.getElementById("button-t").style.backgroundColor = dark;
        document.getElementById("button-w").style.color = "white";
        document.getElementById("button-d").style.color = "white";
        document.getElementById("button-t").style.color = "white";
        document.getElementById("name").style.color = "white";

        document.getElementById("saving-account-title").style.color = "white";
        document.getElementById("saving-account").style.backgroundColor = dark1;
        document.getElementById("saving-account-balance").style.backgroundColor = dark;
        document.getElementById("saving-account-balance-number").style.color = "white";
        document.getElementById("saving-account-deposit-button").style.color = "white";
        document.getElementById("saving-account-withdraw-button").style.color = "white";
        document.getElementById("saving-account-deposit-button").style.backgroundColor = dark;
        document.getElementById("saving-account-withdraw-button").style.backgroundColor = dark;

        document.getElementById("log-header").style.backgroundColor = dark1;
        document.getElementById("log-header").style.color = "white";
        document.getElementById("log-container").style.backgroundColor = dark1;
        document.getElementById("log-container").style.backgroundColor = dark1;
        document.getElementById("log-container").style.backgroundColor = dark1;
        changeDark() /* DESING FOR INPUTS*/

        document.getElementById("sd").style.backgroundColor = dark1;
        document.getElementById("sd").style.border = "5px solid #E7F6F2";
        document.getElementById("sd-text").style.color = "white";
        document.getElementById("sd-button").style.backgroundColor = dark;
        document.getElementById("sd-button").style.color = "white";
        document.getElementById("sd-input").style.border = "5px solid" + dark;

        document.getElementById("sw").style.backgroundColor = dark1;
        document.getElementById("sw").style.border = "5px solid #E7F6F2";
        document.getElementById("sw-text").style.color = "white";
        document.getElementById("sw-button").style.backgroundColor = dark;
        document.getElementById("sw-button").style.color = "white";
        document.getElementById("sw-input").style.border = "5px solid" + dark;


        document.getElementById("withdraw-show").style.backgroundColor = dark1;
        document.getElementById("withdraw-show").style.border = "5px solid #E7F6F2";
        document.getElementById("withdraw-show-text").style.color = "white";
        document.getElementById("withdraw-show-button").style.backgroundColor = dark;
        document.getElementById("withdraw-show-button").style.color = "white";
        document.getElementById("withdraw-input").style.border = "5px solid" + dark;


        document.getElementById("deposit-show").style.backgroundColor = dark1;
        document.getElementById("deposit-show").style.border = "5px solid #E7F6F2";
        document.getElementById("deposit-show-text").style.color = "white";
        document.getElementById("deposit-show-button").style.backgroundColor = dark;
        document.getElementById("deposit-show-button").style.color = "white";
        document.getElementById("deposit-input").style.border = "5px solid" + dark;


        document.getElementById("transfer-show").style.backgroundColor = dark1;
        document.getElementById("transfer-show").style.border = "5px solid #E7F6F2";
        document.getElementById("transfer-show-text").style.color = "white";
        document.getElementById("transfer-show-button").style.backgroundColor = dark;
        document.getElementById("transfer-show-button").style.color = "white";
        document.getElementById("transfer-input-ac").style.border = "5px solid" + dark;
        document.getElementById("transfer-input-m").style.border = "5px solid" + dark;


    } else if (mode === "dark") {
        mode = "white";
        document.getElementById("mode-icon").innerHTML = `<i class="fa-solid fa-moon"></i>`;
        document.getElementById("container").style.backgroundColor = whitebg;
        document.getElementById("navigation").style.backgroundColor = "white";
        document.getElementById("navigation-icons").style.color = "black";
        document.getElementById("main").style.backgroundColor = "white";
        document.getElementById("actions").style.backgroundColor = "white";
        document.getElementById("actions").style.color = "black";
        document.getElementById("offline").style.backgroundColor = white;
        document.getElementById("balance").style.backgroundColor = white;
        document.getElementById("online").style.backgroundColor = white;
        document.getElementById("offline").style.color = "black";
        document.getElementById("balance").style.color = "black";
        document.getElementById("online").style.color = "black";
        document.getElementById("button-w").style.backgroundColor = white;
        document.getElementById("button-d").style.backgroundColor = white;
        document.getElementById("button-t").style.backgroundColor = white;
        document.getElementById("button-w").style.color = "black";
        document.getElementById("button-d").style.color = "black";
        document.getElementById("button-t").style.color = "black";
        document.getElementById("name").style.color = "black";
        /*INPUTS */
        document.getElementById("saving-account-title").style.color = "black";
        document.getElementById("saving-account").style.backgroundColor = "white";
        document.getElementById("saving-account-balance").style.backgroundColor = white;
        document.getElementById("saving-account-balance-number").style.color = "black";
        document.getElementById("saving-account-deposit-button").style.color = "black";
        document.getElementById("saving-account-withdraw-button").style.color = "black";
        document.getElementById("saving-account-deposit-button").style.backgroundColor = white;
        document.getElementById("saving-account-withdraw-button").style.backgroundColor = white;

        document.getElementById("log-header").style.color = "black";
        document.getElementById("log-header").style.backgroundColor = "white";
        document.getElementById("log-container").style.backgroundColor = "white";
        changeWhite()

        document.getElementById("sd").style.backgroundColor = "white";
        document.getElementById("sd").style.border = "5px solid gray";
        document.getElementById("sd-text").style.color = "black";
        document.getElementById("sd-button").style.backgroundColor = white;
        document.getElementById("sd-button").style.color = "black";
        document.getElementById("sd-input").style.border = "5px solid" + white;

        document.getElementById("sw").style.backgroundColor = "white";
        document.getElementById("sw").style.border = "5px solid gray";
        document.getElementById("sw-text").style.color = "black";
        document.getElementById("sw-button").style.backgroundColor = white;
        document.getElementById("sw-button").style.color = "black";
        document.getElementById("sw-input").style.border = "5px solid" + white;

        document.getElementById("withdraw-show").style.backgroundColor = "white";
        document.getElementById("withdraw-show").style.border = "5px solid gray";
        document.getElementById("withdraw-show-text").style.color = "black";
        document.getElementById("withdraw-show-button").style.backgroundColor = white;
        document.getElementById("withdraw-show-button").style.color = "black";
        document.getElementById("withdraw-input").style.border = "5px solid" + white;

        document.getElementById("deposit-show").style.backgroundColor = "white";
        document.getElementById("deposit-show").style.border = "5px solid gray";
        document.getElementById("deposit-show-text").style.color = "black";
        document.getElementById("deposit-show-button").style.backgroundColor = white;
        document.getElementById("deposit-show-button").style.color = "black";
        document.getElementById("deposit-input").style.border = "5px solid" + white;

        document.getElementById("transfer-show").style.backgroundColor = "white";
        document.getElementById("transfer-show").style.border = "5px solid gray";
        document.getElementById("transfer-show-text").style.color = "black";
        document.getElementById("transfer-show-button").style.backgroundColor = white;
        document.getElementById("transfer-show-button").style.color = "black";
        document.getElementById("transfer-input-ac").style.border = "5px solid" + white;
        document.getElementById("transfer-input-m").style.border = "5px solid" + white;


    }
}


function changeDark() {
    var elems = document.querySelectorAll("#logging");
    var elems1 = document.querySelectorAll("#logging-icon");
    var elems2 = document.querySelectorAll("#logging-amount");
    var elems3 = document.querySelectorAll("#logging-title");

    var index = 0,
        length = elems.length;
    for (; index < length; index++) {
        elems[index].style.background = dark;
    }
    var index1 = 0,
        length1 = elems1.length;
    for (; index1 < length1; index1++) {
        elems1[index1].style.color = "white";
    }
    var index2 = 0,
        length2 = elems2.length;
    for (; index2 < length2; index2++) {
        elems2[index2].style.color = "white";
    }
    var index3 = 0,
        length3 = elems3.length;
    for (; index3 < length3; index3++) {
        elems3[index3].style.color = "white";
    }
}

function changeWhite() {
    var elems = document.querySelectorAll("#logging");
    var elems1 = document.querySelectorAll("#logging-icon");
    var elems2 = document.querySelectorAll("#logging-amount");
    var elems3 = document.querySelectorAll("#logging-title");

    var index = 0,
        length = elems.length;
    for (; index < length; index++) {
        elems[index].style.background = white;
    }
    var index1 = 0,
        length1 = elems1.length;
    for (; index1 < length1; index1++) {
        elems1[index1].style.color = "black";
    }
    var index2 = 0,
        length2 = elems2.length;
    for (; index2 < length2; index2++) {
        elems2[index2].style.color = "black";
    }
    var index3 = 0,
        length3 = elems3.length;
    for (; index3 < length3; index3++) {
        elems3[index3].style.color = "black";
    }
}

function SavingDeposit() {
    $("#sw").fadeOut();
    $("#sd").fadeIn();
}

function SavingWithdraw() {
    $("#sd").fadeOut();

    $("#sw").fadeIn();
}

function SavingDepositSubmit() {
    $("#sd").fadeOut();
    let money = $("#sd-input").val()
    $.post('https://dv-banking/deposit-saving', JSON.stringify({
        m: money,
    }));
    Reload()
    return
}

function SavingWithdrawSubmit() {
    $("#sw").fadeOut();
    let money = $("#sw-input").val()
    $.post('https://dv-banking/withdraw-saving', JSON.stringify({
        m: money,
    }));
    Reload()
    return
}

function Reload() {
    $.post('https://dv-banking/reload', JSON.stringify({}));
    return
}

function withdraw() {
    $("#deposit-show").fadeOut();
    $("#transfer-show").fadeOut();
    $("#withdraw-show").fadeIn();
}

function Home() {
    $("#page-2").fadeOut();
    $("#logs").fadeOut();
    Reload()
    $("#page-1").fadeIn();
}

function Accounts() {
    $("#logs").fadeOut();
    $("#page-1").fadeOut();
    Reload()
    $("#page-2").fadeIn();
}

function Logs() {
    $("#page-2").fadeOut();
    $("#page-1").fadeOut();
    Reload()
    $("#logs").fadeIn();
}

function deposit() {
    $("#transfer-show").fadeOut();
    $("#withdraw-show").fadeOut();
    $("#deposit-show").fadeIn();
}

function transfer() {
    $("#deposit-show").fadeOut();
    $("#withdraw-show").fadeOut();
    $("#transfer-show").fadeIn();
}

function withdraw() {
    $("#deposit-show").fadeOut();
    $("#transfer-show").fadeOut();
    $("#withdraw-show").fadeIn();
}

function Hide() {
    $("#transfer-show").fadeOut();
    $("#withdraw-show").fadeOut();
    $("#deposit-show").fadeOut();
    Reload()
}

function Withdraw() {
    let money = $("#withdraw-input").val()
    $.post('https://dv-banking/withdraw', JSON.stringify({
        m: money,
    }));
    Hide()
    return
}

function Deposit() {
    let money = $("#deposit-input").val()
    $.post('https://dv-banking/deposit', JSON.stringify({
        m: money,
    }));
    Hide()
    return
}

function Transfer() {
    let money = $("#transfer-input-m").val()
    let ac = $("#transfer-input-ac").val()
    $.post('https://dv-banking/transfer', JSON.stringify({
        target: ac,
        m: money,
    }));
    Hide()
    return
}
window.addEventListener('keydown', function(event) {
    if (event.which == 27)
    HideAll()
})
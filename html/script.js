
let isMenuOpen = false;

function OpenMenu(level, next, exp) {
    $("#main-container, #main-page, #main-page-one, #main-page-two").fadeIn(400);
    $("#main-container").html('');

    var customContent = `
        <div class="main" id="main-container">
            <div class="container-pages" id="main-page">
                <div class="circle">
                    <span class="red box"></span>
                </div>
                <div class="circle">
                    <span class="yellow box"></span>
                </div>
                <div class="circle">
                    <span class="green box"></span>
                </div>
                <div class="customer-details" id="main-page-one">
                    <p>Customer Details: </p>
                    <p id="customerName">Name: Loading...</p>
                    <p id="customerAddress">Address: Loading...</p>
                </div>
                <div class="start-button" onclick="StartDelivery()">Start</div>
                <div class="delivery-guy"></div>

                <div class="stats" id="main-page-two">
                    <p>Level: <span id="level">1</span></p>
                    <p>Next Level in: <span id="level">1</span></p>
                    <p>Experience: <span id="experience">0</span></p>
                </div>
            </div>
        </div>
    `;

    $("#main-container").append(customContent);
    const customButton = `
    <button class="button" onclick="closeMenu()">
        <span class="X"></span>
        <span class="Y"></span>
        <div class="close">Close</div>
    </button>
`;
    $("#main-container").append(customButton);
    const startButton = document.querySelector('.start-button');
    const levelElement = document.getElementById('level');
    const nextlElement = document.getElementById('nextl');
    const experienceElement = document.getElementById('experience');
    const deliveryGuy = document.querySelector('.delivery-guy');
    const customers = [
        { name: "Michael Johnson", address: "789 Grove St" },
        { name: "Trevor Williams", address: "1011 Sandy Shores Ave" },
        { name: "Franklin Davis", address: "131 Vinewood Blvd" },
        { name: "Amanda White", address: "567 Rockford Dr" },
        { name: "Lamar Brown", address: "246 Forum Dr" },
        { name: "Catalina Rodriguez", address: "891 Verdant Bluffs" },
        { name: "Tommy Vercetti", address: "332 Ocean Dr" },
        { name: "Niko Bellic", address: "441 Broker Ave" },
        { name: "Claude Speed", address: "667 Staunton Ave" },
        { name: "CJ Johnson", address: "555 Ganton St" },
        { name: "Natalia Faustin", address: "775 Hove Beach Ave" },
        { name: "Misty Muller", address: "223 Misty Ln" },
        { name: "Roman Petrov", address: "369 Mohawk Ave" },
        { name: "Cesar Hernandez", address: "502 Doherty St" },
        { name: "Brucie Kibbutz", address: "808 Burlesque" },
        { name: "Wade Hebert", address: "212 Paleto Blvd" },
        { name: "Chop Dogg", address: "665 Grove St" },
        { name: "Molly Schultz", address: "999 Eclipse Blvd" },
        { name: "Packie McReary", address: "777 South Mo Milton Dr" },
        { name: "Tracey De Santa", address: "444 Portola Dr" }
    ];

    const randomCustomer = customers[Math.floor(Math.random() * customers.length)];

    document.getElementById('customerName').textContent = `Name: ${randomCustomer.name}`;
    document.getElementById('customerAddress').textContent = `Address: ${randomCustomer.address}`;
    const newLevel = level;
    const newExperience = exp;
    const newEx = next;
    levelElement.textContent = newLevel;
    nextlElement.textContent = newEx;
    experienceElement.textContent = newExperience;
    startButton.addEventListener('click', () => {
        // const newLevel = 5;
        // const newExperience = 150;

        // levelElement.textContent = newLevel;
        // experienceElement.textContent = newExperience;
        StartDelivery()
    });
}

function StartDelivery() {
    $("#main-container").fadeOut(400);
    timeout = setTimeout(function () {
        $("#main-container").html("");
        isMenuOpen = false;
        $.post('https://krs-pizzajob/Start', JSON.stringify({
          }));
    }, 400);

}
function closeMenu() {
    $("#main-container").fadeOut(400);
    timeout = setTimeout(function () {
        $("#main-container").html("");
        isMenuOpen = false;
        $.post('https://krs-pizzajob/CloseUi', JSON.stringify({
          }));
    }, 400);
}

window.addEventListener('message', function (event) {
    var item = event.data;
    if (item.type === 'openNui') {
        var level = item.level
        var nextIn = item.nextIn
        var exp = item.exp
        OpenMenu(level, nextIn, exp);
    } else if (item.type === 'closeNui') {
        closeMenu();
    }
});


let isMenuOpen = false;

function OpenMenu() {
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
    const experienceElement = document.getElementById('experience');
    const deliveryGuy = document.querySelector('.delivery-guy');
    const customers = [
        { name: "John Doe", address: "123 Main St" },
        { name: "Jane Smith", address: "456 Oak St" },
    ];

    const randomCustomer = customers[Math.floor(Math.random() * customers.length)];

    document.getElementById('customerName').textContent = `Name: ${randomCustomer.name}`;
    document.getElementById('customerAddress').textContent = `Address: ${randomCustomer.address}`;

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
        OpenMenu();
    } else if (item.type === 'closeNui') {
        closeMenu();
    }
});

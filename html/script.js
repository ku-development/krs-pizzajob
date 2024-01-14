
let isMenuOpen = false;

function OpenMenu() {
    $("#main-container").fadeIn(400);
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
        const newLevel = 5;
        const newExperience = 150;

        levelElement.textContent = newLevel;
        experienceElement.textContent = newExperience;
    });
}

function closeMenu() {
    console.log('Closing menu...');
    $("#main-container").fadeOut(400);
    timeout = setTimeout(function () {
        $("#main-container").html("");
        console.log('Menu closed.');
        isMenuOpen = false;
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

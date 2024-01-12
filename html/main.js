$(document).ready(function() {
    // Simulated player skills data
    const playerSkills = {
        "Programming": 80,
    };

    // Display player skills with progress bars
    displayPlayerSkills(playerSkills);
});

function displayPlayerSkills(skills) {
    const container = document.getElementById("container");

    // Create a progress bar for each skill
    Object.entries(skills).forEach(([skill, value]) => {
        const progressBar = document.createElement("div");
        progressBar.classList.add("progress-bar");

        const label = document.createElement("span");
        label.textContent = `${skill}: ${value}%`;

        const progress = document.createElement("div");
        progress.style.width = `${value}%`;

        progressBar.appendChild(label);
        progressBar.appendChild(progress);
        container.appendChild(progressBar);
    });
}

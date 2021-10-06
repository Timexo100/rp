const results = document.querySelector("#results-list");
const search = document.querySelector("#app-search");

const render = (query = "") => {
    fetch("data.json")
        .then(response => response.json())
        .then(data => {
            const cleanedupQuery = query.trim().toLowerCase();
            const filtered = Array.from(data).filter(item =>
                item.company_name?.toLowerCase().includes(cleanedupQuery)
            );

            results.innerHTML = "";
            filtered.forEach(item => {
                results.insertAdjacentHTML(
                    "beforeend",
                    `<li>Водитель: ${item.driver_name} </br>
                              Компания: ${item.company_name}</br> 
                              ИНН: ${item.company_inn}</br> 
                              Гос. номер: ${item.car_number} 
                           </li>`
                );
            });
        });
}

// render as the user types
search.addEventListener("keyup", () => {
    render(search.value);
});

// render on page load
render();

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
                    `<li>${item.company_name} / 
                    ИНН: ${item.company_inn}/ 
                    АТИ: ${item.company_ati}/ 
                    Ген.дир: ${item.head_name} 
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
